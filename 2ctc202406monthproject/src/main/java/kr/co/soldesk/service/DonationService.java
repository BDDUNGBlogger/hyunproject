package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.CampaignBean;
import kr.co.soldesk.beans.DonationBean;
import kr.co.soldesk.dao.CampaignDao;
import kr.co.soldesk.dao.DonationDao;

@Service
public class DonationService {

    @Autowired
    private DonationDao donationDao;
    
    @Autowired
    private CampaignDao campaignDao;

    // 후원 정보 추가 및 캠페인 정보 업데이트
    public void addDonation(DonationBean donationBean) {
        donationDao.addDonation(donationBean);
        updateCampaign(donationBean);
    }


    // 캠페인 정보 업데이트
    private void updateCampaign(DonationBean donationBean) {
        CampaignBean campaign = campaignDao.getCampaignInfo(donationBean.getCampaignID());
        if (campaign != null) {
            campaign.setCurrent_amount(campaign.getCurrent_amount() + donationBean.getCam_amount());
            campaign.setDonor_count(campaign.getDonor_count() + 1);
            campaignDao.modifyCampaignInfo(campaign);
        }
    }
    
    public List<DonationBean> getDonationList(String userID) {
        return donationDao.getDonationList(userID);
    }
    
    public List<DonationBean> getDonationListByDateRange(String userID, String donation_startDate, String donation_endDate) { 
        return donationDao.getDonationListByDateRange(userID, donation_startDate, donation_endDate);
    }
    
    public List<DonationBean> getDonationsByCampaignID(String campaignID) {
        return donationDao.getDonationsByCampaignID(campaignID);
    }
    
    //후원 정보 가져오기
    public DonationBean getDonationById(String donationID) {
        return donationDao.getDonationById(donationID);
    }
    
    //후원 취소
    public void cancelDonation(String donationID, String campaignID, double cam_amount) {
        donationDao.cancelDonation(donationID, campaignID, cam_amount);
    }
}
