package kr.co.soldesk.controller;

import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;
import javax.validation.Valid;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.soldesk.beans.CampaignBean;
import kr.co.soldesk.beans.DonationBean;
import kr.co.soldesk.beans.PageBean;
import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.service.CampaignService;
import kr.co.soldesk.service.DonationService;

@Controller
@RequestMapping("/campaign")
public class CampaignController {
    
    @Autowired
    private CampaignService campaignService;
    
    @Autowired
    private DonationService donationService;
    
    @Resource(name="loginUserBean")
    private UserBean loginUserBean;

    @GetMapping("/campaignMain")
    public String campaignMain(@RequestParam(value="page", defaultValue = "1") int page, Model model) { 
        List<CampaignBean> naturalCampaigns = campaignService.getCampaignList("환경", page);
        List<CampaignBean> animalCampaigns = campaignService.getCampaignList("동물", page);
        
        model.addAttribute("naturalCampaigns", naturalCampaigns);
        model.addAttribute("animalCampaigns", animalCampaigns);

        PageBean pageBean = campaignService.getCampaignCount("환경", page);
        model.addAttribute("pageBean", pageBean);
        
        return "campaign/campaignMain"; //jsp
    }
    
    @GetMapping("/campaignNatural")
    public String campaignNatural(@RequestParam(value="page", defaultValue = "1") int page, Model model) {
        List<CampaignBean> naturalCampaigns = campaignService.getCampaignList("환경", page);
        
        model.addAttribute("naturalCampaigns", naturalCampaigns);

        PageBean pageBean = campaignService.getCampaignCount("환경", page);
        model.addAttribute("pageBean", pageBean);
        
        return "campaign/campaignNatural"; //jsp
    }
    
    @GetMapping("/campaignAnimal")
    public String campaignAnimal(@RequestParam(value="page", defaultValue = "1") int page, Model model) {
        
        List<CampaignBean> animalCampaigns = campaignService.getCampaignList("동물", page);
        
        model.addAttribute("animalCampaigns", animalCampaigns);

        PageBean pageBean = campaignService.getCampaignCount("동물", page);
        model.addAttribute("pageBean", pageBean);
        
        return "campaign/campaignAnimal"; //jsp
    }
    
    @GetMapping("/campaignDetail")
    public String campaignDetail(@RequestParam("campaignID") String campaignID, Model model) {
        CampaignBean readCampaignBean = campaignService.getCampaignInfo(campaignID);
        
        // 날짜 차이 계산
        long diffInMillies = Math.abs(readCampaignBean.getEnd_date().getTime() - readCampaignBean.getStart_date().getTime());
        long remainingDays = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
        
        // 기부 내역 가져오기
        List<DonationBean> donations = donationService.getDonationsByCampaignID(campaignID);

        // 줄바꿈을 <br> 태그로 변환하여 모델에 추가
        String introWithBreaks = readCampaignBean.getCam_intro().replaceAll("\n", "<br>");
        String newsWithBreaks = readCampaignBean.getCam_news().replaceAll("\n", "<br>");
        
        model.addAttribute("readCampaignBean", readCampaignBean);
        model.addAttribute("remainingDays", remainingDays);
        model.addAttribute("donations", donations);
        model.addAttribute("introWithBreaks", introWithBreaks);
        model.addAttribute("newsWithBreaks", newsWithBreaks);
        
        return "campaign/campaignDetail"; // JSP 파일 경로
    }
    
    @GetMapping("/campaign_write")
    public String campaignWrite(@ModelAttribute("writeCampaignBean") CampaignBean writeCampaignBean) {
    	
    	 // 역할 확인: 'M'이 아니면 권한 없음 페이지로 리다이렉트
        if (!"M".equals(loginUserBean.getRolecd())) {
            return "redirect:/campaign/campaign_not_write";
        }
    	
        // writeCampaignBean 초기화 시 기본값 설정
        if (writeCampaignBean.getCam_news() == null || writeCampaignBean.getCam_news().isEmpty()) {
            writeCampaignBean.setCam_news("모금소식단체의 모금사업과 관련된 소식을 들려드립니다.");
        }

        
        return "campaign/campaign_write"; // JSP 파일 경로
    }
    
    @GetMapping("/campaign_not_writer")
    public String campaign_not_writer() {
       return "campaign/campaign_not_writer";
    }
    
    @PostMapping("/campaignwrite_pro")
    public String campaignWritePro(@Valid @ModelAttribute("writeCampaignBean") CampaignBean writeCampaignBean,
            BindingResult result) {
    	 
    	// 역할 확인: 'M'이 아니면 권한 없음 페이지로 리다이렉트
        if (!"M".equals(loginUserBean.getRolecd())) {
            return "redirect:/campaign/campaign_not_writer";
        }
    	
    	if(result.hasErrors()) {
            System.out.println("Validation errors in campaign_write form");
            return "campaign/campaign_write"; // JSP 파일 경로
        }
        campaignService.addCampaignInfo(writeCampaignBean);
        System.out.println("Adding campaign info");
        return "campaign/campaign_write_success";
    }
    
    @GetMapping("/campaign_modify")
    public String campaign_modify(@RequestParam("campaignID") String campaignID, Model model) {
        
    	// 역할 확인: 'M'이 아니면 권한 없음 페이지로 리다이렉트
        if (!"M".equals(loginUserBean.getRolecd())) {
            return "redirect:/campaign/campaign_not_writer";
        }
    	
        CampaignBean modifyCampaignBean = campaignService.getCampaignInfo(campaignID);
        
        model.addAttribute("modifyCampaignBean", modifyCampaignBean);
        
        return "campaign/campaign_modify"; // JSP 파일 경로
    }
    
    @PostMapping("/campaign_modify_pro")
    public String campaign_modify_pro(@Valid @ModelAttribute("modifyCampaignBean") CampaignBean modifyCampaignBean, 
                                      BindingResult result) {
    	 // 역할 확인: 'M'이 아니면 권한 없음 페이지로 리다이렉트
        if (!"M".equals(loginUserBean.getRolecd())) {
            return "redirect:/campaign/campaign_not_writer";
        }
    	
        if(result.hasErrors()) {
            return "campaign/campaign_modify"; // JSP 파일 경로
        }
        
        campaignService.modifyCampaignInfo(modifyCampaignBean);
        
        return "campaign/campaign_modify_success";
    }
    
    @GetMapping("/campaign_delete")
    public String campaign_delete(@RequestParam("campaignID") String campaignID) {
    	 
    	// 역할 확인: 'M'이 아니면 권한 없음 페이지로 리다이렉트
        if (!"M".equals(loginUserBean.getRolecd())) {
            return "redirect:/campaign/campaign_not_writer";
        }
    	
        campaignService.deleteCampaignInfo(campaignID);
        return "campaign/campaign_delete";
    }
}
