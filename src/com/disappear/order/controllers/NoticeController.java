package com.disappear.order.controllers;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.interceptor.DefaultTransactionAttribute;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.disappear.order.dao.NoticeDAO;
import com.disappear.order.util.ChangeURL;
import com.disappear.order.vo.NComment;
import com.disappear.order.vo.NCommentRec;
import com.disappear.order.vo.Notice;
import com.disappear.order.vo.NoticeRecommend;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
    
    @Autowired
    private SqlSession sqlsession;
    
    @Autowired
	private PlatformTransactionManager ptm;
    
//  private NoticeDAO ndao;

    @RequestMapping(value={"notice.do"}, method=RequestMethod.GET)
    public String notice(String pg, String f, String q, String seq, Model model, String s, String m){
        System.out.println("어노테이션 notiec.do");

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
        
        int seqCount = 0;
        
        NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
        List<Notice>list = null;  
        
        System.out.println(f);
        
        if(f.equals("CONTENT")){
        	seqCount=myBatis.getSeqCount1(q);
        	list = myBatis.getSearchTitleContent(ipg, q);
        } else{
        	seqCount=myBatis.getSeqCount(f, q);
        	list = myBatis.getNotices(ipg,f,q); 
        }
        
        //페이징 검색 결과 오류나면 위에 else if 해주기 (MyPageDao 참고@!!!!!!!!!!!!!!!!!!!!!!!!!!)
        
        int finalFN = seqCount/15 +(seqCount%15==0?0:1);
        int startFN = ipg-(ipg-1)%5;
        
        //게시글 댓글 받아오기
        List<NComment> cList = myBatis.getNCommentCount();
        
        if(q.equals(s)){
        	s = ChangeURL.getUrlDecode(s);
        }
        
        String _query = null;       
        _query = ChangeURL.getUrlFormat(q);
        
        model.addAttribute("cList", cList);
        model.addAttribute("seq", seq);
        model.addAttribute("f", f);
        model.addAttribute("pg", ipg);
        model.addAttribute("q", _query);
        model.addAttribute("list", list);
        model.addAttribute("finalFN", finalFN);
        model.addAttribute("startFN", startFN);
        model.addAttribute("s", s);
        model.addAttribute("m", m);
        
        return "notice_notice";
    }
    
    @RequestMapping(value={"noticeSearch.do"}, method={RequestMethod.GET,RequestMethod.POST})
    public String noticeSearch(String f, String q, String pg, String seq, Model model, String menu, String search, String m1){
        System.out.println("어노테이션 notiecSearch.do");

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
        
        NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
        
        if(menu.equals(null) || menu.equals("")){
        	menu = m1;
        }
        
        q=search;
        
        if(menu.equals("Title Content")){
        	f = "CONTENT";
        	list = myBatis.getSearchTitleContent(ipg, search);
        } else if(menu.equals("Writer")){
        	f = "WRITER";
        	list = myBatis.getSearchWriter(ipg, search);
        } else if(menu.equals("Position")){
        	f = "POSITION";
        	list = myBatis.getSearchPosition(ipg, search);
        } else if(menu.equals("Store")){
        	f = "STORE";
        	if(search.equals("맥도날드")){
        		search = "mac";
        	} else if(search.equals("스타벅스")){
        		search = "star";
        	}
        	list = myBatis.getSearchStore(ipg, search);
        }
        
        int seqCount=0;
        
        if(f.equals("CONTENT")){
        	seqCount=myBatis.getSeqCount1(q);
        } else{
        	seqCount=myBatis.getSeqCount(f, q);
        }
        
        
        String _query = null;       
        _query = ChangeURL.getUrlFormat(q);
        
        System.out.println("seqcount : "+seqCount);
        
        int finalFN = seqCount/15 +(seqCount%15==0?0:1);
        int startFN = ipg-(ipg-1)%5;
        
        model.addAttribute("f", f);
        model.addAttribute("q",_query);
        model.addAttribute("seq", seq);
        model.addAttribute("pg", ipg);
		model.addAttribute("list", list);
        model.addAttribute("finalFN", finalFN);
        model.addAttribute("startFN", startFN);
        model.addAttribute("s", search);
        model.addAttribute("m", menu);
        
        return "notice_notice";
    }
    
    
    @RequestMapping(value={"noticeDetail.do"}, method=RequestMethod.GET)
    public String noticeDetail(String seq, Model model,String h,String f, String q, String pg,  HttpServletRequest request, String nL, String m, String s){
        System.out.println("어노테이션 notiecDetail.do");
        System.out.println("디테일에서 SEQ====="+seq);
        String mid = (String)request.getSession().getAttribute("mid");
        NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
        if(h==null){
            h="0";
        }
        if(h.equals("1")){
            myBatis.hitCount(seq);
        }
        
        if(q==null){
            q="";
        }
        
        String _query = null;       
        _query = ChangeURL.getUrlFormat(q);
        
        if(mid==null){
            request.getSession().setAttribute("returnURL", "/notice/noticeDetail.do?seq="+seq+"&q="+_query+"&f="+f+"&h=0");
            return "redirect:../member/login.do";
        }
        
        Notice n = myBatis.getNotice(seq);
        NoticeRecommend nr = myBatis.getNoticeRec(mid, seq);
        
        List<NComment> list = myBatis.getNComments(seq);
        
        model.addAttribute("nL", nL);
        model.addAttribute("seq", seq);
        model.addAttribute("f", f);
        model.addAttribute("q", _query);
        model.addAttribute("n", n);
        model.addAttribute("pg", pg);
        model.addAttribute("list", list);
        model.addAttribute("nr", nr);
        model.addAttribute("m", m);
        model.addAttribute("s", s);
        
        if(n.getFileSrc()!=null){
            String urlfname = null;
            
            urlfname = ChangeURL.getUrlFormat(n.getFileSrc());
            request.setAttribute("urlfname", urlfname);
        }

        return "notice_noticeDetail";
    }
    
    
    @RequestMapping(value={"noticeEdit.do"}, method=RequestMethod.GET)
    public String noticeEdit(String seq, String pg, String f, String q, Model model, String s, String m, String nL, String stars){
        System.out.println("어노테이션 notiecEdit.do111111111111111");
        NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
        Notice n = myBatis.getNotice(seq);
        
        String _query = ChangeURL.getUrlFormat(q);
        System.out.println("notice에디트타이틀==="+n.getTitle());
        System.out.println("notice에디트내용==="+n.getContent());
        
        System.out.println("s : " + s);
        System.out.println("m : " + m);
        System.out.println(nL);
        
        model.addAttribute("seq", seq);
        model.addAttribute("n", n);
        model.addAttribute("pg", pg);
        model.addAttribute("f", f);
        model.addAttribute("q", _query);
        model.addAttribute("s", s);
        model.addAttribute("m", m);
        model.addAttribute("nL", nL);
        model.addAttribute("stars", stars);

        return "notice_noticeEdit";
    }
    
    @RequestMapping(value={"noticeEdit.do"}, method=RequestMethod.POST)
    public String noticeEditProc(String seq, String title, String content, String pg, String f, String q, Model model, String area, String county, String county1, String area1, String s, String m, String nL, String stars){
        System.out.println("어노테이션 notiecEditProc.do----------------");
        String _query = null;
        
        _query = ChangeURL.getUrlFormat(q);
        
        System.out.println("county1 : " +county1);
        System.out.println("area1 : " +area1);
        
        NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
        Notice n = myBatis.getNotice(seq);
        
        String position = null;
        
        if(area.equals(null) || area.equals("")){
        	position = area1 + "/" + county1;
        } else {
        	position = area + "/" + county;
        }
        
        if(stars.equals("★☆☆☆☆")){
        	stars = "1";
        } else if(stars.equals("★★☆☆☆")){
        	stars = "2";
        } else if(stars.equals("★★★☆☆")){
        	stars = "3";
        } else if(stars.equals("★★★★☆")){
        	stars = "4";
        } else if(stars.equals("★★★★★")){
        	stars = "5";
        }
        
        int stars1 = Integer.parseInt(stars);
        
        n.setStars(stars1);
        n.setTitle(title);
        n.setContent(content);
        n.setPosition(position);
        System.out.println(position);
        
        System.out.println("s : " + s);
        System.out.println("m : " + m);
        System.out.println(nL);
        
        int af = myBatis.modifyContent(n);
        if(af==1){
            System.out.println("수정완료");
//          model.addAttribute("n", n);
            if(!nL.equals("1")){
            	return "redirect:noticeDetail.do?seq="+seq+"&pg="+pg+"&f="+f+"&q="+_query+"&s="+_query+"&m="+m;
            } else {
            	return "redirect:noticeDetail.do?seq="+seq+"&pg="+pg+"&f="+f+"&q="+_query+"&s="+_query+"&m="+m+"&nL=1";
            }
        }else{
            System.out.println("수정실패");
            return "redirect:noticeDetail.do?seq="+seq+"&pg="+pg+"&f="+f+"&q="+_query+"&s="+_query+"&m="+m;
        }
    }
    
    // 2) 글 등록 1
    @RequestMapping(value = { "noticeReg.do" }, method = RequestMethod.GET)
    public String noticeReg(String pg, HttpServletRequest request, Model model) {
        System.out.println("어노테이션 notiecReg.do");

        String mid = (String) request.getSession().getAttribute("mid");

        if (mid == null) {
            request.getSession().setAttribute("returnURL", "/notice/noticeReg.do");
            return "redirect:../member/login.do";
        }

        model.addAttribute("pg", pg);
        return "notice_noticeReg";
    }

    // 2) 글 등록 2
    @RequestMapping(value = { "noticeReg.do" }, method = { RequestMethod.POST })
    public String noticeRegProc(HttpServletRequest request, @RequestParam("imgFile") MultipartFile imgFile, Notice n,
            String area, String county) {
        System.out.println("어노테이션 notiecRegProc.do");

        String root = request.getSession().getServletContext().getRealPath("/");
        String savePath = root + "upload";

        NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);

        String writer = (String) request.getSession().getAttribute("mid");
        if (writer == null) {
            request.getSession().setAttribute("returnURL", "/notice/noticeReg.do");
            return "redirect:../member/login.do";
        }
        
        String fullPath=null;
        System.out.println("imgFile");
        String originalFilename = imgFile.getOriginalFilename();
        System.out.println(imgFile.getOriginalFilename());
        if(imgFile.getOriginalFilename()!=""){
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

        String position = area + "/" + county;

        n.setFileSrc(fullPath);
        n.setWriter(writer);
        n.setPosition(position);
        int af = myBatis.regNotice(n);
        if (af == 1) {
            System.out.println("등록완료");
            // mv.setViewName("redirect:notice.do");
            return "redirect:notice.do";
        } else {
            System.out.println("등록실패");
            // mv.setViewName("redirect:notice.do");
            return "redirect:notice.do";
        }
    }
    
    @RequestMapping(value={"noticeDel.do"}, method=RequestMethod.GET)
    public String noticeDelProc(String seq, int nL){
        System.out.println("어노테이션 notiecDelProc.do");
        
        NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
        
        TransactionDefinition td=new DefaultTransactionAttribute();
		TransactionStatus ts=ptm.getTransaction(td);
		
		try{
			myBatis.deleteNCommentRec(seq);
			myBatis.noticeCommentDel(seq);
	        myBatis.deleteNotice(seq);
			ptm.commit(ts);
			System.out.println("게시글 삭제 완료");
		} catch(Exception e) {
			ptm.rollback(ts);
			System.out.println("게시글 삭제 실패");
		}
        
		if(nL!=1){
			return "redirect:notice.do";
		} else{
			return "redirect:../mypage/noticeList.do";
		}

    }
    
    //댓글 등록
    @RequestMapping(value={"nCommentReg.do"}, method=RequestMethod.POST)
    public String nCommentReg(String seq, String comments, HttpServletRequest request, String pg, String f, String q){
    	System.out.println("어노테이션 nCommentReg.do");
    	
    	NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
    	
    	String mid = (String) request.getSession().getAttribute("mid");
    	
        NComment n = new NComment();
        System.out.println("seq========" + seq);
        
        n.setSeq(seq);
        n.setComments(comments);
        n.setMid(mid);
        
    	myBatis.nCommentReg(n);
    	
    	String _query = null;       
        _query = ChangeURL.getUrlFormat(q);
        
    	return "redirect:noticeDetail.do?seq="+seq+"&pg="+pg+"&f="+f+"&q="+_query;
    }
    
    //댓글 수정
    @RequestMapping(value={"nCommentEdit.do"}, method=RequestMethod.POST)
    public String nCommentEdit(String comments, Model model, String nseq){
    	System.out.println("어노테이션 nCommentEdit.do");
    	
    	NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
    	
    	NComment n = myBatis.getNComment(nseq);
    	
    	n.setComments(comments);
    	
    	myBatis.nCommentEdit(n);
    	
    	model.addAttribute("comments", comments);
    	
    	return "notice_nCommentEdit";
    }
    
    //댓글 삭제
    @RequestMapping(value={"nCommentDel.do"}, method=RequestMethod.GET)
    public String nCommentDel(String nseq, String seq, HttpServletRequest request, String pg, String f, String q){
    	System.out.println("어노테이션 nCommentDel.do");
    	
    	NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
    	int af = 0;
    	
    	TransactionDefinition td=new DefaultTransactionAttribute();
		TransactionStatus ts=ptm.getTransaction(td);
		
		try{
			myBatis.deleteNCommentRec(seq);
			af = myBatis.nCommentDel(nseq);
			ptm.commit(ts);
			System.out.println("댓글 삭제 완료");
		} catch(Exception e) {
			ptm.rollback(ts);
			System.out.println("댓글 삭제 실패");
		}
    	
    	String _query = null;       
        _query = ChangeURL.getUrlFormat(q);
        
    	if(af==1){
    		System.out.println("댓글 삭제 완료");
    		return "redirect:noticeDetail.do?seq="+seq+"&pg="+pg+"&f="+f+"&q="+_query;
    	} else{
    		System.out.println("댓글 삭제 실패");
    		return "redirect:noticeDetail.do?seq="+seq+"&pg="+pg+"&f="+f+"&q="+_query;
    	}
    	
    }
    
    //댓글 추천, 반대
    @RequestMapping(value={"nCommentLikeUp.do"}, method=RequestMethod.POST)
    public String nCommentLikeUp(String nseq, Model model, HttpServletRequest request, String seq){
    	System.out.println("어노테이션 nCommentLikeUp.do");
    	
    	String mid = (String) request.getSession().getAttribute("mid");
    	NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
    	
    	TransactionDefinition td=new DefaultTransactionAttribute();
		TransactionStatus ts=ptm.getTransaction(td);
		
		NCommentRec nr = myBatis.getNcommentRec(mid, nseq);
		
		int com=0;
		
		if(nr==null){
			nr = new NCommentRec();
			nr.setSeq(seq);
			nr.setNseq(nseq);
			nr.setMid(mid);
			nr.setNrecommend(1);
			
			try{
				myBatis.regNcommentRec(nr);
				myBatis.nCommentLikeUp(nseq);
				ptm.commit(ts);
				System.out.println("댓글 추천 완료");
			} catch(Exception e) {
				ptm.rollback(ts);
				System.out.println("댓글 추천 실패");
			}
			
			com=1;
		}
    	model.addAttribute("com",com);
    	
    	return "notice_nCommentUp";
    }
    
    @RequestMapping(value={"nCommentUnlikeUp.do"}, method=RequestMethod.POST)
    public String nCommentUnlikeUp(String nseq, Model model, HttpServletRequest request, String seq){
    	System.out.println("어노테이션 nCommentUnlikeUp.do");
    	
    	String mid = (String) request.getSession().getAttribute("mid");
    	NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
    	
    	TransactionDefinition td=new DefaultTransactionAttribute();
		TransactionStatus ts=ptm.getTransaction(td);
		
		NCommentRec nr = myBatis.getNcommentRec(mid, nseq);
		
		int com=0;
		
		if(nr==null){
			nr = new NCommentRec();
			nr.setSeq(seq);
			nr.setNseq(nseq);
			nr.setMid(mid);
			nr.setNrecommend(-1);
			
			try{
				myBatis.regNcommentRec(nr);
				myBatis.nCommentUnlikeUp(nseq);
				ptm.commit(ts);
				System.out.println("댓글 추천 완료");
			} catch(Exception e) {
				ptm.rollback(ts);
				System.out.println("댓글 추천 실패");
			}
			
			com=1;
		}
    	model.addAttribute("com",com);
    	
    	return "notice_nCommentUp";
    }
    
    @RequestMapping(value={"noticeLike.do"}, method=RequestMethod.GET)
    public String noticeLike(String seq, HttpServletRequest request, String pg, String f, String q, String r){
    	System.out.println("어노테이션 noticeLike.do");
    	
    	NoticeDAO myBatis = sqlsession.getMapper(NoticeDAO.class);
    	
    	String mid = (String) request.getSession().getAttribute("mid");
    	int recommend = Integer.parseInt(r);
    	System.out.println("recommend : " + recommend);
    	
    	NoticeRecommend nr = myBatis.getNoticeRec(mid, seq);
    	TransactionDefinition td=new DefaultTransactionAttribute();
    	TransactionStatus ts=ptm.getTransaction(td);
    	
    	System.out.println("nr : " + nr);
    	
    	if(nr==null){
    		NoticeRecommend nr1 = new NoticeRecommend();
	    	nr1.setMid(mid);
	    	nr1.setSeq(seq);
	    	nr1.setRecommend(recommend); 
	    	
	    	try{
		    	myBatis.noticeRec(nr1);
		    	myBatis.updateNoticeCounts(recommend, seq);
		    	ptm.commit(ts);
		    	System.out.println("게시글 추천 완료");
	    	} catch(Exception e) {
	    		ptm.rollback(ts);
	    		System.out.println("게시글 추천 실패");
	    	}
    	}else{ 	
    		try{
    			myBatis.updateNoticeCounts(recommend, seq);
	    		myBatis.updateNoticeRec(recommend, mid, seq);
	    		ptm.commit(ts);
		    	System.out.println("게시글 추천 완료");
    		} catch(Exception e) {
    			ptm.rollback(ts);
    			System.out.println("게시글 추천 실패");
    		}
    	}
    	
    	String _query = null;       
        _query = ChangeURL.getUrlFormat(q);
    	
    	return "redirect:noticeDetail.do?seq="+seq+"&pg="+pg+"&f="+f+"&q="+_query;
    }
    
}