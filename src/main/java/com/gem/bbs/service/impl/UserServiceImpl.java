package com.gem.bbs.service.impl;

import com.gem.bbs.common.UserConnectionManager;
import com.gem.bbs.entity.PageResult;
import com.gem.bbs.entity.User;
import com.gem.bbs.mapper.UserMapper;
import com.gem.bbs.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;


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

    @Override
    public PageResult<User> getUsersByPage(int page, int pageSize) {
        // 计算偏移量
        int offset = (page - 1) * pageSize;

        // 获取总记录数
        int total = userMapper.countUsers();

        // 获取当前页数据
        List<User> users = userMapper.getUsersByPage(offset, pageSize);

        // 计算总页数
        int totalPages = (total + pageSize - 1) / pageSize;

        return new PageResult<>(users, page, pageSize, total, totalPages);
    }

    public PageResult<User> searchUsersByKeyword(int page, int pageSize, String keyword) {
        // 计算偏移量
        int offset = (page - 1) * pageSize;

        // 获取模糊查询总记录数
        int total = userMapper.countUsersByKeyword(keyword);

        // 获取当前页数据（模糊查询）
        List<User> users = userMapper.getUsersByKeyword(keyword, offset, pageSize);

        // 计算总页数
        int totalPages = (total + pageSize - 1) / pageSize;

        return new PageResult<>(users, page, pageSize, total, totalPages);
    }

    @Override
    public boolean updateAvatar(Integer userId, String avatarUrl) {
        return userMapper.updateAvatar(userId, avatarUrl) > 0;
    }

}
