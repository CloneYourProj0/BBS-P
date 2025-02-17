package com.gem.bbs.common;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class MessageManager {
    // 存储用户的SSE连接
    private static final Map<Integer, SseEmitter> USER_SSE_MAP = new ConcurrentHashMap<>();

    // 建立SSE连接
    public SseEmitter createSseEmitter(Integer userId) {
        SseEmitter emitter = new SseEmitter(0L); // 永不过期

        emitter.onCompletion(() -> {
            USER_SSE_MAP.remove(userId);
        });

        emitter.onTimeout(() -> {
            USER_SSE_MAP.remove(userId);
        });

        USER_SSE_MAP.put(userId, emitter);
        return emitter;
    }

    // 发送消息
    public void sendMessage(Integer userId, String message) {
        SseEmitter emitter = USER_SSE_MAP.get(userId);
        if (emitter != null) {
            try {
                emitter.send(SseEmitter.event()
                        .data(message)
                        .id(String.valueOf(System.currentTimeMillis())));
            } catch (Exception e) {
                USER_SSE_MAP.remove(userId);
            }
        }
    }

    // 移除SSE连接
    public void removeSseEmitter(Integer userId) {
        USER_SSE_MAP.remove(userId);
    }

    // 检查用户是否有SSE连接
    public boolean hasConnection(Integer userId) {
        return USER_SSE_MAP.containsKey(userId);
    }
}
