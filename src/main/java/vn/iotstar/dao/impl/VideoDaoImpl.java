package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.configs.JPAConfig;
import vn.iotstar.dao.VideoDao;
import vn.iotstar.model.Video;

public class VideoDaoImpl implements VideoDao {

    @Override
    public void insert(Video video) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(video); // Thêm mới
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Video video) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(video); // Cập nhật
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int videoId) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Video video = enma.find(Video.class, videoId);
            if (video != null) {
                enma.remove(video); // Xóa
            } else {
                throw new Exception("Không tìm thấy video");
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Video findById(int videoId) {
        EntityManager enma = JPAConfig.getEntityManager();
        Video video = enma.find(Video.class, videoId);
        enma.close();
        return video;
    }

    // Yêu cầu 4.2: Lấy Top 10 video mới nhất đang Active
    @Override
    public List<Video> getTop10Videos() {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT v FROM Video v WHERE v.active = true ORDER BY v.videoId DESC";
        TypedQuery<Video> query = enma.createQuery(jpql, Video.class);
        query.setMaxResults(10); // Chỉ lấy 10 dòng
        List<Video> list = query.getResultList();
        enma.close();
        return list;
    }

    // Yêu cầu 4.3: Phân trang video của cá nhân
    @Override
    public List<Video> getVideosByUserIdWithPagination(int userId, int offset, int limit) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT v FROM Video v WHERE v.user.id = :uid ORDER BY v.videoId DESC";
        TypedQuery<Video> query = enma.createQuery(jpql, Video.class);
        query.setParameter("uid", userId);
        query.setFirstResult(offset); // Vị trí bắt đầu
        query.setMaxResults(limit);   // Số lượng cần lấy (6sp/trang)
        List<Video> list = query.getResultList();
        enma.close();
        return list;
    }

    // Tính tổng số video của user để chia trang
    @Override
    public int countVideosByUserId(int userId) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT COUNT(v) FROM Video v WHERE v.user.id = :uid";
        TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
        query.setParameter("uid", userId);
        int count = query.getSingleResult().intValue();
        enma.close();
        return count;
    }
}