package com.disappear.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.disappear.order.vo.NComment;
import com.disappear.order.vo.NCommentRec;
import com.disappear.order.vo.Notice;
import com.disappear.order.vo.NoticeRecommend;


public interface NoticeDAO {

    //게시글 목록
    @Select("SELECT * FROM NOTICES WHERE SEQ=#{seq}")
    public Notice getNotice(String seq);
    
    @SelectKey(before=true, keyProperty="seq", resultType=String.class, statement="SELECT NVL(MAX(TO_NUMBER(SEQ)),0)+1 FROM NOTICES")
    @Insert("INSERT INTO NOTICES (SEQ,TITLE,WRITER,CONTENT,FILESRC,POSITION,STORE,STARS) VALUES(#{seq},#{title},#{writer},#{content},#{fileSrc, jdbcType=VARCHAR},#{position, jdbcType=VARCHAR},#{store, jdbcType=VARCHAR},${stars})")
    public int regNotice(Notice n);
    
    //게시글 목록 - ArrayList<Notice>
    @Select("SELECT * FROM (SELECT ROWNUM NUM, N.* FROM (SELECT * FROM NOTICES WHERE ${field} LIKE '%${query}%' ORDER BY TO_NUMBER(SEQ) DESC) N) WHERE NUM BETWEEN 1+(#{pg}-1)*15 AND 15+(#{pg}-1)*15")
//      public List<Notice> getNotices(int pg,String field, String query);
    public List<Notice> getNotices(@Param("pg")int pg, @Param("field")String field, @Param("query")String query);
    
    //게시글 갯수 얻기
    @Select("SELECT COUNT(SEQ) CNT FROM NOTICES WHERE ${param1} LIKE '%${param2}%'")
    public int getSeqCount(String field, String query);
    
    @Select("SELECT COUNT(SEQ) CNT FROM NOTICES WHERE TITLE LIKE '%${query}%' OR CONTENT LIKE '%${query}%'")
    public int getSeqCount1(@Param("query")String query);
    
    @Update("UPDATE NOTICES SET HIT=HIT+1 WHERE SEQ=#{seq}")
    public int hitCount(String seq);

    //게시글 수정
    @Update("UPDATE NOTICES SET TITLE=#{title}, CONTENT=#{content}, POSITION=#{position}, STARS=${stars} WHERE SEQ=#{seq}")
    public int modifyContent(Notice n);

    //게시글 삭제
    @Delete("DELETE NOTICES WHERE SEQ=#{seq}")
    public int deleteNotice(String seq);
    
    //게시글에 달린 댓글 수 받아오기
    @Select("SELECT SEQ, COUNT(SEQ) AS COUNTS FROM NCOMMENTS GROUP BY SEQ")
    public List<NComment> getNCommentCount();
    
    
    //게시글 추천 관련-------------------------------------------------
    
    //게시글 추천테이블에 생성
    @SelectKey(before=true, keyProperty="rseq", resultType=String.class, statement="SELECT NVL(MAX(TO_NUMBER(RSEQ)),0)+1 FROM NOTICESREC")
    @Insert("INSERT INTO NOTICESREC VALUES(#{seq},#{rseq},#{mid},#{recommend})")
    public int noticeRec(NoticeRecommend nr);
    
    //게시글 추천테이블에 업데이트
    @Update("UPDATE NOTICESREC SET RECOMMEND=RECOMMEND+${recommend} WHERE MID=#{mid} AND SEQ=#{seq}")
    public int updateNoticeRec(@Param("recommend")int recommend,@Param("mid")String mid,@Param("seq")String seq);
    
    //게시글 추천수 UP & DOWN
    @Update("UPDATE NOTICES SET COUNTS=COUNTS+${counts} WHERE SEQ=#{seq}")
    public int updateNoticeCounts(@Param("counts")int counts, @Param("seq")String seq);
   
    //게시글 추천 아이디 조회
    @Select("SELECT * FROM NOTICESREC WHERE MID=#{param1} AND SEQ=#{param2}")
    public NoticeRecommend getNoticeRec(String mid, String seq);
    
    
    
    //댓글 추천 관련------------------------------------------------------
    
    //댓글 추천테이블에 생성
    @SelectKey(before=true, keyProperty="nrseq", resultType=String.class, statement="SELECT NVL(MAX(TO_NUMBER(NRSEQ)),0)+1 FROM NCOMMENTSREC")
    @Insert("INSERT INTO NCOMMENTSREC VALUES(#{seq},#{nseq},#{nrseq},#{mid},${nrecommend})")
    public int regNcommentRec(NCommentRec nr);
    
