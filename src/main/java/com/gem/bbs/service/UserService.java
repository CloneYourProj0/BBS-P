package com.gem.bbs.service;

import com.gem.bbs.entity.User;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @Author: jzhang
 * @WX: 15250420158
 * @Date: 2020/2/13 08:48
 * @Description:
 */
public interface UserService {
    /**
     * 注册用户
     */
    void register(User user);

    /**
     * 用户登录
     */
    String login(String loginname,String password,HttpSession session);

    /**
     * 用户个人界面信息查询
     */
    User findUserProfile(int id);

    /**
     * 修改个人信息
     */
    void upFrofile(User user,HttpSession session);


    /*
    by gpt o1
     */
    List<User> getAllUsers();
    User getUserById(Integer id);
    void updateUser(User user);
    void deleteUser(Integer id);
    // 其他方法...
}
