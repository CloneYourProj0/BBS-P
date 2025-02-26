package com.gem.bbs.entity;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AnswerQuery {
    private Integer userId;
    private Integer questionId;
    private Date startTime;
    private Date endTime;
    private Integer offset;
    private Integer limit;

    // getter & setter 略
}
