package com.gem.bbs.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
@Slf4j
public class UploadService {

    @Value("${upload.path}")
    private String uploadPath;

    /**
     * 上传文件并返回文件访问URL
     * @param file 上传的文件
     * @param request HTTP请求
     * @param subDir 子目录，例如"avatar"、"images"等
     * @return 包含上传结果的Map
     */
    public Map<String, Object> uploadFile(MultipartFile file, HttpServletRequest request, String subDir) {
        Map<String, Object> result = new HashMap<>();

        if (file == null || file.isEmpty()) {
            result.put("code", 1);
            result.put("msg", "请选择要上传的文件");
            return result;
        }

        try {
            // 生成唯一文件名（包含原始文件的扩展名）
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String newFileName = UUID.randomUUID().toString() + extension;

            // 1. 保存到 target 目录（例如用于前端即时访问）
            String targetDirPath = request.getSession().getServletContext().getRealPath("/img/" + subDir);
            File targetDir = new File(targetDirPath);
            if (!targetDir.exists()) {
                targetDir.mkdirs();
            }
            File targetFile = new File(targetDir, newFileName);

            // 2. 保存到配置指定的本地目录
            String localDirPath = uploadPath + File.separator + subDir;
            File localDir = new File(localDirPath);
            if (!localDir.exists()) {
                localDir.mkdirs();
            }
            File localFile = new File(localDir, newFileName);

            // 获取上传文件的字节内容
            byte[] bytes = file.getBytes();

            // 分别写入 target 和本地目录
            Files.write(targetFile.toPath(), bytes);
            Files.write(localFile.toPath(), bytes);

            // 构造前端访问路径
            String fileUrl = request.getContextPath() + "/img/" + subDir + "/" + newFileName;

            // 添加文件类型信息
            String mimeType = file.getContentType();
            result.put("code", 0);
            Map<String, Object> data = new HashMap<>();
            data.put("src", fileUrl);
            data.put("title", originalFilename);
            data.put("type", mimeType); // 添加MIME类型
            result.put("data", data);
            result.put("msg", "上传成功");

        } catch (Exception e) {
            log.error("文件上传失败", e);
            result.put("code", 1);
            result.put("msg", "文件上传异常：" + e.getMessage());
        }

        return result;
    }
} 