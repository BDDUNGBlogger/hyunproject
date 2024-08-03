package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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

public interface AdminMapper {  
   
    //----------------------------------캠페인--------------------------------------
    
    @Delete("DELETE FROM campaign WHERE campaignID = #{campaignID}")
    void deleteCampaignInfo(@Param("campaignID") String campaignID);

   

    @Select("SELECT COUNT(*) FROM campaign WHERE category = #{category}")
    int getCampaignCount(String category);

    @Select("SELECT campaignID, cam_title, cam_host, create_date, last_update, "
          + "cam_intro, cam_news, goal_amount, current_amount, cam_img, "
          + "start_date, end_date, category, donor_count "
          + "FROM campaign")
    List<CampaignBean> selectAllCampaign();

    @Select("SELECT campaignID, cam_title, cam_host, create_date, last_update, "
          + "cam_intro,cam_news, goal_amount, current_amount, cam_img, "
          + "start_date, end_date, category, donor_count "
          + "FROM campaign WHERE category = #{category}")
    List<CampaignBean> classifyCam(String category);

    //-------------------------------회원---------------------------------------
    @Select("SELECT userID, password, name, gender, birthday, email, phone, post_num, address, "
          + "create_date, last_update, roleCD "
          + "FROM member")
    List<UserBean> selectAllMember();

    @Update("UPDATE member SET name=#{name}, email=#{email} WHERE userID=#{userID}")
    void updateMember(UserBean memberBean);

    @Select("SELECT SUM(d.cam_amount) FROM donation d WHERE d.userID = #{userID}")
    double getDonationAmount(String userID);

    @Select("SELECT c.cam_title FROM campaign c, donation d WHERE c.campaignID = #{campaignID} AND d.userID = #{userID}")
    List<String> getCampaignParticipation(@Param("campaignID") String campaignID, @Param("userID") String userID);

    //-------------------------------상품-------------------------------
    @Select("SELECT productID, product_name, price, inventory, status, product_img, create_date "
          + "FROM product")
    List<ProductBean> selectAllProduct();

    @Update("UPDATE product SET product_name=#{product_name}, price=#{price}, inventory=#{inventory}, status=#{status} WHERE productID=#{productID}")
    void updateProduct(ProductBean productBean);

    @Insert("INSERT INTO product (product_name, price, inventory, status, product_img, create_date) VALUES (#{product_name}, #{price}, #{inventory}, #{status}, #{product_img}, sysdate)")
    void addProduct(ProductBean productBean);

    //-------------------------------게시물-------------------------------
    @Select("SELECT noticeID, title, content_text, img, comments, writerID, board_IDX, create_date, last_update "
          + "FROM content_notice")
    List<ContentBean> allBoard();

    @Select("SELECT noticeID, title, content_text, img, comments, writerID, board_IDX, create_date, last_update "
          + "FROM content_notice WHERE board_idx = #{board_idx}")
    List<ContentBean> classifyNotice(int board_idx);

    @Update("UPDATE content_notice SET title = #{title} WHERE noticeID = #{noticeID}")
    void updateNotice(ContentBean notice);

    @Delete("DELETE FROM content_notice WHERE noticeID = #{noticeID}")
    void deleteNotice(String noticeID);

    @Select("SELECT * FROM board_notice ORDER BY board_info_Nm")
    List<BoardInfoBean> selectBoardInfo();

    @Insert("INSERT INTO content_notice (noticeID, title, content_text, img, comments, writerID, board_IDX, create_date, last_update) "
          + "VALUES (#{noticeID, jdbcType=VARCHAR}, #{title}, #{content_text}, #{img, jdbcType=VARCHAR}, #{comments, jdbcType=VARCHAR}, #{writerID}, #{board_IDX}, sysdate, sysdate)")
    void addContentInfo(ContentBean writeContentBean);

    @Select("SELECT board_info_Nm FROM board_notice WHERE board_IDX = #{board_IDX}")
    String getBoardInfoName(int board_IDX);

    @Update("UPDATE board_notice SET board_info_Nm = #{board_info_Nm} WHERE board_IDX = #{board_IDX}")
    void updateBoardInfo(@Param("board_IDX") int board_IDX, @Param("board_info_Nm") String board_info_Nm);

    //-------------------------------후원-------------------------------
    @Select("SELECT donationID, campaignID, userID, anonymous, cam_amount, TO_DATE(donation_date, 'yyyy-MM-dd') AS donation_date, payment_method "
          + "FROM donation WHERE category = #{category} ORDER BY cam_amount")
    List<DonationBean> allDonation(@Param("category") String category);

