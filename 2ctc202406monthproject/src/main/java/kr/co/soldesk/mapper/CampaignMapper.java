package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import kr.co.soldesk.beans.CampaignBean;

public interface CampaignMapper {

	// 글쓰기
	@Insert("INSERT INTO campaign (cam_title, cam_host, cam_intro, cam_news, "
			+ "goal_amount, current_amount, cam_img, "
			+ "start_date, end_date, category, donor_count) "
			+ "VALUES (#{cam_title}, #{cam_host}, #{cam_intro}, "
			+ "#{cam_news}, #{goal_amount}, #{current_amount}, "
			+ "#{cam_img, jdbcType=VARCHAR}, #{start_date, jdbcType=DATE}, " 
			+ "#{end_date, jdbcType=DATE}, #{category}, #{donor_count})")
	void addCampaignInfo(CampaignBean writeCampaignBean);

	// 게시판 리스트
	@Select("SELECT campaignID, cam_title, cam_host, goal_amount, current_amount, category, cam_img "
            + "FROM campaign WHERE category = #{category}")
	List<CampaignBean> getCampaignList(String category, RowBounds rowBounds);

	// 게시판 읽기
	@Select("SELECT campaignID, cam_title, cam_host, cam_intro, cam_news, "
			+ "goal_amount, current_amount, cam_img, start_date, end_date, category, donor_count "
			+ "FROM campaign WHERE campaignID = #{campaignID}")
	CampaignBean getCampaignInfo(String campaignID);
	
	//삭제하기
	@Delete("DELETE FROM campaign WHERE campaignID = #{campaignID}")
	 void deleteCampaignInfo(String campaignID);

	//수정하기
	@Update("UPDATE campaign SET cam_title = #{cam_title}, cam_host = #{cam_host}, "
			+ "cam_intro = #{cam_intro}, cam_news = #{cam_news}, "
			+ "goal_amount = #{goal_amount}, current_amount = #{current_amount}, last_update = CURRENT_TIMESTAMP, "
			+ "cam_img = #{cam_img, jdbcType=VARCHAR}, start_date = #{start_date}, end_date = #{end_date}, category = #{category}, "
			+ "donor_count = #{donor_count} WHERE campaignID = #{campaignID}")
	void modifyCampaignInfo(CampaignBean modifyCampaignBean);
	
	@Select("SELECT COUNT(*) FROM campaign WHERE category = #{category}")
    int getCampaignCount(String category);
}
