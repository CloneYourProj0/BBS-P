package com.gem.bbs.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setDefaultEncoding("UTF-8");
        // 设置上传文件大小限制，单位为字节（50MB）
        resolver.setMaxUploadSize(52428800);
        // 设置单个文件大小限制
        resolver.setMaxUploadSizePerFile(10485760); // 10MB
        return resolver;
    }
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 添加图片资源路径映射
        registry.addResourceHandler("/img/**")
                .addResourceLocations("/img/");
                
        // 如果有外部存储路径，也可以添加
        // registry.addResourceHandler("/uploads/**")
        //         .addResourceLocations("file:/path/to/your/upload/directory/");
    }
}