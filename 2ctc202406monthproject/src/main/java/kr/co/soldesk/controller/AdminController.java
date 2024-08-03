package kr.co.soldesk.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.BoardInfoBean;
import kr.co.soldesk.beans.CampaignBean;
import kr.co.soldesk.beans.ContentBean;
import kr.co.soldesk.beans.DonationBean;
import kr.co.soldesk.beans.OceanofSurfaceBean;
import kr.co.soldesk.beans.OrdersBean;
import kr.co.soldesk.beans.ProductBean;
import kr.co.soldesk.beans.RainfallBean;
import kr.co.soldesk.beans.SeaTemperatureBean;
import kr.co.soldesk.beans.TemperatureBean;
import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.service.AdminService;
import kr.co.soldesk.service.DonationService;
@Controller
@RequestMapping("/admin") 
public class AdminController {

   @Autowired
   private AdminService adminService;
   
   @Autowired
   private DonationService donationService; 

   @GetMapping("/adminMain")
   public String adminMain(Model model) {
      int membercount = adminService.countMember();
      int campaigncount = adminService.countcampaign();
      int donationcount = adminService.countdonation();
      int productcount = adminService.countproduct();
      List<UserBean> top3donor = adminService.getTop3Donors();
      List<DonationBean> donationList = adminService.selectAlldonation();
      List<UserBean> top3ASC = adminService.getTop3DonorsASC();
      List<ContentBean> top3BoardPosts = adminService.getTop3BoardPosts();
      List<CampaignBean> top3Campaigns = adminService.getTop3Campaigns();
      List<UserBean> top3create_User = adminService.getTop3RecentUsers();
      List<DonationBean> top3donation =adminService.getTop3Donation();
      
      model.addAttribute("membercount", membercount);
      model.addAttribute("campaigncount", campaigncount);
      model.addAttribute("donationcount", donationcount);
      model.addAttribute("productcount", productcount);
      model.addAttribute("top3donor", top3donor);
      model.addAttribute("donationList", donationList);
      model.addAttribute("top3ASC", top3ASC);
      model.addAttribute("top3BoardPosts", top3BoardPosts);
      model.addAttribute("top3Campaigns", top3Campaigns);
      model.addAttribute("top3create_User", top3create_User);
      model.addAttribute("top3donation", top3donation);

      
      return "admin/adminMain";
   }

   @GetMapping("/posts")
   public String posts() {
      return "admin/posts";
   }

   @GetMapping("/dashboard")
   public String dashboard() {
      return "admin/dashboard";
   }



   @GetMapping("/environment")
   public String environment(Model model, String category) {
      List<CampaignBean> envirCamlist = adminService.classifyCam("환경");
      model.addAttribute("envirCamlist", envirCamlist);
      return "admin/environment";
   }

   @GetMapping("/animals")
   public String animals(Model model, String category) {
      List<CampaignBean> animalCamlist = adminService.classifyCam("동물");
      model.addAttribute("animalCamlist", animalCamlist);
      return "admin/animals";
   }

   @GetMapping("/Allnotice")
   public String Allnotice(Model model) {
      List<ContentBean> boardList = adminService.allBoard();
      List<BoardInfoBean> boarinfoList = adminService.selectboardinfo();
      model.addAttribute("boarinfoList", boarinfoList);
      model.addAttribute("boardList", boardList);
      return "admin/Allnotice";
   }

   @GetMapping("/Allproduct")
   public String Allproduct(Model model) {
      List<ProductBean> productlist = adminService.selectAllproduct();
      model.addAttribute("productlist", productlist);
      return "admin/Allproduct";
   }

   @GetMapping("/Allmember")
   public String Allmember(Model model) {
      List<UserBean> memberList = adminService.selectAllMember();
      List<CampaignBean> campaignList = adminService.selectAllCampaign();
      List<DonationBean> donationBeanList = adminService.selectsumDonation();
      List<DonationBean> donationadllList = adminService.selectAlldonation();
     
      model.addAttribute("memberList", memberList);
      model.addAttribute("campaignList", campaignList);
      model.addAttribute("donationBeanList", donationBeanList);
      model.addAttribute("donationadllList", donationadllList);
      
      return "admin/Allmember";
   }

   @GetMapping("/Allcampaign")
   public String Allcampaign(Model model) {
      List<CampaignBean> CampaignList = adminService.selectAllCampaign();
      model.addAttribute("CampaignList", CampaignList);
      model.addAttribute("now", new Date());
      return "admin/Allcampaign";
   }

