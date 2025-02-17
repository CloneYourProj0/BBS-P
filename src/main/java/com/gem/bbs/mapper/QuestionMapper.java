package com.gem.bbs.mapper;

import com.gem.bbs.entity.Answer;
import com.gem.bbs.entity.Question;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author: jzhang
 * @WX: 15250420158
 * @Date: 2020/2/13 10:42
 * @Description: 问题接口
 */
public interface QuestionMapper {
    /**
     * 保存问题
     */
    int insertQuestion(Question question);


    /**
     * 查询所有问题
     */
    List<Question> selectAll(@Param("beginPage") Integer beginPage, @Param("pageCount") Integer pageCount, @Param("title") String title);

    /**
     * 查询记录总数
     */
    Integer getTotal(@Param("title") String title);
    
    /**
     * 根据主键查询问题
     */
    Question selectOneByPrimaryKey(Integer id);

    /**
     * 更新帖子置顶状态
     */
    void updataTopStatus(int id,int status);

    /**
     * 获取用户发布的帖子
     */
    List<Question> FindQuestionByUserId(int id);

    List<Answer> FindAnswerByUserId(int id);

    List<Question> getQuestionsByUserId(Integer userId);
    Question getQuestionById(Integer id);
    void updateQuestion(Question question);
    void deleteQuestion(Integer id);

    List<Question> findQuestionsByUserId(@Param("userId") int userId,
                                         @Param("offset") int offset,
                                         @Param("limit") int limit);

    int countQuestionsByUserId(@Param("userId") int userId);

    // 新增的回答分页方法
    List<Answer> findAnswersByUserId(@Param("userId") int userId,
                                     @Param("offset") int offset,
                                     @Param("limit") int limit);

    int countAnswersByUserId(@Param("userId") int userId);


    /*
    查询阅读量
     */
    List<Question> countQuestions();

    List<Question> matchQuestion(@Param("content")String content);
}
