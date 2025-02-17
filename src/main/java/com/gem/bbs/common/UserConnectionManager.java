package com.gem.bbs.common;

import org.springframework.stereotype.Component;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentSkipListSet;

@Component
public class UserConnectionManager {
    // 存储在线用户ID
    private static final Set<Integer> ONLINE_USERS = new ConcurrentSkipListSet<>();
    // 存储用户SSE连接状态
    private static final Map<Integer, Boolean> SSE_CONNECTION_STATUS = new ConcurrentHashMap<>();

    // 用户登录时调用
    public void userLogin(Integer userId) {
        ONLINE_USERS.add(userId);
    }

    // 用户登出时调用
    public void userLogout(Integer userId) {
        ONLINE_USERS.remove(userId);
        SSE_CONNECTION_STATUS.remove(userId);
    }

    // 建立SSE连接时调用
    public void establishSseConnection(Integer userId) {
        SSE_CONNECTION_STATUS.put(userId, true);
    }

    // 断开SSE连接时调用
    public void closeSseConnection(Integer userId) {
        SSE_CONNECTION_STATUS.remove(userId);
    }

    // 检查用户是否在线
    public boolean isUserOnline(Integer userId) {
        return ONLINE_USERS.contains(userId);
    }

    // 检查用户是否建立了SSE连接
    public boolean hasSseConnection(Integer userId) {
        return SSE_CONNECTION_STATUS.getOrDefault(userId, false);
    }

    // 获取所有在线用户
    public Set<Integer> getOnlineUsers() {
        return ONLINE_USERS;
    }
}
