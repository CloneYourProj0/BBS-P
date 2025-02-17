package com.gem.bbs.service.impl;
import com.gem.bbs.entity.BotAndUser;
import com.gem.bbs.entity.BotDTO;
import com.gem.bbs.entity.bot;
import com.gem.bbs.mapper.BotAndUserMapper;
import com.gem.bbs.mapper.botMapper;
import com.gem.bbs.service.BotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BotServiceImpl implements BotService {

    @Autowired
    private botMapper botmapper;

    @Autowired
    private BotAndUserMapper botAndUserMapper;

    @Override
    public List<BotAndUser> getMyBotss(Long userId, int page, int limit) {
        int offset = (page - 1) * limit;
        return botAndUserMapper.selectByCreaterId(userId, offset, limit);
    }

    @Override
    public int getMyBotCountt(Long userId) {
        return botAndUserMapper.countByCreaterId(userId);
    }

    @Override
    public bot getBotByName(String name) {
        return botmapper.selectByName(name);
    }

    /**
     * ----------------------------------------------------------------------------------------------
     * @param userId
     * @param offset
     * @param limit
     * @return
     */

    @Override
    public List<BotDTO> getMyBots(Long userId, int offset, int limit) {
        return botmapper.getMyBots(userId, offset, limit);
    }

    @Override
    public int getMyBotCount(Long userId) {
        return botmapper.getMyBotCount(userId);
    }

    @Override
    public bot getBotById(Long botId) {
        return botmapper.getBotById(botId);
    }

    @Transactional
    public void createBot(BotDTO bot) {
        botmapper.createBot(bot);

        // 插入 botanduser 关联关系
        botAndUserMapper.insertBotAndUser(bot.getId(), bot.getCreaterId(),bot.getName());
    }


    @Override
    @Transactional
    public void updateBot(bot bot) {
        botmapper.updateBot(bot);
    }

    @Override
    @Transactional
    public void deleteBot(Long botId) {

        botmapper.deleteBot(botId);
        botAndUserMapper.deleteBotData(botId);
    }


}