package com.disappear.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Component;

import com.disappear.order.vo.BasketList;
import com.disappear.order.vo.Menus;
import com.disappear.order.vo.ShoppingBasket;
import com.disappear.order.vo.Store;

@Component
public interface MenusDAO {

	 //메뉴 가져오기
    @Select("SELECT * FROM MENUS WHERE SSEQ=#{sseq} ORDER BY TO_NUMBER(MSEQ)")
    public List<Menus> getMenus(String sseq);

 // 메뉴 상세정보 가져오기
    @Select("SELECT * FROM MENUS WHERE MSEQ=#{mseq}")
    public Menus checkMenus(String mseq);

    //장바구니 넣기
    @Insert("INSERT INTO BASKETS (BASKETSEQ,MID,MSEQ,AMOUNT,TIME,PHONENUMBER,REQUIREMENTS,PRICE) VALUES((SELECT NVL(MAX(TO_NUMBER(BASKETSEQ)),0)+1 FROM BASKETS),#{mid},#{mseq},${amount},#{time},#{phoneNumber},#{requirements},${price})")
    public int inputbasket(ShoppingBasket basket);

    // 모든 장바구니 가져오기
    @Select("SELECT * FROM (SELECT ROWNUM RN, N.* FROM (SELECT * FROM BASKETS  WHERE MID=#{mid} ORDER BY TO_NUMBER(BASKETSEQ) DESC) N)")
    public List<ShoppingBasket> getbaskets(String mid);

    //장바구니 리스트 가져오기
//    @Select("SELECT * FROM MENUS WHERE MSEQ=#{seq}")
//    public Menus getStoreName(String seq);
    //선택된 장바구니 리스트만 가져오기
    @Select(" SELECT BASKETSEQ, M.SSEQ AS SSEQ,B.MID AS MID,M.MSEQ AS MSEQ,AMOUNT,TIME,B.PHONENUMBER AS PHONENUMBER,REQUIREMENTS,M.PRICE AS MENUPRICE,CATEGORY,MENUNAME,B.PRICE AS TOTALPRICE,IMG,STORENAME FROM BASKETS B JOIN MENUS M ON B.MSEQ=M.MSEQ JOIN STORES S ON M.SSEQ=S.SEQ WHERE MID=#{mid} ORDER BY TO_NUMBER(BASKETSEQ) DESC")
    public List<BasketList> getBaskets(@Param("mid") String mid);
    
    @Select(" SELECT BASKETSEQ, M.SSEQ AS SSEQ,B.MID AS MID,M.MSEQ AS MSEQ,AMOUNT,TIME,B.PHONENUMBER AS PHONENUMBER,REQUIREMENTS,M.PRICE AS MENUPRICE,CATEGORY,MENUNAME,B.PRICE AS TOTALPRICE,IMG,STORENAME FROM BASKETS B JOIN MENUS M ON B.MSEQ=M.MSEQ JOIN STORES S ON M.SSEQ=S.SEQ WHERE B.BASKETSEQ IN (${basketseqs}) ORDER BY TO_NUMBER(BASKETSEQ) DESC")
    public List<BasketList> getselectBaskets(@Param("basketseqs") String basketseqs);
 
  //장바구니 지우기
    @Delete("DELETE FROM BASKETS WHERE BASKETSEQ IN (${basketseqs})")
    public int delbasket(@Param("basketseqs") String basketseqs);

    // 장바구니 전체 지우기
    @Delete("DELETE FROM BASKETS WHERE MID=#{mid}")
    public int allDelBasket(String mid);

    // 장바구니 수량변경
    @Update("UPDATE BASKETS SET AMOUNT=${amount},PRICE=${price} WHERE BASKETSEQ=#{basketseq}")
    public int updatebasket(@Param("amount") int amount, @Param("price") int price, @Param("basketseq") String basketseq);

    // 선택된 장바구니 뽑기
    @Select("SELECT * FROM BASKETS WHERE BASKETSEQ IN (${basketseqs})")
    public List<ShoppingBasket> selectbaskets(@Param("basketseqs") String basketseqs);

    // ���� ���̺� �Է�
    @Insert("INSERT INTO ORDERS (ORDERSEQ, ORDERMID,MENUSEQ,AMOUNT,TIME,PHONENUMBER,REQUIREMENTS,PRICE) VALUES((SELECT NVL(MAX(TO_NUMBER(ORDERSEQ)),0)+1 FROM ORDERS),#{mid},#{mseq},${amount},#{time},#{phoneNumber},#{requirements},${price})")
    public int menuorder(ShoppingBasket shoppingBasket);

    @Select("SELECT ORDERSEQ FROM ORDERS WHERE MENUSEQ=#{menuseq}")
    public List<String> getOrderseq(String menuseq);
    
    @Select("SELECT BASKETSEQ FROM BASKETS WHERE MID=#{mid} AND MSEQ=#{mseq} AND TIME=#{arriveTime}")
	public String checkshoppingbasket(@Param("mid") String mid, @Param("mseq") String mseq, @Param("arriveTime") String arriveTime);
    
    @Update("UPDATE BASKETS SET AMOUNT=AMOUNT+${amount},PRICE=PRICE+${price},REQUIREMENTS=#{requirements} WHERE BASKETSEQ=#{num}")
	public int updateBasketdetail(@Param("amount")int amount, @Param("price")int price,@Param("requirements") String requirements, @Param("num") String num);

    //매장 정보 출력
    @Select("SELECT S.SEQ AS SEQ, S.STORENAME AS STORENAME, S.ADDRESS AS ADDRESS,S.PHONENUMBER AS PHONENUMBER FROM BASKETS B JOIN MENUS M ON B.MSEQ=M.MSEQ JOIN STORES S ON M.SSEQ=S.SEQ WHERE B.MID=#{mid}  GROUP BY S.SEQ, S.STORENAME, S.ADDRESS,S.PHONENUMBER")
	public List<Store> getStoreToBasketMid(@Param("mid")String mid);
 
    
    //매장 정보리스트 출력
    @Select("SELECT S.SEQ AS SEQ, S.STORENAME AS STORENAME, S.ADDRESS AS ADDRESS,S.PHONENUMBER AS PHONENUMBER FROM BASKETS B JOIN MENUS M ON B.MSEQ=M.MSEQ JOIN STORES S ON M.SSEQ=S.SEQ WHERE B.BASKETSEQ IN (${basketseqs})  GROUP BY S.SEQ, S.STORENAME, S.ADDRESS,S.PHONENUMBER ORDER BY S.SEQ")
	public List<Store> getStoreToBasketSeq(@Param("basketseqs")String basketseqs);
  
    
    @Select("SELECT MAX(TO_NUMBER(BASKETSEQ)) FROM BASKETS WHERE MID=#{mid}")
	public String outputLastSeq(String mid);
}
    