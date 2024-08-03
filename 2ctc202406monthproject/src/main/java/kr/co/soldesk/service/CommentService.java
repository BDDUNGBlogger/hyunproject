package kr.co.soldesk.service;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.BoardCommentBean;
import kr.co.soldesk.dao.CommentDAO;

@Service
public class CommentService {
	
	@Autowired
	private CommentDAO commentDAO;
	
	public void insertComment(BoardCommentBean comment) {
		commentDAO.insertComment(comment);
	}

	public List<BoardCommentBean> getAllComments(){
		return commentDAO.getAllComments();
	}
	
	public List<BoardCommentBean> getCommentsByNoticeID(String com_content_idx){
		return commentDAO.getCommentsByNoticeID(com_content_idx);
	}
	
	public boolean deleteComment(String comment_id, String userID, String roleCD) {
		return commentDAO.deleteComment(comment_id, userID, roleCD);
	}
	
	public void updateComment(BoardCommentBean comment) {
		commentDAO.updateComment(comment);
	}
	
}
