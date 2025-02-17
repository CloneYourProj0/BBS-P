package com.gem.bbs.entity;


import lombok.Data;
import java.util.Date;

@Data
public class BotAndUser {
    private Long id;
    private String name;
    private Long createrId;
    private Date createdTime;
    private Date updatedTime;
}
