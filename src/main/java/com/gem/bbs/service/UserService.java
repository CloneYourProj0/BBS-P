package com.gem.bbs.service;

import com.gem.bbs.entity.PageResult;
import com.gem.bbs.entity.User;

import javax.servlet.http.HttpSession;
import java.util.List;


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

    PageResult<User> getUsersByPage(int page, int pageSize);

    PageResult<User> searchUsersByKeyword(int page, int limit, String keyword);

    boolean updateAvatar(Integer userId, String avatarUrl);
    // 其他方法...
}
