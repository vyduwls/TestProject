package com.disappear.order.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.disappear.order.dao.MemberDAO;
import com.disappear.order.dao.MenusDAO;
import com.disappear.order.dao.MyPageDao;
import com.disappear.order.vo.BasketList;
import com.disappear.order.vo.Member;
import com.disappear.order.vo.Menus;
import com.disappear.order.vo.ShoppingBasket;
import com.disappear.order.vo.Store;

@Controller
@RequestMapping("/order/*")
public class MenuController {

    @Autowired
    private SqlSession sqlsession;

    @RequestMapping("menuList.do")
    public String menuPan(String storeName, String category, String mseq, Model model, HttpServletRequest request) {
        String mid = (String) request.getSession().getAttribute("mid");
        MenusDAO mybatis = sqlsession.getMapper(MenusDAO.class);
        MyPageDao myPageDao = sqlsession.getMapper(MyPageDao.class);

        MemberDAO memberbatis = sqlsession.getMapper(MemberDAO.class);
        if (mid != null) {
            Member m = memberbatis.getMember(mid);
            model.addAttribute("m", m);
        }
        String sseq = myPageDao.getSseq(storeName);
        List<Menus> menus = mybatis.getMenus(sseq);
        int count = 0;
        ArrayList<String> categorys = new ArrayList<String>();
        categorys.add(menus.get(0).getCategory());
        for (int i = 0; i < menus.size(); i++) {
            for (int j = i; j < menus.size(); j++) {
                if (!menus.get(i).getCategory().equals(menus.get(j).getCategory())) {
                    categorys.add(menus.get(j).getCategory());
                    count++;
                    i = j;
                }
            }
        }
        if (category == null || category.equals("")) {
            category = menus.get(0).getCategory();
        }
        if (mseq != null && mseq.equals("")) {
            model.addAttribute("mseq", mseq);
        }

        // 현재시간 구하기
        String _time = new SimpleDateFormat("hh").format(new Date());
        int time = Integer.parseInt(_time);

        String amPm = new SimpleDateFormat("a").format(new Date());
        System.out.println("시간~~!!~!" + time + amPm);
        if (amPm.equals("오후") && time == 12) {

        }else if (amPm.equals("오후")) {
            time += 12;
        }
        String _minute = new SimpleDateFormat("mm").format(new Date());
        int minute = (Integer.parseInt(_minute) / 5) + 1;
        System.out.println("time" + time);
        model.addAttribute("time", time);
        model.addAttribute("minute", minute);
        model.addAttribute("menus", menus);
        model.addAttribute("categorys", categorys);
        model.addAttribute("category", category);
        model.addAttribute("mid", mid);
        model.addAttribute("storeName", storeName);
        return "order_menuList";
    }

    @RequestMapping("menuModal.do")
    public String detail_menuPan(String mseq, Model model, HttpServletRequest request) {
        MenusDAO mybatis = sqlsession.getMapper(MenusDAO.class);
        Menus detailmenu = mybatis.checkMenus(mseq);
        Gson gs = new Gson();
        String ajaxmenu = gs.toJson(detailmenu);
        model.addAttribute("ajaxmenu", ajaxmenu);

        return "order_menudetail";
    }

    @RequestMapping("shoppingbasketProc.do")
    public String shoppingbasketProc(String num, String hour, String minute, ShoppingBasket basket,
            HttpServletRequest request, Model model) {
        MenusDAO mybatis = sqlsession.getMapper(MenusDAO.class);
        Menus menu = mybatis.checkMenus(basket.getMseq());
        String mid = (String) request.getSession().getAttribute("mid");
        if (Integer.parseInt(hour) <= 9) {
            hour = "0" + hour;
        }
        if (Integer.parseInt(minute) == 0 || Integer.parseInt(minute) == 5) {
            minute = "0" + minute;
        }
        String sysdate = new SimpleDateFormat("YYYY-MM-dd").format(new Date());
        String arriveTime = sysdate + " " + hour + ":" + minute;
        int price = basket.getAmount() * menu.getPrice();
        basket.setMid(mid);
        basket.setTime(arriveTime);
        basket.setPrice(price);
        int af = 0;
        if (num.equals("1")) {
            af = mybatis.inputbasket(basket);
        } else {
            af = mybatis.updateBasketdetail(basket.getAmount(), basket.getPrice(), basket.getRequirements(), num);
        }

        System.out.println("af====" + af);
        model.addAttribute("updatecount", af);

        return "order_gobasket";
    }

