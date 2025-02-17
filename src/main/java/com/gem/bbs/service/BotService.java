package com.gem.bbs.service;


import com.gem.bbs.entity.BotDTO;
import com.gem.bbs.entity.bot;
import com.gem.bbs.entity.BotAndUser;
import java.util.List;

public interface BotService {
    List<BotAndUser> getMyBotss(Long userId, int page, int limit);
    int getMyBotCountt(Long userId);
    bot getBotByName(String name);


    //---------------------------------------------------------------------------------
    List<BotDTO> getMyBots(Long userId, int offset, int limit);
    int getMyBotCount(Long userId);
    bot getBotById(Long botId);
    void createBot(BotDTO bot);
    void updateBot(bot bot);
    void deleteBot(Long botId);
}