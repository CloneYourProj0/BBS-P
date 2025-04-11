package com.gem.bbs.entity;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


@Data
public class User {
    private Integer id;
    private String loginname;
    private String password;
    private String username;
    private String nickname;
    private String avatar;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createtime;

    private  String email;

    private String role;
}