   @GetMapping("/recently")
   public String recently(Model model) {
      List<ProductBean> proudctlist = adminService.selectAllproduct();
      List<UserBean> memberlist = adminService.selectAllMember();
      List<OrdersBean> orderList = adminService.selectAllOrder();
      model.addAttribute("memberlist", memberlist);
      model.addAttribute("proudctlist", proudctlist);
      model.addAttribute("orderlist", orderList);

      return "admin/recently";
   }


   @GetMapping("/weather")
   public String newsletters(Model model) {
      List<ContentBean> boardNews = adminService.classifynotice(3);
      model.addAttribute("boardNews", boardNews);
      return "admin/weather";
   }

   @GetMapping("/productManagement")
   public String productManagement() {
      return "admin/productManagement";
   }

   @GetMapping("/memberManagement")
   public String memberManagement() {
      return "admin/memberManagement";
   }

   // -----------------------------notice-----------------
   @PostMapping("/Board/update/Allnotice")
   public String updateAllNotice(HttpServletRequest request) {
       String[] selectedNotices = request.getParameterValues("selectedNotices");
       if (selectedNotices == null) {
           return "redirect:/admin/Allnotice";
       }

       List<ContentBean> updatedNotices = new ArrayList<>();

       for (String noticeID : selectedNotices) {
           String title = request.getParameter("title_" + noticeID);

           ContentBean contentBean = new ContentBean();
           contentBean.setNoticeID(noticeID);
           contentBean.setTitle(title);
           updatedNotices.add(contentBean);


           
       }

       adminService.updateNotices(updatedNotices);

       return "redirect:/admin/Allnotice";
   }

   @PostMapping("/Board/delete/Allnotice")
   public String deleteNews(HttpServletRequest request) {
      String[] selectedNotices = request.getParameterValues("selectedNotices");
      if (selectedNotices == null) {
         return "redirect:/admin/Allnotice";
      }

      for (String noticeID : selectedNotices) {
         adminService.deleteNotice(noticeID);
      }
      return "redirect:/admin/Allnotice";
   }
   
   
   
   
   

   // -------------------------------product--------------------------
   @PostMapping("/updateProduct")
   public String updateProduct(HttpServletRequest request) {
      String[] selectedProducts = request.getParameterValues("selectedProducts");
      if (selectedProducts == null) {
         return "redirect:/admin/Allproduct";
      }

      List<ProductBean> updatedProducts = new ArrayList<>();
      
      for (String productID : selectedProducts) {
         String product_name = request.getParameter("product_name_" + productID);
         String price = request.getParameter("price_" + productID);
         String inventory = request.getParameter("inventory_" + productID);
         String status = request.getParameter("status_" + productID);

         ProductBean productBean = new ProductBean();
         productBean.setProductID(productID);
         productBean.setProduct_name(product_name);
         productBean.setPrice(Integer.parseInt(price));
         productBean.setInventory(Integer.parseInt(inventory));
         productBean.setStatus(status);

         updatedProducts.add(productBean);
      }
      adminService.updateProduct(updatedProducts);
      return "redirect:/admin/Allproduct";
   }

