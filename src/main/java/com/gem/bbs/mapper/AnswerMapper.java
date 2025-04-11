package com.gem.bbs.mapper;

import com.gem.bbs.entity.Answer;
import com.gem.bbs.entity.AnswerQuery;
import com.gem.bbs.entity.LikeAnswerIds;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;


public interface AnswerMapper {
    /**
     * 根据问题主键获取回复记录
     */
    List<Map<String, Object>> selectListByAnswerId(Integer id);

    /**
     * 保存回复
     */
    void insertAnswer(Answer answer);

//    此为ai自动生成，没有考虑到前面也就是第一个方法其实就已经实现了，可以复用；
//    List<Answer> getAnswersByUserId(Integer userId);
    Answer getAnswerById(Integer id);

    void deleteAnswer(Integer id);

    List<Integer> getLikedAnswerIds(int userid);
    void deleLikeAnswerIds(LikeAnswerIds likeAnswerIds);
    @Insert("INSERT INTO user_like (user_id, answer_id, createtime) VALUES (#{userId}, #{answerId}, #{createTime})")
    void insertLikeAnswerIds(LikeAnswerIds likeAnswerIds);

    /*
    by-claude-opus-更新点赞数和获取点赞数量
     */
    @Update("UPDATE answer SET likes = #{likes} WHERE id = #{id}")
    void updateLikesById(@Param("id") int id, @Param("likes") int likes);
    @Select("SELECT * FROM answer WHERE id = #{id}")
    Answer selectByPrimaryKey(@Param("id") int id);


    //********************************************************************

    List<Answer> queryAnswers(@Param("query") AnswerQuery query);
    int countAnswers(@Param("query") AnswerQuery query);

    //********************************************************************

}