    //댓글 추천 아이디 조회
    @Select("SELECT * FROM NCOMMENTSREC WHERE MID=#{param1} AND NSEQ=#{param2}")
    public NCommentRec getNcommentRec(String mid, String nseq);
    
    //댓글 추천 데이터 삭제
    @Delete("DELETE NCOMMENTSREC WHERE SEQ=#{seq}")
    public int deleteNCommentRec(String seq);
    
    
    //댓글 관련-----------------------------------------------------------
    
    //댓글 받아오기
    @Select("SELECT * FROM NCOMMENTS WHERE NSEQ=#{nseq}")
    public NComment getNComment(String nseq);
    
    @Select("SELECT * FROM NCOMMENTS WHERE SEQ=#{seq} ORDER BY TO_NUMBER(NSEQ) DESC")
    public List<NComment> getNComments(String seq);
    
    //댓글 등록
    @SelectKey(before=true, keyProperty="nseq", resultType=String.class, statement="SELECT NVL(MAX(TO_NUMBER(NSEQ)),0)+1 FROM NCOMMENTS")
    @Insert("INSERT INTO NCOMMENTS VALUES(#{nseq},#{seq},#{mid},#{comments},DEFAULT,DEFAULT,DEFAULT)")
    public int nCommentReg(NComment n);
    
    //댓글 삭제
    @Delete("DELETE NCOMMENTS WHERE NSEQ=#{nseq}")
    public int nCommentDel(String nseq);
    
    //댓글 수정
    @Update("UPDATE NCOMMENTS SET COMMENTS=#{comments} WHERE NSEQ=#{nseq}")
    public int nCommentEdit(NComment n);
    
    //댓글 추천
    @Update("UPDATE NCOMMENTS SET LIKEUP=LIKEUP+1 WHERE NSEQ=#{nseq}")
    public int nCommentLikeUp(String nseq);
    
    //댓글 반대
    @Update("UPDATE NCOMMENTS SET UNLIKEUP=UNLIKEUP+1 WHERE NSEQ=#{nseq}")
    public int nCommentUnlikeUp(String nseq);
    
    //seq 댓글 전체 삭제
    @Delete("DELETE NCOMMENTS WHERE SEQ=#{seq}")
    public int noticeCommentDel(String seq);
    
    
    //검색 관련--------------------------------------------------------------
    
    @Select("SELECT * FROM (SELECT ROWNUM NUM, N.* FROM (SELECT * FROM NOTICES WHERE CONTENT LIKE '%${search}%' OR TITLE LIKE '%${search}%' ORDER BY TO_NUMBER(SEQ) DESC) N) WHERE NUM BETWEEN 1+(#{pg}-1)*15 AND 15+(#{pg}-1)*15")
    public List<Notice> getSearchTitleContent(@Param("pg")int pg, @Param("search")String search);
    
    @Select("SELECT * FROM (SELECT ROWNUM NUM, N.* FROM (SELECT * FROM NOTICES WHERE WRITER LIKE '%${search}%' ORDER BY TO_NUMBER(SEQ) DESC) N) WHERE NUM BETWEEN 1+(#{pg}-1)*15 AND 15+(#{pg}-1)*15")
    public List<Notice> getSearchWriter(@Param("pg")int pg, @Param("search")String search);
    
    @Select("SELECT * FROM (SELECT ROWNUM NUM, N.* FROM (SELECT * FROM NOTICES WHERE POSITION LIKE '%${search}%' ORDER BY TO_NUMBER(SEQ) DESC) N) WHERE NUM BETWEEN 1+(#{pg}-1)*15 AND 15+(#{pg}-1)*15")
    public List<Notice> getSearchPosition(@Param("pg")int pg, @Param("search")String search);
    
    @Select("SELECT * FROM (SELECT ROWNUM NUM, N.* FROM (SELECT * FROM NOTICES WHERE STORE LIKE '%${search}%' ORDER BY TO_NUMBER(SEQ) DESC) N) WHERE NUM BETWEEN 1+(#{pg}-1)*15 AND 15+(#{pg}-1)*15")
    public List<Notice> getSearchStore(@Param("pg")int pg, @Param("search")String search);
    

}