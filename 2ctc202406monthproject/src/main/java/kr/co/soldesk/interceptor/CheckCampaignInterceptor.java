package kr.co.soldesk.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.soldesk.beans.ContentBean;
import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.service.CampaignService;

public class CheckCampaignInterceptor implements HandlerInterceptor {
	
	private UserBean loginUserBean;
	
	public CheckCampaignInterceptor(UserBean loginUserBean) {
		this.loginUserBean = loginUserBean;
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if (!loginUserBean.isUserLogin()) {
	            String contextPath = request.getContextPath();
	            response.sendRedirect(contextPath + "/user/not_login");
	            return false;
	        }
		
		return true;
		
	}

}
