package com.disappear.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.disappear.order.vo.Comment;
import com.disappear.order.vo.Menus;
import com.disappear.order.vo.Notice;
import com.disappear.order.vo.OrderList;
import com.disappear.order.vo.SalesList;
import com.disappear.order.vo.Store;

public interface MyPageDao {

    @SelectKey(before=true,keyProperty="seq",resultType=String.class,statement="SELECT MAX(TO_NUMBER(SEQ))+1 FROM STORES")
    @Insert("INSERT INTO STORES (SEQ,WRITER,STORENUMBER,STORENAME,ADDRESS,PHONENUMBER,IMAGES,REGDATE,STORETYPE) VALUES(#{seq},#{writer,jdbcType=VARCHAR},#{storeNumber},#{storeName},#{address},#{phoneNumber},#{images},SYSDATE,#{storeType})")
    public int regStore(Store store);

    @Update("UPDATE STORES SET STORENUMBER=#{storeNumber}, STORENAME=#{storeName}, ADDRESS=#{address}, PHONENUMBER=#{phoneNumber},STORETYPE=#{storeType}, IMAGES=#{images} WHERE SEQ=#{seq}")
    public int updateStore(Store store);
    
    @Update("UPDATE STORES SET STORENUMBER=#{storeNumber}, STORENAME=#{storeName}, ADDRESS=#{address}, PHONENUMBER=#{phoneNumber},STORETYPE=#{storeType} WHERE SEQ=#{seq}")
    public int updateStoreNotChangeImg(Store store);
    
    @Select("SELECT * FROM STORES WHERE WRITER=#{mid}")
    public List<Store> getStoreList(String mid);
    
    @Select("SELECT * FROM STORES")
    public List<Store> getStores();
    
    @Select("SELECT * FROM COMMENTS WHERE CMID=#{mid} ORDER BY TO_NUMBER(COSEQ) DESC")
    public List<Comment> selectComments(String mid);
    
    @Insert("INSERT INTO COMMENTS (CSEQ,COSEQ,CMID,CONTENT,LIKES,IMAGES) VALUES((SELECT NVL(MAX(TO_NUMBER(CSEQ)),0)+1 FROM COMMENTS),#{coseq},#{cmid},#{content},#{likes},#{images, jdbcType=VARCHAR})")
	public int insertComment(Comment commnent);

    @Select("SELECT * FROM COMMENTS WHERE CSEQ=#{cseq}")
	public Comment getComment(String cseq);
    
    @Delete("DELETE FROM COMMENTS WHERE CSEQ=#{cseq}")
	public int delComment(String cseq);
       
    @Select(" SELECT ORDERDATE,STORENAME,MENUNAME,AMOUNT,O.PRICE AS PRICE,O.TIME AS PICKUPTIME,ORDERSEQ,STATEMENT FROM ORDERS O JOIN MENUS M ON O.MENUSEQ=M.MSEQ JOIN STORES S ON S.SEQ=M.SSEQ WHERE ORDERMID=#{mid} ORDER BY ORDERDATE DESC")
    public List<OrderList> getOrderList(@Param("mid") String mid);

    @Select("SELECT S.STORENAME AS STORENAME,TO_CHAR(O.ORDERDATE,'MM/DD') AS SALESDATE,SUM(O.PRICE) AS SALES FROM MEMBERS M JOIN STORES S ON M.MID=S.WRITER JOIN MENUS ME ON ME.SSEQ=S.SEQ JOIN ORDERS O ON O.MENUSEQ=ME.MSEQ WHERE S.WRITER=#{mid} AND S.SEQ=#{seq} AND TO_CHAR(O.ORDERDATE,'MM') = #{month} GROUP BY S.STORENAME,TO_CHAR(O.ORDERDATE,'MM/DD') ORDER BY TO_CHAR(O.ORDERDATE,'MM/DD'),S.STORENAME")
	public List<SalesList> getSales(@Param("mid") String mid,@Param("seq")String seq,@Param("month")String month);
    
    @Select("SELECT * FROM STORES WHERE WRITER=#{mid}")
	public List<Store> getstoreseq(@Param("mid") String mid);
    
    @Insert("INSERT INTO MENUS (MSEQ,SSEQ,CATEGORY,MENUNAME,ENGMENUNAME,MENUINFO,PRICE,IMG) VALUES((SELECT NVL(MAX(TO_NUMBER(MSEQ)),0)+1 FROM MENUS),#{sseq},#{category},#{menuname},#{engmenuname},#{menuinfo},#{price},#{img,})")
    public int insertMenus(Menus menu);
    
    @Select("SELECT SEQ FROM STORES WHERE STORENAME=#{storename}")
    public String getSseq(String storename);
    
    @Select("SELECT STORENAME FROM STORES WHERE SEQ=#{seq}")
	public String getStoreName(@Param("seq")String seq);
    
