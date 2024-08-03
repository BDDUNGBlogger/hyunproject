package kr.co.soldesk.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import kr.co.soldesk.dao.AdminDao;

@Service
public class AdminService { 
      
   @Autowired 
   private AdminDao adminDao; 
   
   @Autowired
   private CampaignService campaignService;
   
   public List<UserBean> selectAllMember() {
      return adminDao.selectAllMember();
   }
   public List<CampaignBean> selectAllCampaign(){
      return adminDao.selectAllCampaign();
   }
   
   public List<ProductBean> selectAllproduct(){
      return adminDao.selectAllproduct();
   }
   
   public List<CampaignBean> classifyCam(String category){
      return adminDao.classifyCam(category);
   }
   
   
   
   public List<ContentBean> allBoard(){
      return adminDao.allBoard();
   }
   public List<ContentBean> classifynotice(int board_idx){
      return adminDao.classifynotice(board_idx);
   }
   
   
   public void updateDonation(List<DonationBean> donations) {
        for (DonationBean donation : donations) {
           System.out.println(("Updating donation in database: {}"+donation));
            
            adminDao.updateDonation(donation);
        }
   }
       public void addProduct(ProductBean productBean) {
           adminDao.addProduct(productBean);
       }
   
   //---------------------------notice------------
       public void updateNotices(List<ContentBean> notices) {
           for (ContentBean notice : notices) {
              adminDao.updateNotice(notice);
            }
       }
       
      
      public void deleteNotice(String noticeID) {
         adminDao.deleteNotice(noticeID);
      }
      
      public List<BoardInfoBean> selectboardinfo(){
          return adminDao.selectboardinfo();
       }
      
      public void deleteproduct(String productID) {
         adminDao.deleteproduct(productID);
      }
      
      
   //-----------------------------------ajax-------------------------
   
      public List<DonationBean> selectsumDonation(){
         return adminDao.selectsumDonation();
      }
      

    public void updateCampaign(List<CampaignBean> updatedData) {
       for(CampaignBean campaign : updatedData) {
          
          adminDao.updateCampaign(campaign);
       }
    }
    public void deleteCampaign(String campaignID) {
       adminDao.deleteCampaign(campaignID);
    }
    
    //-------------------------------donation
    
    public List<DonationBean> getDonationByCampaign() {
        return adminDao.getDonationByCampaign();
    }

    public List<DonationBean> getDonationByUser() {
        return adminDao.getDonationByUser();
    }

    public void updateDonation(DonationBean donation) {
        adminDao.updateDonation(donation);
    }

    public void deleteDonation(String donationID) {
        adminDao.deleteDonation(donationID);
    }
    
    public List<DonationBean> selectAlldonation() {
       return adminDao.selectAlldonation();
    }
    
    public double getTotalAmountEnvironment() {
        return adminDao.getTotalAmountEnvironment();
     }

   
     public double getTotalAmountAnimal() {
           return adminDao.getTotalAmountAnimal();
       }
     public List<OrdersBean> selectAllOrder(){
         return adminDao.selectAllOrder();
      }
    
    //member---------------------------------------
    public void updateMembers(List<UserBean> updatedMembers) {
        for (UserBean member : updatedMembers) {
            adminDao.updateMember(member);
        }
    }
    
    public double getDonationAmount(String userID) {
        return adminDao.getDonationAmount(userID);
    }


   public List<DonationBean> getAllDonationtotal_amount(){
      return adminDao.getAllDonationtotal_amount();
   }
    
   public void updateProduct(List<ProductBean> updateproduct){
      for(ProductBean product : updateproduct) {
         adminDao.updateProduct(product);
      }
   }
   
   
     //-----------------------------Weather----------------------
    
      public List<TemperatureBean> selectAlltemper(){
         return adminDao.selectAlltemper();
      }
   

      public List<SeaTemperatureBean> selectAllseatemper(){
         return adminDao.selectAllseatemper();
      }
      

      public List<OceanofSurfaceBean> selectAlloceanofsurface(){
         return adminDao.selectAlloceanofsurface();
      }
      
      public List<RainfallBean> selectAllrainfall(){
         return adminDao.selectAllrainfall();
      }
      
      
      
      //------------------------------admin Main
       
      public int countMember(){
         return adminDao.countMember();
      }
      
      
      public int countproduct(){
         return adminDao.countProduct();
      }
         
      
      public int countdonation(){
         return adminDao.countDonation();
      }
      
      
      public int countcampaign(){
         return adminDao.countCampaign();
      }
      
      public List<UserBean> getTop3Donors(){
         return adminDao.getTop3Donors();
      }
      
      public List<UserBean> getTop3DonorsASC(){
         return adminDao.getTop3DonorsASC();
      }
      
      public void addContentInfo(ContentBean writeContentBean) {
         adminDao.addContentInfo(writeContentBean);
      }
            
      public String getBoardInfoName(int board_IDX) {
         return adminDao.getBoardInfoName(board_IDX);
      }
      
       
       public List<ContentBean> getTop3BoardPosts(){
          return adminDao.getTop3BoardPosts();
       }
       

       public  List<CampaignBean> getTop3Campaigns(){
          return adminDao.getTop3Campaigns();
       }

       public  List<UserBean> getTop3RecentUsers(){
          return adminDao.getTop3RecentUsers();
       }
       public void updateBoardInfos(List<BoardInfoBean> updatedBoardInfos) {
           for (BoardInfoBean boardInfoBean : updatedBoardInfos) {
              adminDao.updateBoardInfo(boardInfoBean.getBoard_IDX(), boardInfoBean.getBoard_info_Nm());
           }
       }
       
       public List<DonationBean> getTop3Donation(){
         return adminDao.getTop3Donation();
      }
      
}
