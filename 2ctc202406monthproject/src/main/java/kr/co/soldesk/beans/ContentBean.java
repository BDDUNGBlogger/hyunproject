package kr.co.soldesk.beans;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

public class ContentBean {

	private String noticeID;
	private int board_IDX;
	
	// NOT NULL과 같음
	@NotBlank
	private String title;
	
	@NotBlank
	private String content_text;

	private String create_date;
	private String last_update;
	private String img; // 첨부파일 이름만 데이터베이스(오라클)에 저장
	private String comments;
	private String writerID;

	private String content_writer_name;

	private MultipartFile upload_img; // 브라우저가 보낸 파일 데이터

	public String getNoticeID() {
		return noticeID;
	}

	public void setNoticeID(String noticeID) {
		this.noticeID = noticeID;
	}

	public int getBoard_IDX() {
		return board_IDX;
	}

	public void setBoard_IDX(int board_IDX) {
		this.board_IDX = board_IDX;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent_text() {
		return content_text;
	}

	public void setContent_text(String content_text) {
		this.content_text = content_text;
	}

	public String getCreate_date() {
		return create_date;
	}

	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}

	public String getLast_update() {
		return last_update;
	}

	public void setLast_update(String last_update) {
		this.last_update = last_update;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getWriterID() {
		return writerID;
	}

	public void setWriterID(String writerID) {
		this.writerID = writerID;
	}

	public String getContent_writer_name() {
		return content_writer_name;
	}

	public void setContent_writer_name(String content_writer_name) {
		this.content_writer_name = content_writer_name;
	}

	public MultipartFile getUpload_img() {
		return upload_img;
	}

	public void setUpload_img(MultipartFile upload_img) {
		this.upload_img = upload_img;
	}

	
	
	

}
