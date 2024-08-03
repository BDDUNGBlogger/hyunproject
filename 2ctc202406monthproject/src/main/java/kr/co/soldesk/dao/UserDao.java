package kr.co.soldesk.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.mapper.UserMapper;
import kr.co.soldesk.service.UserService;

@Repository
public class UserDao {
     
	// 저장하는곳
	@Autowired
	private UserMapper userMapper;

	public String checkUserExist(String userID) {

		return userMapper.checkUserIdExist(userID);

	}

	public void addUserInfo(UserBean joinUserBean) {
		userMapper.addUserInfo(joinUserBean);
	}

	public UserBean getLoginUserInfo(UserBean tempLoginUserBean) {

		return userMapper.getLoginUserInfo(tempLoginUserBean);
	}

	public UserBean getModifyUserInfo(String userID) {

		return userMapper.getModifyUserInfo(userID);
	}
 
	public void modifyUserInfo(UserBean modifyUserBean) {

		userMapper.modifyUserInfo(modifyUserBean);
	}
	public UserBean getFindUser(String userID) {
		return userMapper.getFindUser(userID);
	}
	
	public UserBean getfindid(String name , String email , String phone) {
		return userMapper.getfindid(name, email, phone);
	}
	
	public UserBean getFindUserpw(String password) {
		return userMapper.getfindpw(password, password, password);
	}
	
	public UserBean getfindpw(String userID, String name, String email) {
		
		return userMapper.getfindpw(userID, name, email);
	}
	public UserBean getFindRoleCD(String userID) {
		return userMapper.getFindRoleCD(userID);
	}

	public void addGoogleUserInfo(String userID, String password, String email, String name) {
	      userMapper.addGoogleUserInfo(userID, password, email, name);
	   }
	   
	   public UserBean getGoogleLoginUserInfo(String userID) {
	      return userMapper.getGoogleLoginUserInfo(userID);
	   }
	   
	   public String checkGoogleUserIDExist(String userID) {
	      return userMapper.checkGoogleUserIDExist(userID);
	   }
	   @Transactional
	    public void updateGoogleUserInfo(String userID, String name, String password) {
	        userMapper.updateGoogleUserInfo(userID, name, password);
	        System.out.println("Google user updated: " + userID);
	    }


}
