package vn.iotstar.service.impl;

import java.util.List;

import vn.iotstar.dao.VideoDao;
import vn.iotstar.dao.impl.VideoDaoImpl;
import vn.iotstar.model.Video;
import vn.iotstar.service.VideoService;

public class VideoServiceImpl implements VideoService {

    // Khởi tạo DAO
    private VideoDao videoDao = new VideoDaoImpl();

    @Override
    public void insert(Video video) {
        videoDao.insert(video);
    }

    @Override
    public void update(Video video) {
        videoDao.update(video);
    }

    @Override
    public void delete(int videoId) throws Exception {
        videoDao.delete(videoId);
    }

    @Override
    public Video findById(int videoId) {
        return videoDao.findById(videoId);
    }

    @Override
    public List<Video> getTop10Videos() {
        return videoDao.getTop10Videos();
    }

    @Override
    public List<Video> getVideosByUserIdWithPagination(int userId, int offset, int limit) {
        return videoDao.getVideosByUserIdWithPagination(userId, offset, limit);
    }

    @Override
    public int countVideosByUserId(int userId) {
        return videoDao.countVideosByUserId(userId);
    }
}