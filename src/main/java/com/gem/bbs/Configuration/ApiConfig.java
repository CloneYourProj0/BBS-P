package com.gem.bbs.Configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Configuration
@PropertySource("classpath:model.properties")  // 加载额外的 properties 文件
public class ApiConfig {

    @Value("${api.url}")
    private String url;

    @Value("${api.key}")
    private String apiKey;

    @Value("${model}")
    private String model;

    @Value("${system.message}")
    private String systemMessage;


    private String userMessage;

    // Getters for each property
    public String getUrl() { return url; }
    public String getApiKey() { return apiKey; }
    public String getModel() { return model; }
    public String getSystemMessage() { return systemMessage; }
    public String getUserMessage() { return userMessage; }
}
