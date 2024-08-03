package kr.co.soldesk.controller;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import kr.co.soldesk.beans.DonationBean;
import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.service.DonationService;

@Controller
@RequestMapping("/campaign")
public class DonationController {

	@Autowired
	private DonationService donationService;

	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;

	@PostMapping("/portOnepayment")
	public String portOnePayment(@RequestParam("cam_amount") double cam_amount,
			@RequestParam(value = "anonymous", defaultValue = "false") String anonymous,
			@RequestParam("campaignID") String campaignID, Model model) {

		System.out.println("포트원 결제 메서드에 진입하였습니다.");
		System.out.println("기부 금액: " + cam_amount);
		System.out.println("익명 여부: " + anonymous);
		System.out.println("캠페인 ID: " + campaignID);

		model.addAttribute("cam_amount", cam_amount);
		model.addAttribute("anonymous", anonymous);
		model.addAttribute("campaignID", campaignID);
		model.addAttribute("buyerName", anonymous.equals("true") ? "익명" : loginUserBean.getName());
		model.addAttribute("buyerEmail", loginUserBean.getEmail());
		model.addAttribute("buyerPhone", loginUserBean.getPhone());
		model.addAttribute("buyerAddress", loginUserBean.getAddress());
		model.addAttribute("buyerPost_num", loginUserBean.getPost_num());

		return "campaign/portOnepayment";
	}

	@GetMapping("/payment_success")
	public String PaymentSuccess(@RequestParam("amount") double cam_amount,
			@RequestParam("campaignID") String campaignID, @RequestParam("anonymous") String anonymous, Model model) {

		if (!loginUserBean.isUserLogin()) {
			model.addAttribute("message", "로그인이 필요합니다.");
			return "user/login";
		}

		DonationBean donationBean = new DonationBean();
		donationBean.setCampaignID(campaignID);
		donationBean.setUserID(loginUserBean.getUserID());
		donationBean.setCam_amount(cam_amount);
		donationBean.setPayment_method("card");
		donationBean.setAnonymous(anonymous.equals("true") ? "T" : "F");

		donationService.addDonation(donationBean);

		model.addAttribute("message", "결제가 완료 되었습니다. 감사합니다.");
		return "campaign/payment_success";
	}

	@GetMapping("/payment_fail")
	public String PaymentFail(@RequestParam("campaignID") String campaignID, Model model) {
		model.addAttribute("message", "결제에 실패했습니다. 다시한번 시도해 주세요.");
		model.addAttribute("campaignID", campaignID);
		return "campaign/payment_fail";
	}
	

	@GetMapping("/donationHistory")
    public String donationHistory(@RequestParam(value = "donation_startDate", required = false) String donation_startDate,
                                  @RequestParam(value = "donation_endDate", required = false) String donation_endDate, Model model) {
        if (!loginUserBean.isUserLogin()) {
            model.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/user/not_login";
        }

        

        List<DonationBean> donationList;
        if (donation_startDate != null && donation_endDate != null) {
            donationList = donationService.getDonationListByDateRange(loginUserBean.getUserID(), donation_startDate, donation_endDate);
        } else {
            donationList = donationService.getDonationList(loginUserBean.getUserID());
        }

        model.addAttribute("donationList", donationList);
        return "campaign/donationHistory";
    }

	@GetMapping("/donationCancel")
	public String donationCancel(@RequestParam("donationID") String donationID,
			@RequestParam("campaignID") String campaignID, @RequestParam("cam_amount") double cam_amount, Model model) {

		DonationBean donation = donationService.getDonationById(donationID);
		model.addAttribute("donation", donation);

		return "campaign/donationCancel";
	}

	@PostMapping("/cancelDonation")
	public String cancelDonation(@RequestParam("donationID") String donationID,
			@RequestParam("campaignID") String campaignID, @RequestParam("cam_amount") double cam_amount, Model model) {

		donationService.cancelDonation(donationID, campaignID, cam_amount);

		model.addAttribute("message", "후원이 취소되었습니다.");
		model.addAttribute("alertMessage", "후원이 취소되었습니다.");
		return "redirect:/campaign/myDonationHistory"; // 내 후원 내역 페이지로 리디렉션
	}

	// 내 후원 내역 페이지로 이동
	@GetMapping("/myDonationHistory")
	public String myDonationHistory(Model model) {
		// 로그인 사용자 정보 필요시 추가 가능
		String userID = loginUserBean.getUserID();

		// 후원 내역 가져오기
		List<DonationBean> donationList = donationService.getDonationList(userID);
		model.addAttribute("donationList", donationList);

		return "campaign/donationHistory";
	}

}
