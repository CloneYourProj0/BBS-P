package com.gem.bbs.entity;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QuestionQuery {
    private Integer userId;
    private Date startTime;
    private Date endTime;
    // 分页参数：计算 offset 与 limit
    private Integer offset; // (page - 1)*limit
    private Integer limit;  // 每页条数

    // getter & setter 略
}

