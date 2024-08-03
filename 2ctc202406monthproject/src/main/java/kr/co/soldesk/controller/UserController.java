package kr.co.soldesk.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.catalina.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.dao.UserDao;
import kr.co.soldesk.service.UserService;
import kr.co.soldesk.validator.UserValidator;

@Controller
@RequestMapping("/user")
public class UserController {
  
    @Autowired
    private UserService userService;
    
    @Resource(name = "loginUserBean")
    private UserBean loginUserBean;
    

    @GetMapping("/login")
	public String login(@ModelAttribute("tempLoginBean") UserBean tempLoginBean,
			@RequestParam(value = "fail", defaultValue = "false") boolean fail, Model model) {
		// @RequestParam(value = "fail", defaultValue = "false") => fail=false
		// fail=fail
		model.addAttribute("fail", fail); // fail=false
		
		return "user/login";
	}

    @PostMapping("/login_pro")
    public String login_pro(@Valid @ModelAttribute("tempLoginBean") UserBean tempLoginBean, 
    		BindingResult result, HttpSession session) {

        if (result.hasErrors()) {
            return "user/login";
        }

        userService.getLoginUserInfo(tempLoginBean);

        if (loginUserBean.isUserLogin() == true) {
        	session.setAttribute("loginUserBean", loginUserBean);
            return "user/login_success";
        } else {
            return "user/login_fail";
        }
    }
    
    @GetMapping("/userList")
    public String userList(@ModelAttribute("modifyUserBean") UserBean modifyUserBean) {
    	
    	userService.getModifyUserInfo(modifyUserBean);
        

        return "user/userList";
    }

    @GetMapping("/join")
    public String join(@ModelAttribute("joinUserBean") UserBean joinUserBean) {
        return "user/join";
    }

    @PostMapping("/join_pro")
    public String join_pro(@Valid @ModelAttribute("joinUserBean") UserBean joinUserBean, BindingResult result) {
        if (result.hasErrors()) {
            return "user/join";
        }
 
        userService.addUserInfo(joinUserBean);
        return "user/join_success";
    }

    @GetMapping("/modify")
    public String modify(@ModelAttribute("modifyUserBean") UserBean modifyUserBean) {
        userService.getModifyUserInfo(modifyUserBean);
        return "user/modify";
    }
    
   
    
    @GetMapping("/mypage")
    public String mypage(@ModelAttribute("modifyUserBean") UserBean modifyUserBean) {
    	
    	userService.getModifyUserInfo(modifyUserBean);
    	
    	return "user/mypage";
    }
    
    @PostMapping("/mypage_pro")
    public String mypage_pro(@Valid @ModelAttribute("joinUserBean") UserBean joinUserBean, BindingResult result) {
 
    	if(result.hasErrors()) {
    		return "user/mypage";
    	}
    	userService.getLoginUserInfo(joinUserBean);
    	return "user/mypage_List";
    }
    
    @PostMapping("/modify_pro")
    public String modify_pro(@Valid @ModelAttribute("modifyUserBean") UserBean modifyUserBean, BindingResult result) {
        if (result.hasErrors()) {
            return "user/modify";
        }

        userService.modifyUserInfo(modifyUserBean);
        return "user/modify_success";
    }

    @GetMapping("/logout")
    public String logout() {
        loginUserBean.setUserLogin(false);
        return "user/logout";
    }

    @GetMapping("/not_login")
    public String not_login() {
        return "user/not_login";
    }

    @GetMapping("/find_id")
    public String find_id(Model model) {
        model.addAttribute("userBean", new UserBean());
        return "user/find_id";
    }

    @PostMapping("/find_id_pro")
    public String find_pro(@ModelAttribute("userBean") UserBean userBean,
                           @RequestParam("name") String name,
                           @RequestParam("email") String email,
                           @RequestParam("phone") String phone,
                           Model model) {

        UserBean user = userService.getfindid(name, email, phone);

        if (user != null && !user.getUserID().isEmpty()) {
            model.addAttribute("userID", user.getUserID());

            System.out.println(user.getName());
            System.out.println(user.getUserID());
            System.out.println(user.getAddress());
            return "user/findid_success";
            
        } else {
            model.addAttribute("errorMessage", "사용자를 찾을 수 없습니다.");
            return "user/find_fail";
        }
    }
    
    @GetMapping("/find_pw")
    public String find_pw(Model model) {
        model.addAttribute("userBean", new UserBean());
        return "user/find_pw";
    }
    
    @PostMapping("/findpw_pro")
    public String findpw_pro(@ModelAttribute("userBean") UserBean userBean,
            @RequestParam("userID") String userID,
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            Model model) {
    	
    	UserBean user2 = userService.getfindpw(userID, name, email);
    	if (user2 != null && !userBean.getUserID().isEmpty()) {
            model.addAttribute("password", user2.getPassword());

            System.out.println(user2.getName());
            System.out.println(user2.getUserID());
            System.out.println(user2.getEmail());
            return "user/findpw_success";
            
        } else {
            model.addAttribute("errorMessage", "찾을수 없는 아이디입니다.");
            return "user/findpw_fail";
        }
    }
    
    

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        UserValidator validator1 = new UserValidator();
        binder.addValidators(validator1);
    }
}