    @Select("SELECT ORDERDATE,STORENAME,MENUNAME,AMOUNT,O.PRICE AS PRICE,ORDERSEQ,STATEMENT FROM ORDERS O JOIN MENUS M ON O.MENUSEQ=M.MSEQ JOIN STORES S ON S.SEQ=M.SSEQ WHERE SSEQ=#{storeSeq} AND TO_CHAR(O.ORDERDATE,'MM/DD')=#{date} ORDER BY O.ORDERDATE")
	public List<OrderList> getdayOrderList(@Param("storeSeq")String storeSeq, @Param("date")String date);

    @Update("UPDATE MENUS SET CATEGORY=#{category}, MENUNAME=#{menuname}, ENGMENUNAME=#{engmenuname}, MENUINFO=#{menuinfo},PRICE=#{price}, IMG=#{img} WHERE MSEQ=#{mseq}")
    public int updateMenu(Menus menus);
    
    @Update("UPDATE MENUS SET CATEGORY=#{category}, MENUNAME=#{menuname}, ENGMENUNAME=#{engmenuname}, MENUINFO=#{menuinfo},PRICE=#{price} WHERE MSEQ=#{mseq}")
    public int updateMenuNotChangeImg(Menus menus);
    
    //내가쓴글 받아오기---------------------------------------------------------------
    @Select("SELECT * FROM (SELECT ROWNUM NUM, N.* FROM (SELECT * FROM NOTICES WHERE WRITER=#{mid} ORDER BY TO_NUMBER(SEQ) DESC) N) WHERE NUM BETWEEN 1+(#{pg}-1)*15 AND 15+(#{pg}-1)*15")
    public List<Notice> getMyNoticeNone(@Param("pg")int pg,@Param("search")String search, @Param("mid")String mid);
    
    @Select("SELECT * FROM (SELECT ROWNUM NUM, N.* FROM (SELECT * FROM NOTICES WHERE WRITER=#{mid} AND (TITLE LIKE '%${search}%' OR CONTENT LIKE '%${search}%') ORDER BY TO_NUMBER(SEQ) DESC) N) WHERE NUM BETWEEN 1+(#{pg}-1)*15 AND 15+(#{pg}-1)*15")
    public List<Notice> getMyNoticeTitleContent(@Param("pg")int pg,@Param("search")String search, @Param("mid")String mid);
    
    @Select("SELECT * FROM (SELECT ROWNUM NUM, N.* FROM (SELECT * FROM NOTICES WHERE WRITER=#{mid} AND (POSITION LIKE '%${search}%') ORDER BY TO_NUMBER(SEQ) DESC) N) WHERE NUM BETWEEN 1+(#{pg}-1)*15 AND 15+(#{pg}-1)*15")
    public List<Notice> getMyNoticePosition(@Param("pg")int pg, @Param("search")String search, @Param("mid")String mid);
    
    @Select("SELECT * FROM (SELECT ROWNUM NUM, N.* FROM (SELECT * FROM NOTICES WHERE WRITER=#{mid} AND (STORE LIKE '%${search}%') ORDER BY TO_NUMBER(SEQ) DESC) N) WHERE NUM BETWEEN 1+(#{pg}-1)*15 AND 15+(#{pg}-1)*15")
    public List<Notice> getMyNoticeStore(@Param("pg")int pg, @Param("search")String search, @Param("mid")String mid);
    
    //게시글 갯수 얻기
    @Select("SELECT COUNT(SEQ) CNT FROM NOTICES WHERE (${param1} LIKE '%${param2}%') AND WRITER=#{param3}")
    public int getSeqCount(String field, String query, String mid);
    
    @Select("SELECT COUNT(SEQ) CNT FROM NOTICES WHERE (TITLE LIKE '%${query}%' OR CONTENT LIKE '%${query}%') AND WRITER=#{param2}")
    public int getSeqCount1(@Param("query")String query, String mid);

    //가게 주문 내역 뽑기
    @Select(" SELECT ORDERDATE,STORENAME,MENUNAME,AMOUNT,O.PRICE AS PRICE,O.ORDERMID AS ORDERER,O.TIME AS PICKUPTIME,ORDERSEQ,STATEMENT,O.REQUIREMENTS AS REQUIREMENTS FROM ORDERS O JOIN MENUS M ON O.MENUSEQ=M.MSEQ JOIN STORES S ON S.SEQ=M.SSEQ WHERE S.SEQ=#{seq} ORDER BY ORDERDATE DESC")
	public List<OrderList> getOrderListToSeq(String seq);
    @Update("UPDATE ORDERS SET STATEMENT='확인완료' WHERE ORDERSEQ=#{seq}")
	public int updateOrderstatement(@Param("seq")String seq);
}

