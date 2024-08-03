package kr.co.soldesk.beans;

public class BoardCommentBean {

	private String notice_id;
	private String comment_id;
    private String com_content_idx;
    private String com_userID;
    private String comment_text;
    private String create_date;
    
	public String getNotice_id() {
		return notice_id;
	}
	public void setNotice_id(String notice_id) {
		this.notice_id = notice_id;
	}
	public String getComment_id() {
		return comment_id;
	}
	public void setComment_id(String comment_id) {
		this.comment_id = comment_id;
	}
	public String getCom_content_idx() {
		return com_content_idx;
	}
	public void setCom_content_idx(String com_content_idx) {
		this.com_content_idx = com_content_idx;
	}
	public String getCom_userID() {
		return com_userID;
	}
	public void setCom_userID(String com_userID) {
		this.com_userID = com_userID;
	}
	public String getComment_text() {
		return comment_text;
	}
	public void setComment_text(String comment_text) {
		this.comment_text = comment_text;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
    
	
	
}