    @RequestMapping("shoppingbasket.do")
    public String shoppingbasket(HttpServletRequest request, Model model) {
        MenusDAO mybatis = sqlsession.getMapper(MenusDAO.class);
        String mid = (String) request.getSession().getAttribute("mid");

        if (mid == null) {
            model.addAttribute("code", "1");
            return "redirect:../member/login.do";
        }
        int totalprice = 0;
        List<BasketList> basketList = mybatis.getBaskets(mid);
        int sysmonth = Integer.parseInt(new SimpleDateFormat("MM").format(new Date()));
        int sysday = Integer.parseInt(new SimpleDateFormat("dd").format(new Date()));
        for (int i = 0; i < basketList.size(); i++) {

            // date 자르기
            int month = Integer.parseInt(basketList.get(i).getTime().substring(5, 7));
            int day = Integer.parseInt(basketList.get(i).getTime().substring(8, 10));

            if (month == sysmonth && day == sysday) {
                basketList.get(i).setTime(basketList.get(i).getTime().substring(11, 16));
            }
            totalprice = totalprice + basketList.get(i).getTotalprice();
        }

        model.addAttribute("totalprice", totalprice);
        model.addAttribute("basketList", basketList);
        return "order_shoppingbasket";
    }

    @RequestMapping("delbasket.do")
    public String delbasket(String basketseqs, String all, Model model, HttpServletRequest request) {
        MenusDAO mybatis = sqlsession.getMapper(MenusDAO.class);
        System.out.println("basketseqs====" + basketseqs);
        int af = 0;
        if (all.equals("1")) {
            String mid = (String) request.getSession().getAttribute("mid");
            af = mybatis.allDelBasket(mid);
        } else {

            af = mybatis.delbasket(basketseqs);
        }
        System.out.println("삭제~~~ af===" + af);
        model.addAttribute("af", af);
        return "order_delselect";

    }

    @RequestMapping("updatebasket.do")
    public String updatebasket(String amount1, String basketseq, String menuprice1, Model model) {
        MenusDAO mybatis = sqlsession.getMapper(MenusDAO.class);
        int amount = Integer.parseInt(amount1);
        int menuprice = Integer.parseInt(menuprice1);

        int price = menuprice * amount;
        int af = mybatis.updatebasket(amount, price, basketseq);

        model.addAttribute("af", af);
        return "order_update";
    }

    /*
     * @RequestMapping("order.do") public String order(String
     * basketseqs,HttpServletRequest request,Model model){ MenusDAO
     * mybatis=sqlsession.getMapper(MenusDAO.class); String mid=(String)
     * request.getSession().getAttribute("mid"); List<ShoppingBasket> basketList
     * = new ArrayList<ShoppingBasket>();
     * 
     * 
     * if(basketseqs.equals("0")){ basketList=mybatis.getbaskets(mid); }else{
     * basketList=mybatis.selectbaskets(basketseqs);
     * 
     * }
     * 
     * int af=0; int ad=0; for (int i = 0; i < basketList.size(); i++) {
     * af+=mybatis.menuorder(basketList.get(i)); }
     * 
     * 
     * if(basketseqs.equals("0")){ ad=mybatis.allDelBasket(mid); }else{
     * ad=mybatis.delbasket(basketseqs); } return "order_order"; }
     */

    @RequestMapping("checkshoppingbasket.do")
    public String checkshoppingbasket(String mseq, String hour, String minute, Model model,
            HttpServletRequest request) {

        String mid = (String) request.getSession().getAttribute("mid");
        MenusDAO mybatis = sqlsession.getMapper(MenusDAO.class);
        if (Integer.parseInt(hour) <= 9) {
            hour = "0" + hour;
        }
        if (Integer.parseInt(minute) == 0) {
            minute = "0" + minute;
        }
        String sysdate = new SimpleDateFormat("YYYY-MM-dd").format(new Date());
        String arriveTime = sysdate + " " + hour + ":" + minute;
        System.out.println("mseq======" + mseq);
        System.out.println("arrivetIME=====" + arriveTime);
        String ajax = mybatis.checkshoppingbasket(mid, mseq, arriveTime);
        if (ajax == null) {
            ajax = "0";
        }
        model.addAttribute("ajax", ajax);
        System.out.println("AJAX=====" + ajax);
        return "menus_checkshoppingbasket";
    }

