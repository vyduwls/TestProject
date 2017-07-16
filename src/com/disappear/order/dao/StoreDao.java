package com.disappear.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.disappear.order.vo.Comment;
import com.disappear.order.vo.Store;

public interface StoreDao {

    @Select("SELECT * FROM (SELECT ROWNUM AS RN, X.* FROM  (SELECT * FROM STORES ORDER BY TO_NUMBER(SEQ)) X) WHERE RN >=10*#{iPage} AND RN <10+10*#{iPage}")
    public List<Store> getStores(@Param("iPage") int iPage);
    
    @Select("SELECT * FROM (SELECT ROWNUM AS RN, X.* FROM  (SELECT * FROM STORES WHERE STORETYPE=#{storeType} ORDER BY TO_NUMBER(SEQ)) X) WHERE RN >=10*#{iPage} AND RN <10+10*#{iPage} ")
    public List<Store> getStoresByStoreType(@Param("storeType")String storeType, @Param("iPage") int iPage);
    
    @Select("SELECT * FROM (SELECT ROWNUM AS RN, X.* FROM  (SELECT * FROM STORES WHERE STORETYPE=#{storeType} AND ADDRESS LIKE #{address} ORDER BY TO_NUMBER(SEQ)) X) WHERE RN >=10*#{iPage} AND RN <10+10*#{iPage} ")
    public List<Store> getStoresByStoreTypeAndAddress(@Param("address") String address,@Param("storeType") String storeType,@Param("iPage") int iPage);
    
    @Select("SELECT STORETYPE FROM STORES")
    public List<String> getAllStoresByStoreType();
        
    @Select("SELECT * FROM (SELECT ROWNUM AS RN, X.* FROM  (SELECT * FROM STORES WHERE ADDRESS LIKE #{address} ORDER BY TO_NUMBER(SEQ)) X) WHERE RN >=10*#{iPage} AND RN <10+10*#{iPage}")
    public List<Store> getSearches(@Param("address") String address, @Param("iPage") int iPage);
    
    @Select("SELECT C.CSEQ, C.COSEQ, C.CMID, C.CONTENT, C.LIKES, C.REGDATE,C.IMAGES FROM STORES INNER JOIN MENUS ON STORES.SEQ=MENUS.SSEQ INNER JOIN ORDERS ON ORDERS.MENUSEQ=MENUS.MSEQ INNER JOIN COMMENTS C ON C.COSEQ=ORDERS.ORDERSEQ WHERE STORENAME=#{storeName} ORDER BY TO_NUMBER(COSEQ) DESC")
    public List<Comment> getComments(@Param("storeName") String storeName);
    
    @Select("SELECT STORES.STORENAME AS STORENAME, TO_CHAR(ROUND(AVG(C.LIKES),0)) AS LIKES FROM STORES INNER JOIN MENUS ON STORES.SEQ=MENUS.SSEQ INNER JOIN ORDERS ON ORDERS.MENUSEQ=MENUS.MSEQ INNER JOIN COMMENTS C ON C.COSEQ=ORDERS.ORDERSEQ GROUP BY STORENAME")
    public List<Map<String, String>> getAvgLikes();
    
    @Select("SELECT STORENAME FROM (SELECT ROWNUM AS RN,X.* FROM(SELECT STORES.STORENAME AS STORENAME, TO_CHAR(ROUND(AVG(C.LIKES),0)) AS LIKES FROM STORES INNER JOIN MENUS ON STORES.SEQ=MENUS.SSEQ INNER JOIN ORDERS ON ORDERS.MENUSEQ=MENUS.MSEQ INNER JOIN COMMENTS C ON C.COSEQ=ORDERS.ORDERSEQ GROUP BY STORENAME ORDER BY LIKES DESC) X) WHERE RN<=3")
    public List<String> getTop3();
    
    

}
