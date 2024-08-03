package kr.co.soldesk.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.annotation.SessionScope;

import kr.co.soldesk.beans.UserBean;

//프로젝트 작업시 사용할 일반 bean들 정의하는 클래스 

@Configuration
public class RootAppContext {
	
	//UserBean loginUserBean=new UserBean(); 
	//등록
	@Bean("loginUserBean")
	@SessionScope
	public UserBean loginUserBean() {

		return new UserBean();
	}

}
