package com.disappear.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Component;

import com.disappear.order.vo.Chat;



@Component
public interface ChatDAO {
    
    @Insert("INSERT INTO CHATS (SEQ,OSEQ,MID,CONTENT,REGDATE,SSEQ) VALUES((SELECT NVL(MAX(TO_NUMBER(SEQ)),0)+1 FROM CHATS),#{oseq},#{mid},#{content},SYSDATE,#{sseq})")
    public int insertChat(Chat chat);

    @Select("SELECT * FROM CHATS WHERE SSEQ=#{sseq} ORDER BY TO_NUMBER(SEQ)")
    public List<Chat> getChatList(String sseq);

}

