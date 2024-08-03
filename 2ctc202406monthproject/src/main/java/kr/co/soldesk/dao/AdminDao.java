package kr.co.soldesk.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
import kr.co.soldesk.mapper.AdminMapper;


@Repository
public class AdminDao { 
   
   @Autowired
   private AdminMapper adminMapper;  
   
   
   public List<UserBean> selectAllMember() {
      return adminMapper.selectAllMember();
   }
   
   
   public List<DonationBean> getAllDonationtotal_amount(){
      return adminMapper.getAllDonationTotalAmount();
   }
   
   public List<DonationBean> getTop3Donation(){
      return adminMapper.getTop3Donation();
   }
   
   public List<DonationBean> selectsumDonation(){
      return adminMapper.selectsumDonation();
   }
   
   public void deleteproduct(String productID) {
      adminMapper.deleteproduct(productID);
   }
   
   
   public List<CampaignBean> selectAllCampaign(){
      return adminMapper.selectAllCampaign();
   }
   
   public List<CampaignBean> classifyCam(String category){
      return adminMapper.classifyCam(category);
   }
   
   
    
     public double getTotalAmountEnvironment() {
        return adminMapper.getTotalAmountEnvironment();
     }

   
     public double getTotalAmountAnimal() {
           return adminMapper.getTotalAmountAnimal();
       }
    
      public List<OrdersBean> selectAllOrder(){
         return adminMapper.selectAllOrder();
      }
   
   public List<ProductBean> selectAllproduct(){
      return adminMapper.selectAllProduct();
   }
   
   
    public void updateProduct(ProductBean updatedProducts) {
         adminMapper.updateProduct(updatedProducts);
       }

       public void addProduct(ProductBean productBean) {
          adminMapper.addProduct(productBean);
       }
   
   
   
   
   public List<ContentBean> allBoard(){
      return adminMapper.allBoard();
   }
   
   
   public List<ContentBean> classifynotice(int board_idx){
      return adminMapper.classifyNotice(board_idx);
   }
   
   
   
   
   //-------------------------------donation----------------------
     public List<DonationBean> alldonation(String category){
          return adminMapper.allDonation(category);
       }
   
     public List<DonationBean> getDonationByCampaign(){
        return adminMapper.getDonationByCampaign();
     }
     
     public List<DonationBean> getDonationByUser(){
        return adminMapper.getDonationByUser();
     }
   
     public List<DonationBean> getRecentDonations(){
        return adminMapper.getRecentDonations();
     }
   
     public void updateDonation(DonationBean donation) {
       adminMapper.updateDonation(donation);
     }
     
     public void deleteDonation(@Param("donationID") String donationID) {
        adminMapper.deleteDonation(donationID);
     }
   //-----------------------------------------------ajax--------------



    
    public void updateCampaign(CampaignBean camBean) {
       adminMapper.updateCampaign(camBean);
    }

    public void deleteCampaign(String campaignID) {
       adminMapper.deleteCampaign(campaignID);
    }
    
   
    public void updateNotice(ContentBean notice) {
       adminMapper.updateNotice(notice);
    }

    public List<BoardInfoBean> selectboardinfo(){
       return adminMapper.selectBoardInfo();
    }
    
   public void deleteNotice(String noticeID) {
      adminMapper.deleteNotice(noticeID);
   }
    
    
    public void updateMember(UserBean memberBean) {
        adminMapper.updateMember(memberBean);
    }
    public double getDonationAmount(String userID) {
        return adminMapper.getDonationAmount(userID);
    }

    public List<DonationBean> selectAlldonation() {
       return adminMapper.selectAllDonation();
    }
    
    
    //-----------------------------Weather----------------------
     
      public List<TemperatureBean> selectAlltemper(){
         return adminMapper.selectAllTemper();
      }
   

      public List<SeaTemperatureBean> selectAllseatemper(){
         return adminMapper.selectAllSeaTemper();
      }
      

      public List<OceanofSurfaceBean> selectAlloceanofsurface(){
         return adminMapper.selectAllOceanOfSurface();
      }
      
      public List<RainfallBean> selectAllrainfall(){
         return adminMapper.selectAllRainfall();
      }
      
      //------------------------------admin Main
    
      public int countMember(){
         return adminMapper.countMember();
      }
      
      
      public int countProduct(){
         return adminMapper.countProduct();
      }
         
      
      public int countDonation(){
         return adminMapper.countDonation();
      }
      
      
      public int countCampaign(){
         return adminMapper.countCampaign();
      }
      
      public List<UserBean> getTop3Donors(){
         return adminMapper.getTop3Donors();
      }
      
      public List<UserBean> getTop3DonorsASC(){
         return adminMapper.getTop3DonorsASC();
      }
      
      
      public void addContentInfo(ContentBean writeContentBean) {
         adminMapper.addContentInfo(writeContentBean);
      }
            
      public String getBoardInfoName(int board_IDX) {
         return adminMapper.getBoardInfoName(board_IDX);
      }
      
    
       public List<ContentBean> getTop3BoardPosts(){
          return adminMapper.getTop3BoardPosts();
       }
       

       public  List<CampaignBean> getTop3Campaigns(){ 
          return adminMapper.getTop3Campaigns();
       }

       public  List<UserBean> getTop3RecentUsers(){
          return adminMapper.getTop3RecentUsers();
       }
       
       public void updateBoardInfo(int board_IDX,  String board_info_Nm) {
          adminMapper.updateBoardInfo(board_IDX, board_info_Nm);
       }
      

}
