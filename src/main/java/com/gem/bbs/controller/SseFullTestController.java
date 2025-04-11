package com.gem.bbs.controller;

import com.gem.bbs.common.MessageManager;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * SSE全流程测试控制器
 */
@Controller
@RequestMapping("/sse-full-test")
@Slf4j
public class SseFullTestController {

    @Autowired
    private MessageManager messageManager;

    /**
     * 返回SSE全流程测试页面
     */
    @GetMapping("")
    public String ssefullTestPage() {
        return "ssefulltest";
    }

    /**
     * 建立SSE连接
     */
    @GetMapping("/connect")
    @ResponseBody
    public SseEmitter connect(@RequestParam Integer userId) {
        log.info("测试：用户 {} 建立SSE连接", userId);
        
        SseEmitter emitter = messageManager.createSseEmitter(userId);
        
        // 添加onCompletion回调
        emitter.onCompletion(() -> {
            log.info("用户 {} 的SSE连接已完成（客户端断开）", userId);
            log.info("====== SSE连接完成回调触发 ======");
            log.info("用户ID: {}", userId);
            log.info("时间戳: {}", System.currentTimeMillis());
            log.info("===================================");
            messageManager.removeSseEmitter(userId);
        });
        
        // 添加onTimeout回调
        emitter.onTimeout(() -> {
            log.info("用户 {} 的SSE连接超时", userId);
            messageManager.removeSseEmitter(userId);
        });
        
        // 添加onError回调
        emitter.onError((ex) -> {
            log.error("用户 {} 的SSE连接发生错误: {}", userId, ex.getMessage());
            messageManager.removeSseEmitter(userId);
        });
        
        // 发送一条连接成功的消息
        try {
            emitter.send(SseEmitter.event()
                    .data("连接成功！用户ID: " + userId)
                    .id(String.valueOf(System.currentTimeMillis())));
        } catch (Exception e) {
            log.error("发送连接成功消息失败", e);
        }
        
        return emitter;
    }

    /**
     * 发送消息到指定用户
     */
    @PostMapping("/send")
    @ResponseBody
    public Map<String, Object> sendMessage(
            @RequestParam Integer fromUserId,
            @RequestParam Integer toUserId,
            @RequestParam String content) {
        
        log.info("测试：用户 {} 发送消息到用户 {}: {}", fromUserId, toUserId, content);
        
        Map<String, Object> result = new HashMap<>();
        
        // 检查接收用户是否在线
        if (messageManager.hasConnection(toUserId)) {
            messageManager.sendMessage(toUserId, 
                    "收到来自用户" + fromUserId + "的消息: " + content);
            result.put("status", "success");
            result.put("message", "消息发送成功");
        } else {
            result.put("status", "error");
            result.put("message", "接收用户不在线");
        }
        
        return result;
    }

    /**
     * 发送测试消息到指定用户
     */
    @GetMapping("/send-test")
    @ResponseBody
    public Map<String, Object> sendTestMessage(@RequestParam Integer userId) {
        log.info("发送测试消息到用户 {}", userId);
        
        Map<String, Object> result = new HashMap<>();
        
        if (messageManager.hasConnection(userId)) {
            String message = "这是一条测试消息，时间戳: " + System.currentTimeMillis();
            messageManager.sendMessage(userId, message);
            result.put("status", "success");
            result.put("message", "测试消息发送成功");
            result.put("content", message);
        } else {
            result.put("status", "error");
            result.put("message", "用户不在线，无法发送测试消息");
        }
        
        return result;
    }
    
    /**
     * 检查用户连接状态
     */
    @RequestMapping(value = "/check", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> checkConnection(
            @RequestParam Integer userId,
            @RequestParam(required = false) String action,
            @RequestParam(required = false, defaultValue = "false") Boolean clientClosing) {
        
        boolean isConnected = messageManager.hasConnection(userId);
        
        if (clientClosing != null && clientClosing) {
            log.info("客户端请求断开: 用户 {} 正在关闭SSE连接 (连接状态: {})", userId, isConnected ? "已连接" : "未连接");
        }
        
        if ("disconnect".equals(action)) {
            log.info("收到客户端断开连接信号: 用户 {}", userId);
            if (isConnected) {
                try {
                    // 不直接调用removeSseEmitter，而是获取它并调用complete，触发onCompletion回调
                    SseEmitter emitter = messageManager.getSseEmitter(userId);
                    if (emitter != null) {
                        log.info("尝试完成用户 {} 的SSE连接", userId);
                        emitter.complete();
                    } else {
                        log.warn("未找到用户 {} 的SSE连接对象，但hasConnection返回true", userId);
                    }
                } catch (Exception e) {
                    log.error("尝试断开用户 {} 的连接时出错", userId, e);
                }
            }
        }
        
        log.info("检查用户 {} 连接状态: {}", userId, isConnected);
        
        Map<String, Object> result = new HashMap<>();
        result.put("userId", userId);
        result.put("connected", isConnected);
        result.put("message", isConnected ? "用户在线" : "用户不在线");
        result.put("timestamp", System.currentTimeMillis());
        
        return result;
    }
    
    /**
     * 广播消息给所有连接用户
     */
    @GetMapping("/broadcast")
    @ResponseBody
    public Map<String, Object> broadcast(@RequestParam String message) {
        log.info("广播消息: {}", message);
        
        // 获取所有在线用户并发送消息
        Map<String, Object> result = new HashMap<>();
        result.put("status", "success");
        result.put("message", "广播消息已发送");
        
        // 简单实现，通过检查连接状态广播
        for (int i = 1; i <= 10; i++) {  // 假设用户ID从1到10
            if (messageManager.hasConnection(i)) {
                messageManager.sendMessage(i, "系统广播: " + message);
            }
        }
        
        return result;
    }


} 