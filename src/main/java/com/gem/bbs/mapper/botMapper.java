package com.gem.bbs.mapper;


import com.gem.bbs.entity.BotDTO;
import com.gem.bbs.entity.bot;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface botMapper {

    /**
     * ------------------------------------------------------------
     * @param id
     * @param botName
     * @return
     */
    List<bot> getUserAiBot(@Param("id") Integer id, @Param("botName") String botName);

    /*
    by-claude-opus
     */
    bot selectByName(@Param("name") String name);
    /**
     * ----------------------------------------------------------------------------------------
     */


    List<BotDTO> getMyBots(@Param("userId") Long userId, @Param("offset") int offset, @Param("limit") int limit);
    // 获取用户的Bot总数

    int getMyBotCount(@Param("userId") Long userId);

    // 根据Bot ID获取Bot详情
    bot getBotById(@Param("id") Long id);

    // 创建Bot
    void createBot(BotDTO bot);

    // 更新Bot
    void updateBot(bot bot);

    // 删除Bot
    void deleteBot(@Param("botId") Long botId);







}
