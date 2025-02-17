package com.gem.bbs.mapper;

import com.gem.bbs.entity.User;

import java.util.List;

/**
 * @Author: jzhang
 * @WX: 15250420158
 * @Date: 2020/2/13 08:39
 * @Description: 用户接口
 */
public interface UserMapper {
    //注册，即保存用户
    void insertUser(User user);

    //登录，根据用户名查询用户
    User findUserByLoginname(String loginname);

    User findUserById(int id);

    void upProfile(User user);

    List<User> getAllUsers();

    User getUserById(Integer id);

    void updateUser(User user);

    void deleteUser(Integer id);


}
