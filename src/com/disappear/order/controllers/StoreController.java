package com.disappear.order.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.disappear.order.dao.StoreDao;
import com.disappear.order.vo.Comment;
import com.disappear.order.vo.Store;
import com.google.gson.Gson;

@Controller
@RequestMapping("/store/*")
public class StoreController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping("store.do")
    public String store(Model model, String storeType, String page,String area, String county, String detailAddress) {
        
        
        if(area!=null){
            if(area.equals("시/도 선택")){
                area="";
            }
        }
        if(county!=null){
            if(county.equals("시/구/군 선택")){
                county="";
            }
        }
        if(area==null){
            area="";
        }
        if(county==null){
            county="";
        }
        if(detailAddress==null){
            detailAddress="";
        }
        
        
        String address = "%" + area + "% %" + county + "% %" + detailAddress + "%";
        
        int iPage;
        if (page == null) {
            iPage=0;
        }else{
            iPage=Integer.parseInt(page);
        }
        System.out.println("address : "+address);
        StoreDao storeDao = sqlSession.getMapper(StoreDao.class);
        List<Store> storeList = new ArrayList<Store>();
        System.out.println("storeType=" + storeType);
        if(address.equals("%% %% %%")){
            if (storeType == null||storeType == "") {
                storeList = storeDao.getStores(iPage);
            } else {
                storeList = storeDao.getStoresByStoreType(storeType, iPage);
            }
        }else{
            if (storeType == null||storeType == "") {
                storeList = storeDao.getSearches(address, iPage);
            } else {
                storeList = storeDao.getStoresByStoreTypeAndAddress(address, storeType, iPage);
            }
        }
        
        List<String> storeTypeList = storeDao.getAllStoresByStoreType();
        List<Map<String, String>> listOfMap = storeDao.getAvgLikes();
        Map<String, String> avgLikesMap = new HashMap<String, String>();

        System.out.println(listOfMap);
        for (Map<String, String> map : listOfMap) {
            String key = map.get("STORENAME");
            String value = map.get("LIKES");
            avgLikesMap.put(key, value);
        }
        System.out.println(avgLikesMap);
        model.addAttribute("storeList", storeList);
        model.addAttribute("avgLikesMap", avgLikesMap);
        model.addAttribute("storeType", storeType);
        model.addAttribute("storeTypeList", storeTypeList);
        model.addAttribute("area", area);
        model.addAttribute("county", county);
        model.addAttribute("detailAddress", detailAddress);

        return "store";

    }
    
    @RequestMapping("storeScroll.do")
    public String storeScroll(Model model, String storeType, String page,String area, String county, String detailAddress) {
        
        if(area!=null){
            if(area.equals("시/도 선택")){
                area="";
            }
        }
        if(county!=null){
            if(county.equals("시/구/군 선택")){
                county="";
            }
        }
        if(area==null){
            area="";
        }
        if(county==null){
            county="";
        }
        if(detailAddress==null){
            detailAddress="";
        }
        
        String address = "%" + area + "% %" + county + "% %" + detailAddress + "%";
        
        int iPage;
        if (page == null) {
            iPage=0;
        }else{
            iPage=Integer.parseInt(page);
        }
        
        System.out.println("address : "+address);
        StoreDao storeDao = sqlSession.getMapper(StoreDao.class);
        List<Store> storeList = new ArrayList<Store>();
        System.out.println("storeType=" + storeType);
        if(address.equals("%% %% %%")){
            if (storeType == null||storeType == "") {
                storeList = storeDao.getStores(iPage);
            } else {
                storeList = storeDao.getStoresByStoreType(storeType, iPage);
            }
        }else{
            if (storeType == null||storeType == "") {
                storeList = storeDao.getSearches(address, iPage);
            } else {
                storeList = storeDao.getStoresByStoreTypeAndAddress(address, storeType, iPage);
            }
        }
        
        Gson gs=new Gson();
        String json=gs.toJson(storeList);

        model.addAttribute("json", json);
        System.out.println("ajax데이터 : "+json);

        return "storeScroll";

    }

    @RequestMapping("comment.do")
    public String comment(Model model, String storeName) {

        StoreDao storeDao = sqlSession.getMapper(StoreDao.class);
        List<Comment> commentList = storeDao.getComments(storeName);

        Gson gson = new Gson();
        String json = gson.toJson(commentList);
        System.out.println("json" + json);
        model.addAttribute("json", json);

        return "json";
    }

}
