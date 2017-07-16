package com.disappear.order.controllers;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.disappear.order.dao.MenusDAO;
import com.disappear.order.dao.MyPageDao;
import com.disappear.order.util.ChangeURL;
import com.disappear.order.vo.Comment;
import com.disappear.order.vo.Menus;
import com.disappear.order.vo.Notice;
import com.disappear.order.vo.OrderList;
import com.disappear.order.vo.SalesList;
import com.disappear.order.vo.Store;
import com.google.gson.Gson;

@Controller
@RequestMapping("/mypage/*")
public class MyPageController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping("mypage.do")
    public String index(HttpServletRequest request, Model model) {

        String mid = (String) request.getSession().getAttribute("mid");
        if (mid == null) {
            model.addAttribute("code", "1");
            return "redirect:../member/login.do";
        }
        return "mypage";
    }

    @RequestMapping("regStore.do")
    public String regStore(HttpServletRequest request, Model model) {

        return "mypage_reg_store";

    }

    @RequestMapping("regMenu.do")
    public String regMenu(HttpServletRequest request, Model model) {

        String mid = (String) request.getSession().getAttribute("mid");

        MyPageDao myPageDao = sqlSession.getMapper(MyPageDao.class);

        List<Store> sseqList = myPageDao.getStoreList(mid);

        model.addAttribute("sseqList", sseqList);

        return "mypage_reg_menu";

    }

    @RequestMapping("regStoreProc.do")
    public String store(String area, String county, String detailAddress, Store store, HttpServletRequest request,
            @RequestParam("imgFile") MultipartFile imgFile) {

        String writer = (String) request.getSession().getAttribute("mid");
        MyPageDao myPageDao = sqlSession.getMapper(MyPageDao.class);
        String address = area + " " + county + " " + detailAddress;
        store.setAddress(address);

        // upload
        String root = request.getSession().getServletContext().getRealPath("/");
        String savePath = root + "upload";

        String fullPath = null;
        String originalFilename = imgFile.getOriginalFilename();
        System.out.println(imgFile.getOriginalFilename());
        if (imgFile.getOriginalFilename() != "") {
            String onlyFileName = originalFilename.substring(0, originalFilename.indexOf("."));
            String extension = originalFilename.substring(originalFilename.indexOf("."));

            long time = System.currentTimeMillis();
            SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd-HH-mm-ss", Locale.KOREA);
            String sTime = dayTime.format(new Date(time));

            String rename = onlyFileName + "_" + sTime + extension;
            fullPath = savePath + "\\" + rename;

            if (!imgFile.isEmpty()) {

                try {
                    byte[] bytes = imgFile.getBytes();
                    BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(fullPath)));
                    stream.write(bytes);
                    stream.close();
                    System.out.println("upload success");
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    System.out.println("upload fail");
                    e.printStackTrace();
                }
            } else {
                System.out.println("image not found");
            }

        }
        store.setImages(fullPath);
        store.setWriter(writer);

        int insertCount = myPageDao.regStore(store);

        if (insertCount > 0) {
            System.out.println("insert success");
        } else {
            System.out.println("insert fail");

        }

        return "mypage";

    }

    @RequestMapping("updateStore.do")
    public String updateStore(Model model, HttpServletRequest request) {

        String mid = (String) request.getSession().getAttribute("mid");

        MyPageDao myPageDao = sqlSession.getMapper(MyPageDao.class);

        List<Store> storeList = myPageDao.getStoreList(mid);

        model.addAttribute("storeList", storeList);

        return "mypage_update_store";

    }

    @RequestMapping("editStore.do")
    public String editStore(Store store,String area, String county, String detailAddress, HttpServletRequest request, @RequestParam("imgFile") MultipartFile imgFile) {

        String address=area+" "+county+" "+detailAddress;
        MyPageDao myPageDao = sqlSession.getMapper(MyPageDao.class);

        System.out.println("ㅡㅡ" + imgFile.getOriginalFilename());
        store.setAddress(address);
        int updateCount=0;
        if (imgFile.getOriginalFilename().equals("")) {
            updateCount = myPageDao.updateStoreNotChangeImg(store);

        } else {

            // upload
            String root = request.getSession().getServletContext().getRealPath("/");
            String savePath = root + "upload";

            String fullPath = null;
            String originalFilename = imgFile.getOriginalFilename();
            System.out.println(imgFile.getOriginalFilename());
            if (imgFile.getOriginalFilename() != "") {
                String onlyFileName = originalFilename.substring(0, originalFilename.indexOf("."));
                String extension = originalFilename.substring(originalFilename.indexOf("."));

                long time = System.currentTimeMillis();
                SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd-HH-mm-ss", Locale.KOREA);
                String sTime = dayTime.format(new Date(time));

                String rename = onlyFileName + "_" + sTime + extension;
                fullPath = savePath + "\\" + rename;

                if (!imgFile.isEmpty()) {

                    try {
                        byte[] bytes = imgFile.getBytes();
                        BufferedOutputStream stream = new BufferedOutputStream(
                                new FileOutputStream(new File(fullPath)));
                        stream.write(bytes);
                        stream.close();
                        System.out.println("upload success");
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        System.out.println("upload fail");
                        e.printStackTrace();
                    }
                } else {
                    System.out.println("image not found");
                }

            }
            store.setImages(fullPath);
        updateCount = myPageDao.updateStore(store);
        }

        if (updateCount > 0) {
            System.out.println(updateCount + "update success");
        } else {
            System.out.println(updateCount + "update fail");
        }
        return "mypage";
    }

    @RequestMapping("regMenuProc.do")
    public String regMenuProc(String storename, Menus menus, HttpServletRequest request,
            @RequestParam("imgFile") MultipartFile imgFile) {

        MyPageDao myPageDao = sqlSession.getMapper(MyPageDao.class);

        // upload
        String root = request.getSession().getServletContext().getRealPath("/");
        String savePath = root + "upload";

        String fullPath = null;
        String originalFilename = imgFile.getOriginalFilename();
        System.out.println(imgFile.getOriginalFilename());
        if (imgFile.getOriginalFilename() != "") {
            String onlyFileName = originalFilename.substring(0, originalFilename.indexOf("."));
            String extension = originalFilename.substring(originalFilename.indexOf("."));

            long time = System.currentTimeMillis();
            SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd-HH-mm-ss", Locale.KOREA);
            String sTime = dayTime.format(new Date(time));

            String rename = onlyFileName + "_" + sTime + extension;
            fullPath = savePath + "\\" + rename;

            if (!imgFile.isEmpty()) {

                try {
                    byte[] bytes = imgFile.getBytes();
                    BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(fullPath)));
                    stream.write(bytes);
                    stream.close();
                    System.out.println("upload success");
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    System.out.println("upload fail");
                    e.printStackTrace();
                }
            } else {
                System.out.println("image not found");
            }

        }
        menus.setImg(fullPath);
        String sseq = myPageDao.getSseq(storename);
        menus.setSseq(sseq);
        int insertCount = myPageDao.insertMenus(menus);

        if (insertCount > 0) {
            System.out.println("insert success");
        } else {
            System.out.println("insert fail");

        }

        return "mypage";

    }

    @RequestMapping("updateMenu.do")
    public String updateMenu(Model model, HttpServletRequest request) {

        String mid = (String) request.getSession().getAttribute("mid");

        MenusDAO menusDao = sqlSession.getMapper(MenusDAO.class);
        MyPageDao myPageDao = sqlSession.getMapper(MyPageDao.class);

        List<Store> sseqList = myPageDao.getStoreList(mid);
        List<List<Menus>> menusListList = new ArrayList<List<Menus>>();
        for (Store sseq : sseqList) {
            List<Menus> menusList = menusDao.getMenus(sseq.getSeq());
            menusListList.add(menusList);
        }

        model.addAttribute("sseqList", sseqList);
        model.addAttribute("menusListList", menusListList);

        return "mypage_update_menu";

    }

    @RequestMapping("orderList.do")
    public String orderList(Model model, HttpServletRequest request) {
        String mid = (String) request.getSession().getAttribute("mid");
        // 다오 부르기
        MyPageDao mybatis = sqlSession.getMapper(MyPageDao.class);
        // 리스트 뽑기
        // mybatis.updateOrderTime(mid);
        List<OrderList> orderList = mybatis.getOrderList(mid);
        List<Comment> commentsList = mybatis.selectComments(mid);
        int sysmonth = Integer.parseInt(new SimpleDateFormat("MM").format(new Date()));
        int sysday = Integer.parseInt(new SimpleDateFormat("dd").format(new Date()));
        for (int i = 0; i < orderList.size(); i++) {

            // date 자르기
            String odate = orderList.get(i).getOrderdate().substring(0, 16);
            orderList.get(i).setOrderdate(odate);
            int month = Integer.parseInt(orderList.get(i).getOrderdate().substring(5, 7));
            int day = Integer.parseInt(orderList.get(i).getOrderdate().substring(8, 10));

            if (month == sysmonth && day == sysday) {
                orderList.get(i).setPickupTime(orderList.get(i).getPickupTime().substring(11, 16));
            }

            // 댓글 단거 확인하기
            orderList.get(i).setCommentsstate("0");
            for (int j = 0; j < commentsList.size(); j++) {
                if (orderList.get(i).getOrderseq().equals(commentsList.get(j).getCoseq())) {
                    orderList.get(i).setCommentsstate(commentsList.get(j).getCseq());
                }
            }
        }
        model.addAttribute("orderList", orderList);
        model.addAttribute("commentsList", commentsList);

        return "mypage_orderList";
    }

    @RequestMapping("insertComment.do")
    public String insertComment(Comment comment, Model model, HttpServletRequest request,
            @RequestParam("imgFile") MultipartFile imgFile) {
        String mid = (String) request.getSession().getAttribute("mid");
        comment.setCmid(mid);
        MyPageDao mybatis = sqlSession.getMapper(MyPageDao.class);

        // upload
        String root = request.getSession().getServletContext().getRealPath("/");
        String savePath = root + "upload";

        String fullPath = null;
        String originalFilename = imgFile.getOriginalFilename();
        System.out.println(imgFile.getOriginalFilename());
        if (imgFile.getOriginalFilename() != "") {
            String onlyFileName = originalFilename.substring(0, originalFilename.indexOf("."));
            String extension = originalFilename.substring(originalFilename.indexOf("."));

            long time = System.currentTimeMillis();
            SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd-HH-mm-ss", Locale.KOREA);
            String sTime = dayTime.format(new Date(time));

            String rename = onlyFileName + "_" + sTime + extension;
            fullPath = savePath + "\\" + rename;

            if (!imgFile.isEmpty()) {

                try {
                    byte[] bytes = imgFile.getBytes();
                    BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(fullPath)));
                    stream.write(bytes);
                    stream.close();
                    System.out.println("upload success");
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    System.out.println("upload fail");
                    e.printStackTrace();
                }
            } else {
                System.out.println("image not found");
            }

        }
        comment.setImages(fullPath);

        int af = mybatis.insertComment(comment);
        System.out.println("af====" + af);
        return "redirect:orderList.do";
    }

    @RequestMapping("selectComment.do")
    public String selectComment(String cseq, Model model, HttpServletRequest request) {
        MyPageDao mybatis = sqlSession.getMapper(MyPageDao.class);
        Comment com1 = mybatis.getComment(cseq);
        if (com1.getImages() != null) {
            String[] imagesArray = com1.getImages().split("\\\\");
            String image = request.getContextPath() + "/" + imagesArray[imagesArray.length - 2] + "/"
                    + imagesArray[imagesArray.length - 1];
            com1.setImages(image);
        }
        Gson gs = new Gson();
        String com = gs.toJson(com1);
        model.addAttribute("com", com);
        return "mypage_getComment";
    }

    @RequestMapping("delComment.do")
    public String delComment(String cseq) {
        MyPageDao mybatis = sqlSession.getMapper(MyPageDao.class);
        int af = mybatis.delComment(cseq);
        System.out.println("딜리트af===" + af);

        return "redirect:orderList.do";
    }

    @RequestMapping("storeSales.do")
    public String storeSales(Model model, HttpServletRequest request, String seq, String month) {

        String mid = (String) request.getSession().getAttribute("mid");
        MyPageDao mybatis = sqlSession.getMapper(MyPageDao.class);
        List<Store> storeList = mybatis.getstoreseq(mid);

        if (seq == null || seq.equals("")) {
            seq = storeList.get(0).getSeq();
        }

        if (month == null || month.equals("")) {
            month = new SimpleDateFormat("MM").format(new Date());
        } else {
            if (Integer.parseInt(month) <= 9) {
                month = "0" + month;
            }
        }
        String storeName = mybatis.getStoreName(seq);
        List<SalesList> exsalesList = mybatis.getSales(mid, seq, month);

        int mon = Integer.parseInt(month);

        int day = 0;
        if (mon == 2) {
            day = 28;
        } else if ((mon <= 7 && mon % 2 == 1) || (mon > 7 && mon % 2 == 0)) {
            day = 31;
        } else {
            day = 30;
        }

        // 리스트 값 넣기
        List<SalesList> salesList = new ArrayList<SalesList>();
        for (int i = 0; i < day; i++) {
            SalesList saless = new SalesList();
            saless.setStoreName(storeName);
            saless.setSales("0");
            if (i < 9) {
                saless.setSalesDate(month + "/0" + (i + 1));
            } else {
                saless.setSalesDate(month + "/" + (i + 1));
            }
            salesList.add(saless);
        }

        // sales배열 크기 맞추기
        if (exsalesList.size() != 0) {
            for (int i = 0; i < exsalesList.size(); i++) {
                for (int j = 1; j <= day; j++) {
                    int saledate = Integer.parseInt(exsalesList.get(i).getSalesDate().substring(3, 5));
                    if (j == saledate) {
                        salesList.get(j - 1).setSales(exsalesList.get(i).getSales());
                        salesList.get(j - 1).setSalesDate(exsalesList.get(i).getSalesDate());
                        break;
                    }
                }
            }
        }
        // data 뽑기
        String data = "[['Year', 'Sales'],";
        for (int i = 0; i < salesList.size(); i++) {
            if (i == salesList.size() - 1) {
                data += "['" + (i + 1) + "'," + salesList.get(i).getSales() + "]";
            } else {
                data += "['" + (i + 1) + "'," + salesList.get(i).getSales() + "],";
            }
        }
        data += "]";

        DecimalFormat df = new DecimalFormat("#,##0");
        String totalSales = "0";
        int totals = 0;
        if (exsalesList.size() != 0) {
            for (int i = 0; i < salesList.size(); i++) {
                totals += Integer.parseInt(salesList.get(i).getSales());
                double price = (double) (Integer.parseInt(salesList.get(i).getSales()));
                salesList.get(i).setSales(df.format(price));
            }
            totalSales = df.format((double) totals);
        }

        model.addAttribute("exsalesList", exsalesList);
        model.addAttribute("storeList", storeList);
        model.addAttribute("salesList", salesList);
        model.addAttribute("data", data);
        model.addAttribute("day", day);
        model.addAttribute("mon", mon);
        model.addAttribute("Nowmonth", new SimpleDateFormat("MM").format(new Date()));
        model.addAttribute("seq", seq);
        model.addAttribute("totalSales", totalSales);
        return "mypage_storeSales";
    }

    @RequestMapping("getDaysSales.do")
    public String getDaysSales(String day, String storeSeq, String mon, Model model) {
        MyPageDao mybatis = sqlSession.getMapper(MyPageDao.class);
        if (Integer.parseInt(mon) <= 9) {
            mon = "0" + mon;
        }
        if (Integer.parseInt(day) <= 9) {
            day = "0" + day;
        }
        String date = mon + "/" + day;

        List<OrderList> exdayorderList = mybatis.getdayOrderList(storeSeq, date);

        for (int i = 0; i < exdayorderList.size(); i++) {
            exdayorderList.get(i).setPickupTime(exdayorderList.get(i).getOrderdate().substring(11, 16));
            exdayorderList.get(i).setOrderdate(exdayorderList.get(i).getOrderdate().substring(0, 11));
        }
        Gson gs = new Gson();
        String dayorderList = gs.toJson(exdayorderList);

        model.addAttribute("dayorderList", dayorderList);
        return "mypage_getDaysSales";
    }

    @RequestMapping("noticeList.do")
    public String noticeList(Model model, HttpServletRequest request, String f, String q, String pg, String m, String s){
    	
    	System.out.println("어노테이션 noticeList.do");
    	
    	String mid = (String)request.getSession().getAttribute("mid");
    	System.out.println("mid : " + mid);
    	
    	if(f==null||f.equals("")){
            f="TITLE";
        }
    	
        if(q==null || q.equals("")){
            q="";
        }
        
        int ipg=0;
        if(pg!=null&& !pg.equals("")){
            ipg = Integer.parseInt(pg);
        }else{
            ipg=1;
        }
        
        MyPageDao myBatis = sqlSession.getMapper(MyPageDao.class);
	    List<Notice>list = null;
        
        int seqCount=0;
        
        if(f.equals("")){
        	seqCount=myBatis.getSeqCount(f, q, mid);
        	list = myBatis.getMyNoticeNone(ipg, q, mid);
        } else if(f.equals("POSITION")){
        	seqCount=myBatis.getSeqCount(f, q, mid);
        	list = myBatis.getMyNoticePosition(ipg, q, mid);
        } else if(f.equals("STORE")){
        	seqCount=myBatis.getSeqCount(f, q, mid);
        	list = myBatis.getMyNoticeStore(ipg, q, mid);
        } else {
        	seqCount=myBatis.getSeqCount1(q, mid);
        	list = myBatis.getMyNoticeTitleContent(ipg, q, mid);
        }
	    
        if(q.equals(s)){
        	s = ChangeURL.getUrlDecode(s);
        }
        
        String _query = null;       
        _query = ChangeURL.getUrlFormat(q);
        
        int finalFN = seqCount/15 +(seqCount%15==0?0:1);
        int startFN = ipg-(ipg-1)%5;
        
        System.out.println(seqCount);
        
        model.addAttribute("f", f);
        model.addAttribute("q",_query);
        model.addAttribute("pg", ipg);
        model.addAttribute("finalFN", finalFN);
        model.addAttribute("startFN", startFN);
        model.addAttribute("s", s);
        model.addAttribute("m", m);
	    model.addAttribute("list", list);
	    
	    System.out.println("ipg : "+ipg);
        System.out.println("startFN : "+startFN);
        System.out.println("finalFN : "+finalFN);
    	
    	return "mypage_noticeList";
    }
    
    @RequestMapping(value={"noticeListSearch.do"}, method={RequestMethod.GET,RequestMethod.POST})
    public String noticeSearch(String f, String q, String pg, Model model, String menu, String search, String m1, HttpServletRequest request){
        System.out.println("어노테이션 notiecListSearch.do");
        
        String mid = (String)request.getSession().getAttribute("mid");

        if(f==null||f.equals("")){
            f="TITLE";
        }
        if(q==null){
            q="";
        }
        
        int ipg=0;
        if(pg!=null&& !pg.equals("")){
            ipg = Integer.parseInt(pg);
        }else{
            ipg=1;
        }
        
        List<Notice> list = null;
        
        MyPageDao myBatis = sqlSession.getMapper(MyPageDao.class);
        
        if(menu.equals(null) || menu.equals("")){
        	menu = m1;
        }
        
        q=search;
        
        if(menu.equals("Title Content")){
        	f = "CONTENT";
        	list = myBatis.getMyNoticeTitleContent(ipg, search, mid);
        } else if(menu.equals("Position")){
        	f = "POSITION";
        	list = myBatis.getMyNoticePosition(ipg, search, mid);
        } else if(menu.equals("Store")){
        	f = "STORE";
        	if(search.equals("맥도날드")){
        		search = "mac";
        	} else if(search.equals("스타벅스")){
        		search = "star";
        	}
        	list = myBatis.getMyNoticeStore(ipg, search, mid);
        }
        
        int seqCount=0;
        
        if(f.equals("CONTENT")){
        	seqCount=myBatis.getSeqCount1(q, mid);
        } else{
        	seqCount=myBatis.getSeqCount(f, q, mid);
        }
        
        
        String _query = null;       
        _query = ChangeURL.getUrlFormat(q);
        
        System.out.println(seqCount);
        
        int finalFN = seqCount/15 +(seqCount%15==0?0:1);
        int startFN = ipg-(ipg-1)%5;
        
        System.out.println("ipg : "+ipg);
        System.out.println("startFN : "+startFN);
        System.out.println("finalFN : "+finalFN);
        
        model.addAttribute("f", f);
        model.addAttribute("q",_query);
        model.addAttribute("pg", ipg);
		model.addAttribute("list", list);
        model.addAttribute("finalFN", finalFN);
        model.addAttribute("startFN", startFN);
        model.addAttribute("s", search);
        model.addAttribute("m", menu);
        
        return "mypage_noticeList";
    }

    @RequestMapping("getMenus.do")
    public String getMenus(Model model, String storeName) {

        MenusDAO menusDao = sqlSession.getMapper(MenusDAO.class);
        MyPageDao mypageDao = sqlSession.getMapper(MyPageDao.class);

        String sseq = mypageDao.getSseq(storeName);
        List<Menus> menusList = menusDao.getMenus(sseq);

        Gson gson = new Gson();
        String json = gson.toJson(menusList);
        System.out.println("json" + json);
        model.addAttribute("json", json);

        return "mypage_getMenus";
    }

    @RequestMapping("updateMenuProc.do")
    public String updateMenuProc(String storename, HttpServletRequest request, Menus menus,
            @RequestParam("imgFile") MultipartFile imgFile) {
        
        int updateCount=0;
        MyPageDao mypageDao = sqlSession.getMapper(MyPageDao.class);
        if (imgFile.getOriginalFilename().equals("")) {
            updateCount = mypageDao.updateMenuNotChangeImg(menus);

        } else {

            // upload
            String root = request.getSession().getServletContext().getRealPath("/");
            String savePath = root + "upload";

            String fullPath = null;
            String originalFilename = imgFile.getOriginalFilename();
            System.out.println(imgFile.getOriginalFilename());
            if (imgFile.getOriginalFilename() != "") {
                String onlyFileName = originalFilename.substring(0, originalFilename.indexOf("."));
                String extension = originalFilename.substring(originalFilename.indexOf("."));

                long time = System.currentTimeMillis();
                SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd-HH-mm-ss", Locale.KOREA);
                String sTime = dayTime.format(new Date(time));

                String rename = onlyFileName + "_" + sTime + extension;
                fullPath = savePath + "\\" + rename;

                if (!imgFile.isEmpty()) {

                    try {
                        byte[] bytes = imgFile.getBytes();
                        BufferedOutputStream stream = new BufferedOutputStream(
                                new FileOutputStream(new File(fullPath)));
                        stream.write(bytes);
                        stream.close();
                        System.out.println("upload success");
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        System.out.println("upload fail");
                        e.printStackTrace();
                    }
                } else {
                    System.out.println("image not found");
                }

            }
            menus.setImg(fullPath);

        updateCount = mypageDao.updateMenu(menus);
        }

        if (updateCount > 0) {
            System.out.println(updateCount + "update success");
        } else {
            System.out.println(updateCount + "update fail");
        }

        return "mypage";
    }

    @RequestMapping("getOrderList_store.do")
    public String getOrderList_store(Model model, HttpServletRequest request, String seq) {
        String mid = (String) request.getSession().getAttribute("mid");
        MyPageDao mybatis = sqlSession.getMapper(MyPageDao.class);
        List<Store> storeList = mybatis.getstoreseq(mid);
        if (seq == null || seq.equals("")) {
            seq = storeList.get(0).getSeq();
        }
        String storeName = mybatis.getStoreName(seq);
        List<OrderList> orderList = mybatis.getOrderListToSeq(seq);

        int sysmonth = Integer.parseInt(new SimpleDateFormat("MM").format(new Date()));
        int sysday = Integer.parseInt(new SimpleDateFormat("dd").format(new Date()));
        for (int i = 0; i < orderList.size(); i++) {

            // date 자르기
            String odate = orderList.get(i).getOrderdate().substring(0, 16);
            orderList.get(i).setOrderdate(odate);
            int month = Integer.parseInt(orderList.get(i).getOrderdate().substring(5, 7));
            int day = Integer.parseInt(orderList.get(i).getOrderdate().substring(8, 10));
            if (month == sysmonth && day == sysday) {
                orderList.get(i).setPickupTime(orderList.get(i).getPickupTime().substring(11, 16));
            }

        }
        model.addAttribute("seq", seq);
        model.addAttribute("storeName", storeName);
        model.addAttribute("storeList", storeList);
        model.addAttribute("orderList", orderList);
        return "mypage_getOrderList_store";
    }

    @RequestMapping("updateOrderstatement.do")
    public String updateOrderstatement(String seq, String index, Model model) {

        MyPageDao mybatis = sqlSession.getMapper(MyPageDao.class);
        int af = mybatis.updateOrderstatement(seq);
        model.addAttribute("index", index);
        return "mypage_updateOrderstatement";
    }

}