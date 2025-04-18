package com.gem.bbs.mapper;

import com.gem.bbs.entity.Answer;
import com.gem.bbs.entity.Question;
import com.gem.bbs.entity.QuestionAndUserAvater;
import com.gem.bbs.entity.QuestionQuery;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface QuestionMapper {
    /**
     * 保存问题
     */
    int insertQuestion(Question question);


    /**
     * 查询所有问题
     */
    List<QuestionAndUserAvater> selectAll(@Param("beginPage") Integer beginPage, @Param("pageCount") Integer pageCount, @Param("title") String title);

    /**
     * 查询记录总数
     */
    Integer getTotal(@Param("title") String title);
    
    /**
     * 根据主键查询问题
     */
    QuestionAndUserAvater selectOneByPrimaryKey(Integer id);

    /**
     * 更新帖子置顶状态
     */
    void updataTopStatus(int id,int status);

    /**
     * 获取用户发布的帖子
     */
    List<Question> FindQuestionByUserId(int id);

    List<Answer> FindAnswerByUserId(int id);

    List<Question> getQuestionsByUserId(@Param("userId") Integer userId,
                                        @Param("offset") int offset,
                                        @Param("pageSize") int pageSize);
    int getQuestionCountByUserId(@Param("userId") Integer userId);

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

    //*****************************************************************************

    // 查询符合条件的 Question 列表
    List<Question> queryQuestions(@Param("query") QuestionQuery query);

    // 查询符合条件的总记录数
    int countQuestionsbyadmin(@Param("query") QuestionQuery query);

    //*****************************************************************************

    /**
     * 增加问题的阅读次数
     */
    void incrementViewCount(Integer questionId);

}
