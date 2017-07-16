package com.disappear.order.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Component;

import com.disappear.order.vo.Confirm;
import com.disappear.order.vo.Member;
import com.disappear.order.vo.Store;


@Component
public interface MemberDAO {

    @Select( "SELECT * FROM CONFIRMATION WHERE CONFIRMNUM=#{confirmNum}")
    public  Confirm getConfirm(String confirmNum);
    
    @Select( "SELECT * FROM MEMBERS WHERE MID=#{mid}")
    public  Member getMember(String mid);
    
    @Insert( "INSERT INTO MEMBERS(MID,PWD,NAME,EMAIL,BIRTH,PHONE,OWNERS)VALUES(#{mid},#{pwd},#{name},#{email},#{birth},#{phone},#{owners})")
    public  int addMember(Member m);
    
    @Update( "UPDATE MEMBERS SET PWD=#{pwd},NAME=#{name},BIRTH=#{birth},PHONE=#{phone} WHERE MID=#{mid}")
    public  int modify(Member m);
    
    @Select( "SELECT MID,PWD FROM MEMBERS WHERE NAME = #{param1} AND PHONE = #{param2}")
	public String findUserid(String name,String phone);
	
	@Select("SELECT NVL(MID,0) FROM MEMBERS WHERE EMAIL =#{email}")
	public String findEmail(String email);
	
	@SelectKey(before=true,keyProperty="seq",resultType=String.class,statement="SELECT NVL(MAX(TO_NUMBER(SEQ)),0)+1 FROM STORES")
	@Insert( "INSERT INTO STORES(SEQ,WRITER,STORENUMBER,STORENAME,ADDRESS,PHONENUMBER,IMAGES,STORETYPE)VALUES(#{seq},#{writer},#{storeNumber},#{storeName},#{address},#{phoneNumber},#{images, jdbcType=VARCHAR},#{storeType})")
    public  int storeJoin(Store s);
	
	@Insert("INSERT INTO CONFIRMATION(SEQ,CONFIRMNUM) VALUES ((SELECT MAX(TO_NUMBER(SEQ)) FROM CONFIRMATION)+1,#{confirmNum})")
	public int addConfirm(Confirm c);
    
}

