package kr.co.soldesk.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.soldesk.beans.UserBean;

public class CheckLoginInterceptor implements HandlerInterceptor{
	
	private UserBean loginUserBean;
	
	//DI
	public CheckLoginInterceptor(UserBean loginUserBean) {
		this.loginUserBean = loginUserBean;
	}
	//이벤트가 발생하면 로그인 후 사용하세요... 페이지로 이동
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 로그인을 하지 않았다면
		if (loginUserBean.isUserLogin() == false) {
			String contextPath = request.getContextPath();
			
			//로그인이 되어 있지 않았으므로 웹브라우져에게 not_login을 요청하도록 지시함
			response.sendRedirect(contextPath + "/user/not_login");
			System.out.println("contextPath");
			return false;
		}
		//로그인 상태
		return true;
	}
	
}