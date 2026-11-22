package vn.iotstar.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import jakarta.servlet.http.Part;

public class CloudinaryUtil {
    private static final Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "g6ras9jb",
            "api_key", "373282428635275",
            "api_secret", "mVTykjzcfozz3qi8TPCGblRWBnA",
            "secure", true
    ));

    public static String uploadImage(Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        try (InputStream is = filePart.getInputStream()) {
            byte[] fileBytes = is.readAllBytes();
            Map<?, ?> uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.asMap(
                    "folder", "shoppingmvc_avatars",
                    "resource_type", "image"
            ));
            return (String) uploadResult.get("secure_url");
        }
    }
}