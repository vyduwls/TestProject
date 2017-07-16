package com.disappear.order.controllers;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.disappear.order.dao.MemberDAO;
import com.disappear.order.vo.Confirm;
import com.disappear.order.vo.Member;
import com.disappear.order.vo.Store;

@Controller
@RequestMapping("/member/*")
public class joinusController {
    // private MemberDAO mdao;
    // @Autowired
    // public void setMdao(MemberDAO mdao) {
    // this.mdao = mdao;
    // }

    @Autowired
    private SqlSession sqlsession;

    // 사업자등록번호 등록
    @RequestMapping(value = { "confirm.do" }, method = RequestMethod.GET)
    public String confirm() {
        System.out.println("team 어노테이션 confirm");

        return "member_confirm";
    }

    @RequestMapping(value = { "confirm.do" }, method = RequestMethod.POST)
    public String confirmProc(Confirm c, Model model) {
        System.out.println("team 어노테이션 join Proc");
        MemberDAO mybatis = sqlsession.getMapper(MemberDAO.class);
        int af = mybatis.addConfirm(c);
        System.out.println("Confirm    : " + c.getConfirmNum());
        if (af == 1) {
            System.out.println("사업자번호등록성공");
            model.addAttribute("cnum", c.getConfirmNum());
            return "redirect:join2.do";
        } else {
            System.out.println("사업자번호등록실패");
            return "redirect:agree.do";
        }
    }
    // 회원가입

    // @RequestMapping("join.do")
    @RequestMapping(value = { "join.do" }, method = RequestMethod.GET)
    public String join() {
        System.out.println("team 어노테이션 join");

        return "member_join";
    }

    // 회원가입
    // @RequestMapping("joinProc.do")
    @RequestMapping(value = { "join.do" }, method = RequestMethod.POST)
    public String joinProc(Member m) {
        System.out.println("team 어노테이션 join Proc");
        MemberDAO mybatis = sqlsession.getMapper(MemberDAO.class);
        int af = mybatis.addMember(m);

        if (af == 1) {
            System.out.println("가입성공");
            return "member_login";
        } else {
            System.out.println("가입실패");
            return "redirect:join.do";
        }
    }

    @RequestMapping(value = { "join2.do" }, method = RequestMethod.GET)
    public String join2(Confirm c, String cnum, Model model) {
        System.out.println("team 어노테이션 join22");
        System.out.println("join2222 Confirm   :" + cnum);

        model.addAttribute("cnum", cnum);
        return "member_join2";
    }

    @RequestMapping(value = { "join2.do" }, method = RequestMethod.POST)
    public String joinProc2(String cnum, Confirm c, Member m, Model model, HttpServletRequest request) {
        System.out.println("team 어노테이션 join22 Proc");
        MemberDAO mybatis = sqlsession.getMapper(MemberDAO.class);
        int af = mybatis.addMember(m);
        System.out.println(" m get id " + m.getMid());
        System.out.println("BBBBBBBB" + m.getEmail());
        System.out.println("cccccccccccc" + cnum);
        if (af == 1) {
            System.out.println("가입성공");
            model.addAttribute("mid", m.getMid());
            model.addAttribute("m", m);
            model.addAttribute("cnum", cnum);
            model.addAttribute("c", c);
            return "redirect:storejoin.do";
        } else {
            System.out.println("가입실패");
            return "redirect:join2.do";
        }
    }

    @RequestMapping(value = { "storejoin.do" }, method = RequestMethod.GET)
    public String storejoin(String cnum, Member m, Model model, String mid, Confirm c) {
        System.out.println("team 어노테이션 storejoin");
        System.out.println("mmmmgetid" + mid);
        System.out.println("ccccccccc   : " + c.getConfirmNum());
        System.out.println("멤버getid" + m.getMid());
        System.out.println("cnum 12345444" + cnum);
        model.addAttribute("m", m);
        model.addAttribute("cnum", cnum);

        return "member_storejoin";
    }

