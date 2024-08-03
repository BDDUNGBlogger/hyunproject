package kr.co.soldesk.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.BoardCommentBean;
import kr.co.soldesk.mapper.CommentMapper;

@Repository
public class CommentDAO {
	
	@Autowired
	private CommentMapper commentMapper;
	
	public void insertComment(BoardCommentBean comment) {
		commentMapper.insertComment(comment);
	}

	public List<BoardCommentBean> getAllComments(){
		return commentMapper.getAllComments();
	}
	
	public List<BoardCommentBean> getCommentsByNoticeID(String com_content_idx){
		return commentMapper.getCommentsByNoticeID(com_content_idx);
	}


	public boolean deleteComment(String comment_id, String userID, String roleCD) {
		return commentMapper.deleteComment(comment_id, userID, roleCD);
	}
	
	public void updateComment(BoardCommentBean comment) {
		commentMapper.updateComment(comment);
	}
	
}
