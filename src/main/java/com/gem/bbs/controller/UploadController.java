package com.gem.bbs.controller;

import com.gem.bbs.service.UploadService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@RequestMapping("/upload")
@Slf4j
public class UploadController {

    @Autowired
    private UploadService uploadService;

    /**
     * 处理图片上传请求 - 用于问题表单中的图片上传
     */
    @RequestMapping(value = "/image", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadImage(
            @RequestParam("file") MultipartFile file,
            HttpServletRequest request) {
        log.info("接收到图片上传请求");
        return uploadService.uploadFile(file, request, "question_images");
    }

    /**
     * 通用文件上传接口 - 可以指定子目录
     */
    @RequestMapping(value = "/file", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadFile(
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "dir", defaultValue = "common") String directory,
            HttpServletRequest request) {
        log.info("接收到文件上传请求，目录: {}", directory);
        return uploadService.uploadFile(file, request, directory);
    }
}