    @RequestMapping(value = { "storejoin.do" }, method = RequestMethod.POST)
    public String storejoinProc(Store s, HttpServletRequest request, @RequestParam("imgFile") MultipartFile imgFile) {
        System.out.println("team 어노테이션 storejoin Proc");
        MemberDAO mybatis = sqlsession.getMapper(MemberDAO.class);
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
                    System.out.println("upload fail");
                    e.printStackTrace();
                }
            } else {
                System.out.println("image not found");
            }

        }
        s.setImages(fullPath);

        int af = mybatis.storeJoin(s);
        if (af == 1) {
            System.out.println("스토어가입성공");
            return "member_login";
        } else {
            System.out.println("스토어가입실패");
            return "redirect:join2.do";
        }
    }
    // 회원가입 id 중복체크

    // @RequestMapping("idcheck.do")
    @RequestMapping(value = { "idcheck.do" }, method = RequestMethod.POST)
    public String idcheck(Model model, String mid) {
        System.out.println("team 어노테이션  아이디체크 : " + mid);
        MemberDAO myBatis = sqlsession.getMapper(MemberDAO.class);
        Member m = myBatis.getMember(mid);

        if (m == null) {
            model.addAttribute("check", "1");
            System.out.println("teamP어노테이션 아이디체크 if : " + m);
        } else if (m != null) {
            model.addAttribute("check", "0");
            System.out.println("teamP 어노테이션 아이디체크 else : " + m);
        }

        return "member_idcheck";

    }

    // 사업자번호 중복체크
    // @RequestMapping("confirmcheck.do")
    @RequestMapping(value = { "confirmcheck.do" }, method = RequestMethod.POST)
    public String confirm(Model model, String confirmNum) {

        System.out.println("c_num = " + confirmNum);
        MemberDAO myBatis = sqlsession.getMapper(MemberDAO.class);
        Confirm c = myBatis.getConfirm(confirmNum);
        if (c == null) {
            model.addAttribute("confirm", "1");
            System.out.println("confirm11 c= " + c);
        } else {
            model.addAttribute("confirm", "0");
            System.out.println("confirm22 c= " + c);
        }

        return "member_confirmcheck";

    }

    // 로그인
    // @RequestMapping("login.do")
    @RequestMapping(value = { "login.do" }, method = RequestMethod.GET)
    public String login(HttpServletRequest request, String check, Model model, String code) {
        Cookie[] cks = request.getCookies();
        System.out.println("check  =  " + check);
        String cookieMid = null;

        // CookieMGR.getCookie(cks, "mid");
        if (cks != null) {
            for (Cookie ck : cks) {
                if (ck.getName().equals("mid")) {
                    cookieMid = ck.getValue();
                }
            }
        }
        model.addAttribute("check", check);
        System.out.println("cookieMid : " + cookieMid);
        System.out.println("cookie111 = " + cks);
        if (cks != null && !cks.equals("")) {
            request.setAttribute("cookieMid", cookieMid);
        }

        model.addAttribute("code", code);

        return "member_login";
    }

    // 로그인Proc

    // @RequestMapping("loginProc.do")
    @RequestMapping(value = { "login.do" }, method = RequestMethod.POST)
    public String loginProc(String owners, String mid, String pwd, HttpServletRequest request,
            HttpServletResponse response, Model model, String code) {
        String checkBoxMid = request.getParameter("checkBoxMid");
        System.out.println("로그인.ㅇdo~~12121212");
        MemberDAO myBatis = sqlsession.getMapper(MemberDAO.class);
        Member m = myBatis.getMember(mid);
        int check = 0;
        System.out.println();
        if (m == null){
            System.out.println("아이디가 없습니다");
            model.addAttribute("check", "1");
            return "redirect:login.do";

        } else if (!m.getPwd().equals(pwd)) {
            model.addAttribute("check", "0");
            System.out.println("비빌번호가 일치하지 않습니다.");
            return "redirect:login.do";

        } else {
            HttpSession session = request.getSession();
            if (m.getOwners().equals("사업자")) {
                session.setAttribute("aa", "1");
                System.out.println("session 사업자="+request.getSession().getAttribute("aa"));
                session.setAttribute("mid", mid);
            } else if (m.getOwners().equals("일반회원")) {
                session.setAttribute("aa", "0");
                System.out.println("session 사업자="+request.getSession().getAttribute("aa"));
                session.setAttribute("mid", mid);
            }
            if (checkBoxMid != null && !checkBoxMid.equals("")) {
                Cookie ck = new Cookie("mid", mid);
                ck.setMaxAge(60 * 60 * 24 * 30);
                response.addCookie(ck);
                Cookie ck2 = new Cookie("pwd", m.getPwd());
                ck.setMaxAge(60 * 60 * 24 * 30);
                response.addCookie(ck2);
                System.out.println("쿠키생성");
            } else {
                Cookie ck = new Cookie("mid", null);
                ck.setMaxAge(0);
                response.addCookie(ck);
                Cookie ck2 = new Cookie("pwd", null);
                ck.setMaxAge(0);
                response.addCookie(ck2);
                System.out.println("쿠키삭제");
            }

            String returnURL = (String) request.getSession().getAttribute("returnURL");
            if (returnURL != null && !returnURL.equals("")) {
                String ctName = request.getContextPath();
                System.out.println("ctName=" + ctName);
                return "redirect:" + returnURL;
            }
            if (code != null) {
                return "redirect:../shoppingbasket.do";
            }
            return "redirect:../index.do";
        }
    }

    // @RequestMapping("infoEdit.do")
    @RequestMapping(value = { "infoEdit.do" }, method = RequestMethod.GET)
    public String infoEdit(HttpServletRequest request, Model model) {
        System.out.println("team 어노테이션 infoEdit");
        String mid = (String) request.getSession().getAttribute("mid");
        MemberDAO myBatis = sqlsession.getMapper(MemberDAO.class);

        Member m = myBatis.getMember(mid);
        model.addAttribute("m", m);
        System.out.println("m.getMid  :" + m.getMid());
        System.out.println("m.getName : " + m.getName());
        System.out.println("m.pwd : " + m.getPwd());
        System.out.println("m.birth : " + m.getBirth());

        return "member_infoEdit";
    }

    // @RequestMapping("infoEditProc.do")
    @RequestMapping(value = { "infoEdit.do" }, method = RequestMethod.POST)
    public String infoEditProc(Member m, String mid, Model model) {
        System.out.println("team 어노테이션 infoEditProc");
        System.out.println("infoEditProc m.getmid : " + m.getMid());
        System.out.println("editproc=======" + m.getBirth());
        MemberDAO myBatis = sqlsession.getMapper(MemberDAO.class);
        int af = myBatis.modify(m);

        if (af == 1) {
            System.out.println("정보변경됬음");
            model.addAttribute("Edit", "1");
            System.out.println("af =  " + af);
            return "index";
        } else {
            System.out.println("정보변경 안됨");
            model.addAttribute("Edit", "0");
            System.out.println("af =  " + af);
            return "member_infoEdit";
        }
    }

    @RequestMapping(value = { "findUserid.do" }, method = RequestMethod.GET)
    public String findUseridget(HttpServletRequest request, Model model, String mid, String find) {

        if (mid != null) {

            System.out.println("findUserid GET방식 실행");
            System.out.println("GET name" + find);
            MemberDAO myBatis = sqlsession.getMapper(MemberDAO.class);
            Member m = myBatis.getMember(mid);
            model.addAttribute("m", m);
            model.addAttribute("error", find);
        } else {
            model.addAttribute("error", find);
        }

        return "member_findUserid";

    }

    @RequestMapping(value = { "findUserid.do" }, method = RequestMethod.POST)
    public String findUserid(HttpServletRequest request, Model model) {
        System.out.println("findUserid 실행");

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String aa = request.getParameter("aa");
        System.out.println("aaa = " + aa);
        System.out.println("name  =  " + name);
        System.out.println("phone  =  " + phone);
        MemberDAO myBatis = sqlsession.getMapper(MemberDAO.class);

        String mid = myBatis.findUserid(name, phone);

        if (mid != null) {
            System.out.println("이름과 전화번호 일치");
            model.addAttribute("mid", mid);
            model.addAttribute("find", "1");
            return "redirect:findUserid.do";
        } else {
            System.out.println("이름과 전화번호 일치하지않음");
            model.addAttribute("find", "0");
            return "redirect:findUserid.do";
        }
    }

    @RequestMapping(value = { "findEmail.do" }, method = RequestMethod.GET)
    public String findEmail(String mid, HttpServletRequest request, Model model, String find) {
        if (mid != null) {
            MemberDAO myBatis = sqlsession.getMapper(MemberDAO.class);
            Member m = myBatis.getMember(mid);
            System.out.println("findEmail GET");
            System.out.println("findEmail = " + find);
            System.out.println("find ====" + find);
            model.addAttribute("error", find);
            model.addAttribute("m", m);
        } else {
            model.addAttribute("error", find);
        }

        return "member_findUserid";
    }

    @RequestMapping(value = { "findEmail.do" }, method = RequestMethod.POST)
    public String findEmailProc(HttpServletRequest request, Model model) {
        System.out.println("findEmail POST");
        String email = request.getParameter("email");
        MemberDAO myBatis = sqlsession.getMapper(MemberDAO.class);

        System.out.println("adasda" + email);
        String mid = myBatis.findEmail(email);
        System.out.println("post 에서 mid : " + mid);
        if (mid != null) {
            System.out.println("이메일  일치");
            model.addAttribute("mid", mid);
            model.addAttribute("find", "1");
            return "redirect:findEmail.do";
        } else {
            System.out.println("이메일 일치하지않음");
            model.addAttribute("find", "0");
            return "redirect:findEmail.do";
        }

    }

    @RequestMapping(value = { "logout.do" }, method = RequestMethod.GET)
    public String logout(HttpServletRequest request) {
        // invalidate() 는 세션을 초기화 시키는 함수다.
        request.getSession().invalidate();

        return "redirect:../index.do";
    }

    @RequestMapping("agree.do")
    public String agree(HttpServletRequest request, Model model) {

        return "member_agree";
    }

    @RequestMapping("agree2.do")
    public String agree2(HttpServletRequest request, Model model) {

        return "member_agree2";
    }

    @RequestMapping("confirm.do")
    public String confirm(HttpServletRequest request, Model model) {

        return "member_confirm";
    }
}