   @PostMapping("/addProduct")
   public String addProduct(@RequestParam("product_name") String product_name, @RequestParam("price") int price,
         @RequestParam("inventory") String inventory, @RequestParam("status") String status,
         @RequestParam("upload_file") MultipartFile uploadFile, HttpServletRequest request) {
      if (!uploadFile.isEmpty()) {
         String imagePath = request.getServletContext().getRealPath("/") + "resources/images/";
         File uploadDir = new File(imagePath);
         if (!uploadDir.exists()) {
            uploadDir.mkdirs();
         }

         String fileName = uploadFile.getOriginalFilename();
         try {
            uploadFile.transferTo(new File(imagePath + fileName));
         } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/admin/Allproduct";
         }

         ProductBean productBean = new ProductBean();
         productBean.setProduct_name(product_name);
         productBean.setPrice(price);
         productBean.setInventory(Integer.parseInt(inventory));
         productBean.setStatus(status);
         productBean.setProduct_img(fileName);

         adminService.addProduct(productBean);
      }
      return "redirect:/admin/Allproduct";
   }
   
   @PostMapping("/delete/product")
   public String deleteproduct(HttpServletRequest request) {
      String[] selectedNotices = request.getParameterValues("selectedNotices");
      if (selectedNotices == null) {
         return "redirect:/admin/Allproduct";
      }

      for (String productID : selectedNotices) {
         adminService.deleteproduct(productID);
      }
      return "redirect:/admin/Allproduct";
   }
   
   // ------------------------------donation----------------------------------
   @GetMapping("/donation")
   public String donation(Model model) {
      List<UserBean> memberList = adminService.selectAllMember();
      List<CampaignBean> campaignList = adminService.selectAllCampaign();
      List<DonationBean> donationBeanList = adminService.selectAlldonation();
      

      model.addAttribute("memberList", memberList);
      model.addAttribute("campaignList", campaignList);
      model.addAttribute("donationBeanList", donationBeanList);

      return "admin/donation";
   }
     
   
     @GetMapping("/donation/campaign")
     @ResponseBody public List<DonationBean> getDonationByCampaign() { 
        return adminService.getDonationByCampaign(); }
     
     @GetMapping("/donation/user")
     @ResponseBody public List<DonationBean> getDonationByUser() { 
        return adminService.getDonationByUser(); }
    
     
     @GetMapping("/admin/donation")
       public String getDonationPage(Model model) {
           double totalAmountEnvironment = adminService.getTotalAmountEnvironment();
           double totalAmountAnimal = adminService.getTotalAmountAnimal();

           model.addAttribute("total_amount_environment", totalAmountEnvironment);
           model.addAttribute("total_amount_animal", totalAmountAnimal);
           model.addAttribute("campaignList", adminService.selectAllCampaign());
           model.addAttribute("donationBeanList", adminService.selectAllCampaign());
           
           return "admin/donation";
       }
     
     
     
     
     @PostMapping("/donation/update")
       public String updateDonation(HttpServletRequest request) {
           String[] selectedDonationIDs = request.getParameterValues("selectedDonations");
           System.out.println("Selected Donation IDs: {}" +Arrays.toString(selectedDonationIDs)); 
       

           if (selectedDonationIDs != null) {
               List<DonationBean> updatedDonations = new ArrayList<>();

               for (String donationID : selectedDonationIDs) {
                   String campaignID = request.getParameter("campaignID_" + donationID);
                   String userID = request.getParameter("userID_" + donationID);
                   String anonymous = request.getParameter("anonymous_" + donationID);

                   String camAmountStr = request.getParameter("cam_amount_" + donationID);
                   
                   double cam_amount = (camAmountStr != null && !camAmountStr.trim().isEmpty()) ? Double.parseDouble(camAmountStr.trim()) : 0.0;

                   String donationDateStr = request.getParameter("donation_date_" + donationID);
                   Timestamp donation_date = (donationDateStr != null && !donationDateStr.trim().isEmpty()) ? Timestamp.valueOf(donationDateStr.trim()) : new Timestamp(System.currentTimeMillis());

                   String payment_method = request.getParameter("payment_method_" + donationID);

                   DonationBean donation = new DonationBean();
                   donation.setCampaignID(campaignID);
                   donation.setDonationID(donationID);
                   donation.setUserID(userID);
                   donation.setAnonymous(anonymous);
                   donation.setCam_amount(cam_amount);
                   donation.setDonation_date(donation_date);
                   donation.setPayment_method(payment_method);

                   
                   updatedDonations.add(donation);
               }

               adminService.updateDonation(updatedDonations);
           } else {
               System.out.println("에러");
           }

           return "redirect:/admin/donation";
       }
     @PostMapping("/donation/delete")
     public String deleteDonation(HttpServletRequest request) {
         String donationID = request.getParameter("donationID");
         adminService.deleteDonation(donationID);
         return "redirect:/admin/donation";
     }
   
     @PostMapping("/deleteallcampaign")
     public String deleteAllCampaign(HttpServletRequest request) {
         String[] selectedNotices = request.getParameterValues("selectedNotices");
         if (selectedNotices == null) {
            return "redirect:/admin/Allcampaign";
         }

         for (String campaignID : selectedNotices) {
            adminService.deleteCampaign(campaignID);
         }
         return "redirect:/admin/Allcampaign";
      }
     
     
   // --------------------------------------------------ajax

   @PostMapping("/update/campaign")
   public String updateCampaign(HttpServletRequest request) {
      String[] selectedCampaignIDs = request.getParameterValues("selectedNotices");

        if (selectedCampaignIDs != null) {
            List<CampaignBean> updatedCampaigns = new ArrayList<>();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            for (String campaignID : selectedCampaignIDs) {
                String cam_title = request.getParameter("cam_title_" + campaignID);
                String cam_host = request.getParameter("cam_host_" + campaignID);
                String goal_amountStr = request.getParameter("goal_amount_" + campaignID);
                double goal_amount = (goal_amountStr != null && !goal_amountStr.trim().isEmpty()) ? Double.parseDouble(goal_amountStr.trim()) : 0.0;
                String current_amountStr = request.getParameter("current_amount_" + campaignID);
                double current_amount = (current_amountStr != null && !current_amountStr.trim().isEmpty()) ? Double.parseDouble(current_amountStr.trim()) : 0.0;
                String donor_countStr = request.getParameter("donor_count_" + campaignID);
                int donor_count = (donor_countStr != null && !donor_countStr.trim().isEmpty()) ? Integer.parseInt(donor_countStr.trim()) : 0;
                String start_dateStr = request.getParameter("start_date_" + campaignID);
                String end_dateStr = request.getParameter("end_date_" + campaignID);
                   String category = request.getParameter("category_" + campaignID);
   
                Date start_date = null;
                Date end_date = null;
                try {
                    if (start_dateStr != null && !start_dateStr.trim().isEmpty()) {
                        start_date = dateFormat.parse(start_dateStr.trim());
                    }
                    if (end_dateStr != null && !end_dateStr.trim().isEmpty()) {
                        end_date = dateFormat.parse(end_dateStr.trim());
                    }
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                CampaignBean campaign = new CampaignBean();
                campaign.setCampaignID(campaignID);
                campaign.setCam_title(cam_title);
                campaign.setCam_host(cam_host);
                campaign.setGoal_amount(goal_amount);
                campaign.setCurrent_amount(current_amount);
                campaign.setDonor_count(donor_count);
                campaign.setStart_date(new java.sql.Date(start_date.getTime()));
                campaign.setEnd_date(new java.sql.Date(end_date.getTime()));
                campaign.setCategory(category);
                updatedCampaigns.add(campaign);
            }

            adminService.updateCampaign(updatedCampaigns);
        } 
        return "redirect:/admin/animals";
    }
      
   @PostMapping("/delete/campaign")
   public String deleteCampaign(HttpServletRequest request) {
      String[] selectedNotices = request.getParameterValues("selectedNotices");
      if (selectedNotices == null) {
         return "redirect:/admin/Allcampaign";
      }

      for (String campaignID : selectedNotices) {
         adminService.deleteCampaign(campaignID);
      }
      return "redirect:/admin/Allcampaign";
   }
   
    @PostMapping("/campaign/update/environment")
    public String updateenvironmentCampaign(HttpServletRequest request) {
        String[] selectedCampaignIDs = request.getParameterValues("selectedNotices");

        if (selectedCampaignIDs != null) {
            List<CampaignBean> updatedCampaigns = new ArrayList<>();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            for (String campaignID : selectedCampaignIDs) {
                String cam_title = request.getParameter("cam_title_" + campaignID);
                String cam_host = request.getParameter("cam_host_" + campaignID);
                String goal_amountStr = request.getParameter("goal_amount_" + campaignID);
                double goal_amount = (goal_amountStr != null && !goal_amountStr.trim().isEmpty()) ? Double.parseDouble(goal_amountStr.trim()) : 0.0;
                String current_amountStr = request.getParameter("current_amount_" + campaignID);
                double current_amount = (current_amountStr != null && !current_amountStr.trim().isEmpty()) ? Double.parseDouble(current_amountStr.trim()) : 0.0;
                String donor_countStr = request.getParameter("donor_count_" + campaignID);
                int donor_count = (donor_countStr != null && !donor_countStr.trim().isEmpty()) ? Integer.parseInt(donor_countStr.trim()) : 0;
                String start_dateStr = request.getParameter("start_date_" + campaignID);
                String end_dateStr = request.getParameter("end_date_" + campaignID);
                   String category = request.getParameter("category_" + campaignID);
   
                Date start_date = null;
                Date end_date = null;
                try {
                    if (start_dateStr != null && !start_dateStr.trim().isEmpty()) {
                        start_date = dateFormat.parse(start_dateStr.trim());
                    }
                    if (end_dateStr != null && !end_dateStr.trim().isEmpty()) {
                        end_date = dateFormat.parse(end_dateStr.trim());
                    }
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                CampaignBean campaign = new CampaignBean();
                campaign.setCampaignID(campaignID);
                campaign.setCam_title(cam_title);
                campaign.setCam_host(cam_host);
                campaign.setGoal_amount(goal_amount);
                campaign.setCurrent_amount(current_amount);
                campaign.setDonor_count(donor_count);
                campaign.setStart_date(new java.sql.Date(start_date.getTime()));
                campaign.setEnd_date(new java.sql.Date(end_date.getTime()));
                campaign.setCategory(category);
                updatedCampaigns.add(campaign);
            }

            adminService.updateCampaign(updatedCampaigns);
        } 
        return "redirect:/admin/environment";
    }
                   
    @PostMapping("/campaign/delete/environment")
       public String deleteenvironment(HttpServletRequest request) {
           String[] selectedNotices = request.getParameterValues("selectedNotices");
           if (selectedNotices == null) {
               return "redirect:/admin/environment";
           }

           for (String campaignID : selectedNotices) {
               adminService.deleteCampaign(campaignID);
           }
           return "redirect:/admin/environment";
       }
   
   
   
    @PostMapping("/campaign/update/animals")
    public String updateanimalCampaign(HttpServletRequest request) {
        String[] selectedCampaignIDs = request.getParameterValues("selectedNotices");

        if (selectedCampaignIDs != null) {
            List<CampaignBean> updatedCampaigns = new ArrayList<>();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            for (String campaignID : selectedCampaignIDs) {
                String cam_title = request.getParameter("cam_title_" + campaignID);
                String cam_host = request.getParameter("cam_host_" + campaignID);
                String goal_amountStr = request.getParameter("goal_amount_" + campaignID);
                double goal_amount = (goal_amountStr != null && !goal_amountStr.trim().isEmpty()) ? Double.parseDouble(goal_amountStr.trim()) : 0.0;
                String current_amountStr = request.getParameter("current_amount_" + campaignID);
                double current_amount = (current_amountStr != null && !current_amountStr.trim().isEmpty()) ? Double.parseDouble(current_amountStr.trim()) : 0.0;
                String donor_countStr = request.getParameter("donor_count_" + campaignID);
                int donor_count = (donor_countStr != null && !donor_countStr.trim().isEmpty()) ? Integer.parseInt(donor_countStr.trim()) : 0;
                String start_dateStr = request.getParameter("start_date_" + campaignID);
                String end_dateStr = request.getParameter("end_date_" + campaignID);
                   String category = request.getParameter("category_" + campaignID);
   
                Date start_date = null;
                Date end_date = null;
                try {
                    if (start_dateStr != null && !start_dateStr.trim().isEmpty()) {
                        start_date = dateFormat.parse(start_dateStr.trim());
                    }
                    if (end_dateStr != null && !end_dateStr.trim().isEmpty()) {
                        end_date = dateFormat.parse(end_dateStr.trim());
                    }
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                CampaignBean campaign = new CampaignBean();
                campaign.setCampaignID(campaignID);
                campaign.setCam_title(cam_title);
                campaign.setCam_host(cam_host);
                campaign.setGoal_amount(goal_amount);
                campaign.setCurrent_amount(current_amount);
                campaign.setDonor_count(donor_count);
                campaign.setStart_date(new java.sql.Date(start_date.getTime()));
                campaign.setEnd_date(new java.sql.Date(end_date.getTime()));
                campaign.setCategory(category);
                updatedCampaigns.add(campaign);
            }

            adminService.updateCampaign(updatedCampaigns);
        } 
        return "redirect:/admin/animals";
    }
   
    
      @PostMapping("/campaign/delete/animals")
      public String deleteanimals(HttpServletRequest request) {
         String[] selectedNotices = request.getParameterValues("selectedNotices");
         if (selectedNotices == null) {
            return "redirect:/admin/animals";
         }

         for (String campaignID : selectedNotices) {
            adminService.deleteCampaign(campaignID);
         }
         return "redirect:/admin/animals";
      }
    
    
   
   
   //ajax--------------------------------------------------------
    @GetMapping("/admin/getChartData")
       public List<DonationBean> getChartData() {
           return adminService.getAllDonationtotal_amount();
       }
    
    
    
    
    
    
    
    //---------------------------Weather

    
      @GetMapping("/temperature")
      public String temperature(Model model) {
         List<TemperatureBean> temper = adminService.selectAlltemper();
         model.addAttribute("temper", temper);
         return "admin/temperature";
      }

      @GetMapping("/seaLevel")
      public String seaLevel(Model model) {
         List<OceanofSurfaceBean> seaLevel = adminService.selectAlloceanofsurface();
         model.addAttribute("seaLevel", seaLevel);
         return "admin/seaLevel";
      }

      @GetMapping("/precipitation")
      public String precipitation(Model model) {
         List<RainfallBean>  Rainfall = adminService.selectAllrainfall();
         model.addAttribute("Rainfall", Rainfall);
         return "admin/precipitation";
      }

      @GetMapping("/seaTemperature")
      public String seaTemperature(Model model) {
         List<SeaTemperatureBean>  seaTemperature =adminService.selectAllseatemper();
         model.addAttribute("seaTemperature", seaTemperature);
         return "admin/seaTemperature";
      }
    
    
    
    
    
    
}
