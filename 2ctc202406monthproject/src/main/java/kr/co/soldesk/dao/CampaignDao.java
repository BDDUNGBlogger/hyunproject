package kr.co.soldesk.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.CampaignBean;
import kr.co.soldesk.mapper.CampaignMapper;

@Repository
public class CampaignDao {
	
	@Autowired
	private CampaignMapper campaignMapper;
	
	public void addCampaignInfo(CampaignBean writeCampaignBean) {
		campaignMapper.addCampaignInfo(writeCampaignBean);
	}

	public List<CampaignBean> getCampaignList(String category, RowBounds rowBounds) {
		return campaignMapper.getCampaignList(category, rowBounds);
	}
	
	public CampaignBean getCampaignInfo(String campaignID) {
		return campaignMapper.getCampaignInfo(campaignID);
	}
	
	public void deleteCampaignInfo(String campaignID) {
		campaignMapper.deleteCampaignInfo(campaignID);
	}
	
	public void modifyCampaignInfo(CampaignBean modifyCampaignBean) {
		campaignMapper.modifyCampaignInfo(modifyCampaignBean);
	}
	
	public int getCampaignCount(String category) {
		return campaignMapper.getCampaignCount(category);
	}

}
