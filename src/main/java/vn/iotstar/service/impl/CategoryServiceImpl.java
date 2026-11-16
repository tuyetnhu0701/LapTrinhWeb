package vn.iotstar.service.impl;

import java.io.File;
import java.util.List;

import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.impl.CategoryDaoImpl;
import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.util.Constant;

public class CategoryServiceImpl implements CategoryService {
    CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) { categoryDao.insert(category); }

    @Override
    public void delete(int id) { 
        Category oldCategory = categoryDao.get(id);
        if (oldCategory != null && oldCategory.getIcon() != null) {
            File file = new File(Constant.DIR + "/category/" + oldCategory.getIcon());
            if (file.exists()) file.delete(); // Xóa file ảnh vật lý nếu có
        }
        categoryDao.delete(id); 
    }

    @Override
    public Category get(int id) { return categoryDao.get(id); }

    @Override
    public void edit(Category newCategory) {
        Category oldCategory = categoryDao.get(newCategory.getId());
        oldCategory.setName(newCategory.getName());
        if (newCategory.getIcon() != null && !newCategory.getIcon().isEmpty()) {
            // Xóa ảnh cũ
            String fileName = oldCategory.getIcon();
            if (fileName != null) {
                File file = new File(Constant.DIR + "/category/" + fileName);
                if (file.exists()) file.delete();
            }
            // Cập nhật ảnh mới
            oldCategory.setIcon(newCategory.getIcon());
        }
        categoryDao.edit(oldCategory);
    }

    @Override
    public Category get(String name) { return categoryDao.get(name); }

    @Override
    public List<Category> getAll() { return categoryDao.getAll(); }

    @Override
    public List<Category> search(String keyword) { return categoryDao.search(keyword); }
}