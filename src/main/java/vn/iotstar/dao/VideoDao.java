package vn.iotstar.dao;

import java.util.List;

import vn.iotstar.model.Video;

public interface VideoDao {
    void insert(Video video);
    void update(Video video);
    void delete(int videoId) throws Exception;
    Video findById(int videoId);
    
    // Hỗ trợ mục 4.2: Hiển thị 10 video mới nhất lên trang chủ
    List<Video> getTop10Videos();
    
    // Hỗ trợ mục 4.3: Lấy tất cả video của 1 User 
    List<Video> getVideosByUserIdWithPagination(int userId, int offset, int limit);
    
    // Đếm tổng số video của 1 User để tính số lượng trang 
    int countVideosByUserId(int userId);
}