    @Select("SELECT campaignID, SUM(cam_amount) as total_amount FROM donation GROUP BY campaignID")
    List<DonationBean> getDonationByCampaign();

    @Select("SELECT userID, SUM(cam_amount) as total_amount FROM donation GROUP BY userID")
    List<DonationBean> getDonationByUser();

    @Select("SELECT donationID, campaignID, userID, anonymous, cam_amount, TO_DATE(donation_date, 'yyyy-MM-dd') AS donation_date, payment_method "
          + "FROM donation ORDER BY donation_date DESC FETCH FIRST 10 ROWS ONLY")
    List<DonationBean> getRecentDonations();

    @Update("UPDATE donation SET anonymous = #{anonymous}, cam_amount = #{cam_amount}, payment_method = #{payment_method} WHERE donationID = #{donationID}")
    void updateDonation(DonationBean donation);

    @Select("SELECT SUM(cam_amount) FROM donation WHERE category = '환경'")
    double getTotalAmountEnvironment();

    @Select("SELECT SUM(cam_amount) FROM donation WHERE category = '동물'")
    double getTotalAmountAnimal();

    @Delete("DELETE FROM donation WHERE donationID = #{donationID}")
    void deleteDonation(@Param("donationID") String donationID);

    @Select("SELECT * FROM donation")
    List<DonationBean> selectAllDonation();
    
    @Select("select userID,sum(cam_amount) as cam_amount from donation "
          + "GROUP BY userID ")
    List<DonationBean> selectsumDonation();
    
    @Delete("DELETE FROM product WHERE productID = #{productID}")
    void deleteproduct(@Param("productID") String productID);
    
    //---------------------ajax---------------------
    @Update("UPDATE campaign SET cam_title=#{cam_title}, cam_host=#{cam_host}, goal_amount=#{goal_amount}, current_amount=#{current_amount} ,start_date=#{start_date} ,end_date=#{end_date} ,category=#{category} WHERE campaignID=#{campaignID}")
    void updateCampaign(CampaignBean campaignBean);

    @Delete("DELETE FROM campaign WHERE campaignID = #{campaignID}")
    void deleteCampaign(@Param("campaignID") String campaignID);

    @Select("SELECT campaignID, cam_amount FROM donation")
    List<DonationBean> getAllDonationTotalAmount();

    //---------------------order---------------------
    @Select("SELECT * "
          + "FROM orders")
    List<OrdersBean> selectAllOrder();

    //----------------------temperature--------------------------
    @Select("SELECT * "
          + "FROM temperature")
    List<TemperatureBean> selectAllTemper();

    //----------------------seatemperature--------------------------
    @Select("SELECT * "
          + "FROM seaTemperature")
    List<SeaTemperatureBean> selectAllSeaTemper();

    //----------------------oceanofsurface--------------------------
    @Select("SELECT * "
          + "FROM oceanofsurface")
    List<OceanofSurfaceBean> selectAllOceanOfSurface();

    //----------------------rainfall--------------------------
    @Select("SELECT * "
          + "FROM rainfall")
    List<RainfallBean> selectAllRainfall();

    //-------------------adminMain-------------------
    @Select("SELECT COUNT(userID) FROM member")
    int countMember();

    @Select("SELECT COUNT(productID) FROM product")
    int countProduct();

    @Select("SELECT COUNT(donationID) FROM donation")
    int countDonation();

    @Select("SELECT COUNT(campaignID) FROM campaign")
    int countCampaign();

    @Select("SELECT m.userID, m.name, SUM(d.cam_amount) AS totalDonation "
          + "FROM member m JOIN donation d ON m.userID = d.userID "
          + "GROUP BY m.userID, m.name "
          + "ORDER BY totalDonation DESC FETCH FIRST 3 ROWS ONLY")
    List<UserBean> getTop3Donors();

    @Select("SELECT userID, name "
          + "FROM member  " )
    List<UserBean> getTop3DonorsASC();

    @Select("SELECT * FROM (SELECT * FROM content_notice ORDER BY create_date DESC) WHERE ROWNUM <= 3")
    List<ContentBean> getTop3BoardPosts();

    @Select("SELECT * FROM (SELECT * FROM campaign ORDER BY create_date DESC) WHERE ROWNUM <= 3")
    List<CampaignBean> getTop3Campaigns();

    @Select("SELECT userID, name, create_date FROM (SELECT * FROM member ORDER BY create_date DESC) WHERE ROWNUM <= 3")
    List<UserBean> getTop3RecentUsers();
    
    @Select("SELECT userID,cam_amount FROM (SELECT * FROM donation ORDER BY donation_date DESC) WHERE ROWNUM <= 3")
    List<DonationBean> getTop3Donation();
}
