package com.gem.bbs.mapper;

import com.gem.bbs.entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

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


    @Select("SELECT COUNT(*) FROM user")
    int countUsers();

    @Select("SELECT * FROM user LIMIT #{offset}, #{pageSize}")
    List<User> getUsersByPage(@Param("offset") int offset, @Param("pageSize") int pageSize);

    // 模糊查询 —— 统计符合条件的记录数
    @Select("SELECT COUNT(*) FROM user " +
            "WHERE CAST(id AS CHAR) LIKE CONCAT('%', #{keyword}, '%') " +
            "OR loginname LIKE CONCAT('%', #{keyword}, '%') " +
            "OR username LIKE CONCAT('%', #{keyword}, '%') " +
            "OR nickname LIKE CONCAT('%', #{keyword}, '%') " +
            "OR email LIKE CONCAT('%', #{keyword}, '%')")
    int countUsersByKeyword(@Param("keyword") String keyword);

    // 模糊查询 —— 分页查询数据
    @Select("SELECT * FROM user " +
            "WHERE CAST(id AS CHAR) LIKE CONCAT('%', #{keyword}, '%') " +
            "OR loginname LIKE CONCAT('%', #{keyword}, '%') " +
            "OR username LIKE CONCAT('%', #{keyword}, '%') " +
            "OR nickname LIKE CONCAT('%', #{keyword}, '%') " +
            "OR email LIKE CONCAT('%', #{keyword}, '%') " +
            "LIMIT #{offset}, #{pageSize}")
    List<User> getUsersByKeyword(@Param("keyword") String keyword,
                                 @Param("offset") int offset,
                                 @Param("pageSize") int pageSize);

    @Update("UPDATE user SET avatar = #{avatarUrl} WHERE id = #{userId}")
    int updateAvatar(@Param("userId") Integer userId, @Param("avatarUrl") String avatarUrl);

}
