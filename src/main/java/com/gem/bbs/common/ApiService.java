package com.gem.bbs.common;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.gem.bbs.Configuration.ApiConfig;
import com.gem.bbs.service.UserInteractionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

@Component
public class ApiService {

    @Autowired
    private ApiConfig apiConfig;

    public String sendRequest(Map<String,String> message,String prompt,String model) {
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        try {
            // 构造请求体
            Map<String, Object> requestBody = new HashMap<>();
//            requestBody.put("model", apiConfig.getModel());
            requestBody.put("model", model);

            List<Map<String, String>> messages = new ArrayList<>();
            messages.add(createMessage("system", prompt));

            // 创建一个列表,用于存储按顺序组合后的字符串
            List<String> orderedList = new ArrayList<>();

            // 取出"questionUser"的值,并添加到列表中
            String questionUser = message.get("questionUser");
            if (questionUser != null && !questionUser.isEmpty()) {
                orderedList.add("帖子内容(Question): " + questionUser);
                messages.add(createMessage("user", questionUser));
            }

            // 取出"resourceAnswer"的值,并添加到列表中
            String resourceAnswer = message.get("resourceAnswer");
            if (resourceAnswer != null && !resourceAnswer.isEmpty()) {
                orderedList.add("用户回帖(reply): " + resourceAnswer);
                messages.add(createMessage("user", resourceAnswer));
            }

            // 取出"answerUser"的值,并添加到列表中
            String answerUser = message.get("answerUser");
            if (answerUser != null && !answerUser.isEmpty()) {
                orderedList.add("向上一位用户回复(replyToUser): " + answerUser);
                messages.add(createMessage("user", answerUser));
            }

            requestBody.put("messages", messages);

            // 将请求体转换为JSON字符串
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.enable(SerializationFeature.INDENT_OUTPUT);
            String json = objectMapper.writeValueAsString(requestBody);
            System.out.println("Constructed JSON: " + json);

            // 创建 URL 对象
            URL url = new URL(apiConfig.getUrl());
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Authorization", "Bearer " + apiConfig.getApiKey());
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setDoOutput(true);

            // 设置连接和读取超时（以毫秒为单位）
            connection.setConnectTimeout(10000); // 5秒连接超时
            connection.setReadTimeout(10000); // 5秒读取超时

            // 发送请求
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = json.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // 检查响应码
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // 读取响应
                BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
                StringBuilder response = new StringBuilder();
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }

                System.out.println("Response Code: " + responseCode);
                System.out.println("Response Body: " + response.toString());

                JSONObject jsonObject = JSON.parseObject(response.toString());
                JSONArray jsonArray = jsonObject.getJSONArray("choices");
                if (jsonArray != null && !jsonArray.isEmpty()) {
                    // 获取第一个选择项
                    JSONObject firstChoice = jsonArray.getJSONObject(0);
                    // 获取 "message" 对象
                    JSONObject messageObject = firstChoice.getJSONObject("message");
                    if (messageObject != null) {
                        // 获取 "content" 字段
                        return messageObject.getString("content");
                    }
                }
            } else {
                System.err.println("Error: " + responseCode);
                logErrorResponse(connection);
                return "false";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "false";
        }

        return "true";

    }

    private Map<String, String> createMessage(String role, String content) {
        Map<String, String> message = new HashMap<>();
        message.put("role", role);
        message.put("content", content);
        return message;
    }
    private void logErrorResponse(HttpURLConnection connection) {
        try (InputStream errorStream = connection.getErrorStream()) {
            if (errorStream != null) {
                BufferedReader br = new BufferedReader(new InputStreamReader(errorStream, "utf-8"));
                StringBuilder errorResponse = new StringBuilder();
                String errorLine;
                while ((errorLine = br.readLine()) != null) {
                    errorResponse.append(errorLine.trim());
                }
                System.err.println("Error Response: " + errorResponse.toString());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    //*********************************************************************************


    public List<Map<String, Object>> getRecommendations(Long userId) throws Exception {

        // 从数据库获取用户交互数据
//        List<qaUserInteraction> userInteractions = userInteractionService.getInteractionsByUserId(userId);


        // 构建请求 URL
        String urlString = "http://127.0.0.1:5000/recommend";
        URL url = new URL(urlString);

        // 创建连接
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        // 设置请求方法和请求头
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; utf-8");
        conn.setDoOutput(true);

        // 构建请求体
        ObjectMapper objectMapper = new ObjectMapper();

        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("user_id", userId);
        requestBody.put("top_k", 5);


        String jsonRequestBody = objectMapper.writeValueAsString(requestBody);

        // 发送请求
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonRequestBody.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        // 读取响应
        int status = conn.getResponseCode();
        if (status == 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
            StringBuilder responseText = new StringBuilder();
            String responseLine = null;
            while ((responseLine = br.readLine()) != null) {
                responseText.append(responseLine.trim());
            }

            // 解析响应
            List<Map<String, Object>> recommendations = objectMapper.readValue(
                    responseText.toString(),
                    new TypeReference<List<Map<String, Object>>>() {}
            );

            return recommendations;

        } else {
            throw new Exception("Failed to get recommendations: HTTP error code " + status);
        }
    }


}

