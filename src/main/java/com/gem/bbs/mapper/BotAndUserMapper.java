package com.gem.bbs.mapper;


import com.gem.bbs.entity.BotAndUser;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface BotAndUserMapper {
    List<BotAndUser> selectByCreaterId(@Param("createrId") Long createrId,
                                       @Param("offset") int offset,
                                       @Param("limit") int limit);

    int countByCreaterId(@Param("createrId") Long createrId);

    //*****************************************************************************************************
    void insertBotAndUser(@Param("botId") Long botId, @Param("createrId") Long createrId,@Param("name")String name);

    void deleteBotData(Long botId);
}
