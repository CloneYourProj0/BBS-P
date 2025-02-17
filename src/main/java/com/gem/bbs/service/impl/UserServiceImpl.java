package com.gem.bbs.service.impl;

import com.gem.bbs.common.UserConnectionManager;
import com.gem.bbs.entity.User;
import com.gem.bbs.mapper.UserMapper;
import com.gem.bbs.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @Author: jzhang
 * @WX: 15250420158
 * @Date: 2020/2/13 08:52
 * @Description:
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    /*
    记录用户登录情况和sse建立情况
   */
    @Autowired
    private UserConnectionManager connectionManager;

    @Override
    public void register(User user) {
        user.setEmail(user.getLoginname()+ "@example.com");
        userMapper.insertUser(user);
    }

    @Override
    public String login(String loginname, String password,HttpSession session) {
        //查询用户
        User user = userMapper.findUserByLoginname(loginname);
        if (user != null) {
            if (user.getPassword().equals(password)) {
                //用户登录成功，将【用户对象】存放到session
                session.setAttribute("user",user);

                // 建立用户在线状态
                connectionManager.userLogin(user.getId());


                return "101";//登录成功
            } else {
                return "102";//登录失败
            }
        } else {
            return "102";//登录失败
        }
    }

    @Override
    public User findUserProfile(int id) {
        User userProfile = userMapper.findUserById(id);
        return userProfile;
    }

    @Override
    public void upFrofile(User user,HttpSession session) {
        userMapper.upProfile(user);
//        User userData =(User) session.getAttribute("userData");
//        userData.setLoginname(user.getLoginname());
//        session.setAttribute("userData",userData);
    }

    public List<User> getAllUsers() {
        return userMapper.getAllUsers();
    }

    public User getUserById(Integer id) {
        return userMapper.getUserById(id);
    }

    public void updateUser(User user) {
        userMapper.updateUser(user);
    }

    public void deleteUser(Integer id) {
        userMapper.deleteUser(id);
    }
}
