package kr.co.soldesk.beans;

import java.sql.Date;
import java.sql.Timestamp;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

public class CampaignBean {
	
	private String campaignID; //캠페인 ID, 기본 키
	@NotBlank //DB에서 not null과 같음
	private String cam_title; //캠페인 제목
	@NotBlank
	private String cam_host; //캠페인 주최
	@NotBlank
	private String cam_intro; //캠페인 설명 (대량의 텍스트 데이터를 저장할 수 있도록 CLOB 사용)
	private String cam_news = "모금소식단체의 모금사업과 관련된 소식을 들려드립니다."; //캠페인 설명 (대량의 텍스트 데이터를 저장할 수 있도록 CLOB 사용)
	private double goal_amount; //목표 금액 (고정 소수점을 사용하여 정밀도 보장)
	private double current_amount; //현재 모금된 금액, 기본값은 0
	private Timestamp create_date; //작성 날짜, 기본값은 현재 시간
	private Timestamp last_update; //마지막 업데이트 날짜, 기본값은 현재 시간
	
	
	private MultipartFile upload_file;//브라우저에 보낸 파일 파일 DB로 넘어가지 않음.
    
	private String cam_img; //캠페인 이미지 경로
	private Date start_date; //시작 날짜
	private Date end_date; // 종료 날짜
    private String category; //환경, 동물 카테고리, '환경' 또는 '동물'만 허용
    private int donor_count; //직접 기부한 사람 수, 기본값은 0
    
    
    public CampaignBean() {
        this.cam_news = "모금소식단체의 모금사업과 관련된 소식을 들려드립니다.";
    }
    
	public String getCampaignID() {
		return campaignID;
	}
	public void setCampaignID(String campaignID) {
		this.campaignID = campaignID;
	}
	public String getCam_title() {
		return cam_title;
	}
	public void setCam_title(String cam_title) {
		this.cam_title = cam_title;
	}
	public String getCam_host() {
		return cam_host;
	}
	public void setCam_host(String cam_host) {
		this.cam_host = cam_host;
	}
	public String getCam_intro() {
		return cam_intro;
	}
	public void setCam_intro(String cam_intro) {
		this.cam_intro = cam_intro;
	}
	
	public String getCam_news() {
		return cam_news;
	}
	public void setCam_news(String cam_news) {
		this.cam_news = cam_news;
	}
	public double getGoal_amount() {
		return goal_amount;
	}
	public void setGoal_amount(double goal_amount) {
		this.goal_amount = goal_amount;
	}
	public double getCurrent_amount() {
		return current_amount;
	}
	public void setCurrent_amount(double current_amount) {
		this.current_amount = current_amount;
	}
	public Timestamp getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}
	public Timestamp getLast_update() {
		return last_update;
	}
	public void setLast_update(Timestamp last_update) {
		this.last_update = last_update;
	}
	
	public MultipartFile getUpload_file() {
		return upload_file;
	}
	public void setUpload_file(MultipartFile upload_file) {
		this.upload_file = upload_file;
	}
	
	public String  getCam_img() {
		return cam_img;
	}
	public void setCam_img(String cam_img) {
		this.cam_img = cam_img;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getDonor_count() {
		return donor_count;
	}
	public void setDonor_count(int donor_count) {
		this.donor_count = donor_count;
	}
	

    
}
