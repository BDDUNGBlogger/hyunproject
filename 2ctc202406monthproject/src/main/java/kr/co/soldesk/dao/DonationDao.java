package kr.co.soldesk.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.DonationBean;
import kr.co.soldesk.mapper.DonationMapper;

@Repository
public class DonationDao {

    @Autowired
    private DonationMapper donationMapper;

    // 후원 정보를 데이터베이스에 추가
    public void addDonation(DonationBean donationBean) {
        donationMapper.addDonation(donationBean);
    }
    
    public List<DonationBean> getDonationList(String userID) {  	
    	return donationMapper.getDonationList(userID);
    	
    }
    
    public List<DonationBean> getDonationListByDateRange(String userID, String donation_startDate, String donation_endDate) {
        List<DonationBean> result = donationMapper.getDonationListByDateRange(userID, donation_startDate, donation_endDate);
        
        return result;
    }
    
    //후원 정보 가져오기
    public DonationBean getDonationById(String donationID) {
        return donationMapper.getDonationById(donationID);
    }
    
    public List<DonationBean> getDonationsByCampaignID(String campaignID) {
    	return donationMapper.getDonationsByCampaignID(campaignID);
    }
    
    //후원 취소
    public void cancelDonation(String donationID, String campaignID, double cam_amount) {
        donationMapper.deleteDonation(donationID);

        DonationBean donationBean = new DonationBean();
        donationBean.setCampaignID(campaignID);
        donationBean.setCam_amount(cam_amount);

        donationMapper.updateCampaignOnCancellation(donationBean);
    }
   
}