    @RequestMapping("directorder.do")
    public String directorder(String hour, String minute, ShoppingBasket basket, HttpServletRequest request,
            Model model) {
        MenusDAO mybatis = sqlsession.getMapper(MenusDAO.class);
        Menus menu = mybatis.checkMenus(basket.getMseq());

        String mid = (String) request.getSession().getAttribute("mid");

        if (Integer.parseInt(hour) <= 9) {
            hour = "0" + hour;
        }
        if (Integer.parseInt(minute) == 0 || Integer.parseInt(minute) == 5) {
            minute = "0" + minute;
        }

        String sysdate = new SimpleDateFormat("YYYY-MM-dd").format(new Date());
        String arriveTime = sysdate + " " + hour + ":" + minute;
        int price = basket.getAmount() * menu.getPrice();
        basket.setMid(mid);
        basket.setTime(arriveTime);
        basket.setPrice(price);

        mybatis.inputbasket(basket);
        String lastseq = mybatis.outputLastSeq(mid);
        List<BasketList> basketList = mybatis.getselectBaskets(lastseq);
        List<Store> storeList = mybatis.getStoreToBasketSeq(lastseq);

        int sysmonth = Integer.parseInt(new SimpleDateFormat("MM").format(new Date()));
        int sysday = Integer.parseInt(new SimpleDateFormat("dd").format(new Date()));
        for (int i = 0; i < basketList.size(); i++) {

            // date 자르기
            int month = Integer.parseInt(basketList.get(i).getTime().substring(5, 7));
            int day = Integer.parseInt(basketList.get(i).getTime().substring(8, 10));

            if (month == sysmonth && day == sysday) {
                basketList.get(i).setTime(basketList.get(i).getTime().substring(11, 16));
            }
        }

        model.addAttribute("totalprice", basket.getPrice());
        model.addAttribute("basketList", basketList);
        model.addAttribute("storeList", storeList);
        model.addAttribute("basketseqs", lastseq);
        return "order_order";
    }

    // 장바구니에서 결제로 가기
    @RequestMapping("order.do")
    public String order(String basketseqs, HttpServletRequest request, Model model) {
        MenusDAO mybatis = sqlsession.getMapper(MenusDAO.class);

        String mid = (String) request.getSession().getAttribute("mid");
        List<BasketList> basketList = new ArrayList<BasketList>();
        List<Store> storeList = new ArrayList<Store>();

        if (basketseqs.equals("0")) {
            basketList = mybatis.getBaskets(mid);
            storeList = mybatis.getStoreToBasketMid(mid);
        } else {
            basketList = mybatis.getselectBaskets(basketseqs);
            storeList = mybatis.getStoreToBasketSeq(basketseqs);
        }
        int totalprice = 0;
        int sysmonth = Integer.parseInt(new SimpleDateFormat("MM").format(new Date()));
        int sysday = Integer.parseInt(new SimpleDateFormat("dd").format(new Date()));
        for (int i = 0; i < basketList.size(); i++) {

            // date 자르기
            int month = Integer.parseInt(basketList.get(i).getTime().substring(5, 7));
            int day = Integer.parseInt(basketList.get(i).getTime().substring(8, 10));

            if (month == sysmonth && day == sysday) {
                basketList.get(i).setTime(basketList.get(i).getTime().substring(11, 16));
            }
            totalprice = totalprice + basketList.get(i).getTotalprice();
        }

        model.addAttribute("storeList", storeList);
        model.addAttribute("totalprice", totalprice);
        model.addAttribute("basketList", basketList);
        model.addAttribute("basketseqs", basketseqs);
        return "order_order";
    }

    @RequestMapping("orderProc.do")
    public String orderProc(String basketseqs, HttpServletRequest request, Model model) {
        MenusDAO mybatis = sqlsession.getMapper(MenusDAO.class);
        String mid = (String) request.getSession().getAttribute("mid");
        List<ShoppingBasket> basketList = new ArrayList<ShoppingBasket>();

        if (basketseqs.equals("0")) {
            basketList = mybatis.getbaskets(mid);
        } else {
            basketList = mybatis.selectbaskets(basketseqs);

        }

        int af = 0;
        int ad = 0;
        for (int i = 0; i < basketList.size(); i++) {
            af += mybatis.menuorder(basketList.get(i));
        }

        if (basketseqs.equals("0")) {
            ad = mybatis.allDelBasket(mid);
        } else {
            ad = mybatis.delbasket(basketseqs);
        }
        return "redirect:../mypage/orderList.do";
    }
}
