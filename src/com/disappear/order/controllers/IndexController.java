package com.disappear.order.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.disappear.order.dao.ChatDAO;
import com.disappear.order.dao.MyPageDao;
import com.disappear.order.dao.StoreDao;
import com.disappear.order.vo.Chat;
import com.disappear.order.vo.OrderList;
import com.disappear.order.vo.Store;
import com.google.gson.Gson;


@Controller
@RequestMapping("/*")
public class IndexController {

    @Autowired
    // private NoticeDAO noticeDao;
    private SqlSession sqlSession;

    @RequestMapping("index.do")
    public String index(HttpServletRequest request, Model model) {

        MyPageDao myPageDao = sqlSession.getMapper(MyPageDao.class);
        StoreDao storeDao = sqlSession.getMapper(StoreDao.class);
        List<Store> storeList = myPageDao.getStores();
        List<String> top3List = storeDao.getTop3();
        Map<String, String> avgLikesMap = new HashMap<String, String>();
        List<Map<String, String>> listOfMap = storeDao.getAvgLikes();
        for (Map<String, String> map : listOfMap) {
            String key = map.get("STORENAME");
            String value = map.get("LIKES");
            avgLikesMap.put(key, value);
        }
        

        model.addAttribute("storeList", storeList);
        model.addAttribute("top3List", top3List);
        model.addAttribute("avgLikesMap", avgLikesMap);

        return "index";
    }

    @RequestMapping("chat.do")
    public String chat(HttpServletRequest request, String storeName, String content) {

        String mid = (String) request.getSession().getAttribute("mid");

        MyPageDao myPageDao = sqlSession.getMapper(MyPageDao.class);
        ChatDAO chatDao = sqlSession.getMapper(ChatDAO.class);

        String sseq = myPageDao.getSseq(storeName);
        List<OrderList> orderList = myPageDao.getOrderList(mid);

        SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
        long time = System.currentTimeMillis();
        String str = dayTime.format(new Date(time));

        String oseq = null;
        for (OrderList o : orderList) {
            System.out.println(str);
            System.out.println(o.getOrderdate().split(" ")[0]);
            if (o.getOrderdate().split(" ")[0].equals(str)) {
                System.out.println(storeName);
                System.out.println(o.getStorename());
                if(storeName.equals(o.getStorename())){
                    oseq=o.getOrderseq();
                    break;
                }
            }
        }
        Chat chat = new Chat();
        System.out.println("oseq : " + oseq);
        chat.setSseq(sseq);
        chat.setOseq(oseq);
        chat.setMid(mid);
        chat.setContent(content);
        
        
        int insertCount = chatDao.insertChat(chat);

        if (insertCount > 0) {
            System.out.println("insert success");
        } else {
            System.out.println("insert fail");

        }

        return "index_chat";
    }

    @RequestMapping("getChat.do")
    public String getChat(String storeName, Model model) {
        

        ChatDAO chatDao = sqlSession.getMapper(ChatDAO.class);
        MyPageDao myPageDao = sqlSession.getMapper(MyPageDao.class);

        String sseq = myPageDao.getSseq(storeName);
        List<Chat> chatList = chatDao.getChatList(sseq);

        Gson gs = new Gson();
        String json = gs.toJson(chatList);

        model.addAttribute("json", json);
        System.out.println(json);

        return "index_getChat";
    }

}
