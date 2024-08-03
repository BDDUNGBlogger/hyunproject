package kr.co.soldesk.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import kr.co.soldesk.beans.UserBean;

public class UserValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {

		return UserBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		UserBean userBean = (UserBean) target; // UserBean으로 형변환

		// 어떤 객체가 사용하는 유호성 검사인지 반환해주는 메소드
		String beanName = errors.getObjectName();
		System.out.println("누가찍히니:" + beanName); // joinUserBean

		if (beanName.equals("joinUserBean") || beanName.equals("modifyUserBean")) {

			if (userBean.getPassword().equals(userBean.getPassword2()) == false) {
				System.out.println("UserValidator 비번같냐");
				errors.rejectValue("password", "NotEquals");
				errors.rejectValue("password2", "NotEquals");
			}

			// 중복성 체크
			if (beanName.equals("joinUserBean")) {
				if (userBean.isUserIdExist() == false) {
					errors.rejectValue("userID", "DontCheckUserIdExist");

				}
			}
		}

	}

}
