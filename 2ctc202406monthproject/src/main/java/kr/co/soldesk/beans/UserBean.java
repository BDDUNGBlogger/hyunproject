package kr.co.soldesk.beans;
 
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.stereotype.Component;

@Component
public class UserBean {

	@Size(min = 2, max = 4)
	@Pattern(regexp = "[°¡-ÆR]*")
	private String name;

	@Size(min = 4, max = 20)
	@Pattern(regexp = "[a-zA-Z0-9]*") // ¿µ¾î ¶Ç´Â ¼ýÀÚ¸¸ ÀÔ·Â ÀÚÁÖ ¾²ÀÌ´Â Á¤±Ô½Ä(Regular Expression)
	private String userID;

	@Size(min = 4, max = 20)
	@Pattern(regexp = "[a-zA-Z0-9]*")
	private String password;

	@Size(min = 4, max = 20)
	@Pattern(regexp = "[a-zA-Z0-9]*")
	private String password2;

	private boolean userIdExist;

	private boolean userLogin;

	private Date birthday; 

	private String gender;

	private String email;

	private String phone;

	private Timestamp create_date;

	private Timestamp last_update;

	private String post_num; // ¿ìÆí¹øÈ£

	private String address; // ÁÖ¼Ò
	
	private String rolecd;

	private String User_IDX;

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUserID() {
		
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	public boolean isUserIdExist() {
		return userIdExist;
	}

	public void setUserIdExist(boolean userIdExist) {
		this.userIdExist = userIdExist;
	}

	public boolean isUserLogin() {
		return userLogin;
	}

	public void setUserLogin(boolean userLogin) {
		this.userLogin = userLogin;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Timestamp getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}

	public Timestamp getLast_update() {
		return last_update;
	}

	public void setLast_update(Timestamp last_update) {
		this.last_update = last_update;
	}

	public String getPost_num() {
		return post_num;
	}

	public void setPost_num(String post_num) {
		this.post_num = post_num;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRolecd() {
		return rolecd;
	}

	public void setRolecd(String rolecd) {
		this.rolecd = rolecd;
	}

	public String getUser_IDX() {
		return User_IDX;
	}

	public void setUser_IDX(String user_IDX) {
		User_IDX = user_IDX;
	}

}