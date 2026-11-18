package vn.iotstar.service;

import java.util.List;

import vn.iotstar.model.Video;

public interface VideoService {
    void insert(Video video);
    void update(Video video);
    void delete(int videoId) throws Exception;
    Video findById(int videoId);
    List<Video> getTop10Videos();
    List<Video> getVideosByUserIdWithPagination(int userId, int offset, int limit);
    int countVideosByUserId(int userId);
}