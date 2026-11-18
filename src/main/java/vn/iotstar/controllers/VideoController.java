package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.model.User;
import vn.iotstar.model.Video;
import vn.iotstar.service.VideoService;
import vn.iotstar.service.impl.VideoServiceImpl;
import vn.iotstar.util.Constant;

// Khai báo các đường dẫn URL sẽ chạy vào Controller này
@WebServlet(urlPatterns = {"/video", "/video/add", "/video/insert", "/video/edit", "/video/update", "/video/delete", "/video/detail"})
// Cấu hình Multipart 
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 50,      // 50MB (Cho phép upload video ngắn)
    maxRequestSize = 1024 * 1024 * 100   // 100MB tổng request
)
public class VideoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // 1. Kiểm tra đăng nhập (Bắt buộc phải có tài khoản mới được quản lý video)
        HttpSession session = req.getSession();
        User account = (User) session.getAttribute("account");
        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2. Điều hướng dựa vào URL
        if (url.contains("add")) {
            // Mở trang thêm video
            req.getRequestDispatcher("/views/video-add.jsp").forward(req, resp);
        } 
        else if (url.contains("edit")) {
            // Mở trang sửa video
            int id = Integer.parseInt(req.getParameter("id"));
            Video video = videoService.findById(id);
            // Bảo mật: Chỉ chủ sở hữu mới được sửa video của mình
            if (video == null || video.getUser().getId() != account.getId()) {
                resp.sendRedirect(req.getContextPath() + "/video");
                return;
            }
            req.setAttribute("vid", video);
            req.getRequestDispatcher("/views/video-edit.jsp").forward(req, resp);
        } 
        else if (url.contains("delete")) {
            // Xử lý xóa video
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                Video video = videoService.findById(id);
                // Bảo mật: Chỉ chủ sở hữu mới được xóa
                if (video != null && video.getUser().getId() == account.getId()) {
                    videoService.delete(id);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/video");
        } 

        else if (url.contains("detail")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Video video = videoService.findById(id);
            if (video != null) {
                // Yêu cầu 4.4: Play video và tăng lượt xem lên 1
                video.setViews(video.getViews() + 1);
                videoService.update(video);
                
                req.setAttribute("video", video);
                req.getRequestDispatcher("/views/video-detail.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/video");
            }
        }

        else {
            // Mặc định (/video): Hiển thị danh sách video của User có phân trang 
            int page = 1;
            if (req.getParameter("page") != null) {
                page = Integer.parseInt(req.getParameter("page"));
            }
            int limit = 6; // 6 video trên 1 trang
            int offset = (page - 1) * limit;

            // Lấy danh sách video của User hiện tại
            List<Video> list = videoService.getVideosByUserIdWithPagination(account.getId(), offset, limit);
            
            // Tính toán tổng số trang
            int totalVideos = videoService.countVideosByUserId(account.getId());
            int totalPages = (int) Math.ceil((double) totalVideos / limit);

            req.setAttribute("videoList", list);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.getRequestDispatcher("/views/video-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User account = (User) session.getAttribute("account");
        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (url.contains("insert")) {
            Video video = new Video();
            video.setTitle(req.getParameter("title"));
            video.setDescription(req.getParameter("description"));
            video.setActive(req.getParameter("active") != null);
            video.setUser(account); // Gắn ID người đăng
            video.setViews(0);

            // Bóc tách file Multipart để lấy file ảnh bìa và file .mp4
            video.setPoster(uploadFile(req, "poster"));
            video.setVideoUrl(uploadFile(req, "videoUrl"));

            videoService.insert(video);
            resp.sendRedirect(req.getContextPath() + "/video");
        } 
        else if (url.contains("update")) {
            int id = Integer.parseInt(req.getParameter("videoId"));
            Video video = videoService.findById(id);
            
            if (video != null && video.getUser().getId() == account.getId()) {
                video.setTitle(req.getParameter("title"));
                video.setDescription(req.getParameter("description"));
                video.setActive(req.getParameter("active") != null);

                // Xử lý upload: Nếu có chọn file mới thì ghi đè, nếu không chọn thì giữ nguyên file cũ
                String newPoster = uploadFile(req, "poster");
                if (!newPoster.isEmpty()) {
                    video.setPoster(newPoster);
                }

                String newVideo = uploadFile(req, "videoUrl");
                if (!newVideo.isEmpty()) {
                    video.setVideoUrl(newVideo);
                }

                videoService.update(video);
            }
            resp.sendRedirect(req.getContextPath() + "/video");
        }
    }

    /**
     * Hàm hỗ trợ bóc tách và lưu file vật lý vào ổ đĩa.
     * Áp dụng phương thức getSubmittedFileName() của lớp Part (Jakarta Servlet 6.0).
     */
    private String uploadFile(HttpServletRequest req, String paramName) throws IOException, ServletException {
        Part part = req.getPart(paramName);
        if (part != null && part.getSize() > 0) {
            String originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            
            // Lấy đuôi file (vd: .mp4, .png, .jpg) và gắn nhãn thời gian để không bao giờ trùng tên
            int dotIndex = originalFileName.lastIndexOf(".");
            String ext = (dotIndex != -1) ? originalFileName.substring(dotIndex) : "";
            String uniqueFileName = System.currentTimeMillis() + "_" + paramName + ext;

            File uploadDir = new File(Constant.UPLOAD_VIDEO_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // Dùng mkdirs() an toàn hơn mkdir()
            }

            // Dùng Files.copy thay cho part.write để tránh lỗi khóa bộ nhớ đệm của Tomcat
            File fileToSave = new File(uploadDir, uniqueFileName);
            try (java.io.InputStream is = part.getInputStream()) {
                java.nio.file.Files.copy(is, fileToSave.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
            }
            return uniqueFileName;
        }
        return "";
    }
}