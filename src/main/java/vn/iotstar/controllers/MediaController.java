package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = "/media")
public class MediaController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName != null && !fileName.isEmpty()) {
            File file = new File(Constant.UPLOAD_VIDEO_DIR, fileName);
            if (file.exists()) {
                String lowerName = fileName.toLowerCase();
                if (lowerName.endsWith(".mp4")) {
                    resp.setContentType("video/mp4");
                } else if (lowerName.endsWith(".png")) {
                    resp.setContentType("image/png");
                } else {
                    resp.setContentType("image/jpeg");
                }
                resp.setContentLengthLong(file.length());

                try (java.io.OutputStream out = resp.getOutputStream()) {
                    Files.copy(file.toPath(), out);
                } catch (IOException e) {
                }
            }
        }
    }
}