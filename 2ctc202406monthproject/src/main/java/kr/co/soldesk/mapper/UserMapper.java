package kr.co.soldesk.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.UserBean;

public interface UserMapper {
  
	// 아이디 중복 체크에 사용된 sql
	 
	// 마이바티즈는 #으로 받아들임
	@Select("select name " + "from member " + "where userid=#{userID}")
	String checkUserIdExist(String userID);


	// 회원가입(저장)
	@Insert("INSERT INTO member (userID, password, name, gender, birthday, email, phone, post_num, create_date, last_update, address, rolecd) "
			+ "VALUES (#{userID}, #{password}, #{name}, #{gender}, #{birthday}, #{email}, #{phone}, #{post_num}, SYSDATE, SYSDATE, #{address}, 'U')")
	void addUserInfo(UserBean joinUserBean);
	
	//로그인시 회원가입 정보 확인
	@Select("select userID, name, roleCD " + 
			"from member " + 
			"where userID=#{userID} and password=#{password}")
	UserBean getLoginUserInfo(UserBean tempLoginUserBean);
	
	//마이페이지 또는 정보수정에 필요한 데이터 가져오기
	@Select("select userID, password, name, birthday, gender, email, phone, post_num, address " +
			"from member " +
			"where userID = #{userID}")
	UserBean getModifyUserInfo(String userID);
	
	//정보수정 Update
	@Update("update member " +
			"set password = #{password}, email= #{email}, phone= #{phone}, post_num= #{post_num}, address= #{address} " +
			"where userID = #{userID}")
	void modifyUserInfo(UserBean modifyUserBean);
	
	/*
	//회원정보 가지고오기
	@Select("select userID, name, birthday, gender, email, phone, post_num, address " + 
			"from member " + 
			"where userID=#{userID}")
	UserBean getUserListInfo(String userID);
	*/
	//아이디찾기 
	@Select("select * from member where userID=#{userID} " )
	UserBean getFindUser(String userID);
	
	//아이디찾기 정보가있다면 그사람의 아이디 보여주기
	@Select("SELECT userID FROM member WHERE name=#{name} AND email=#{email} AND phone=#{phone}" )
	UserBean getfindid(@Param("name") String name , @Param("email") String email ,@Param("phone") String phone);
	
	//비밀번호찾기
	@Select("select * from member where password=#{password} " )
	UserBean getFindUserpw(String password);
	
	//아이디가 맞으면 비밀번호 보여주기
	@Select("SELECT password FROM member WHERE userID=#{userID} AND name=#{name} AND email=#{email}" )
	UserBean getfindpw(@Param("userID") String userID , @Param("name") String name ,@Param("email") String email);

	//권한코드
	@Select("select roleCD from member where userID=#{userID}")
	UserBean getFindRoleCD(@Param("userID") String userID);
	
	@Insert("insert into member (userID, password, name, email, create_date, roleCD) "
	         + "values (#{userID}, #{password}, #{name}, #{email}, sysdate, 'U')")
	   void addGoogleUserInfo(@Param("userID") String userID, @Param("password") String password,
	         @Param("email") String email, @Param("name") String name);

	   @Select("select name, userID from member where userID = #{userID}")
	   UserBean getGoogleLoginUserInfo(@Param("userID") String userID);

	   @Select("select name from member where userID = #{userID}")
	   String checkGoogleUserIDExist(@Param("userID") String userID);
	   
	   @Update("UPDATE member SET name = #{name}, password = #{password} WHERE userID = #{userID}")
	    void updateGoogleUserInfo(@Param("userID") String userID, 
	                              @Param("name") String name, 
	                              @Param("password") String password);
	
}



