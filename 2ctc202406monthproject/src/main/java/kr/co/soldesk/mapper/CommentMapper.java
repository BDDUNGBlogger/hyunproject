package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.BoardCommentBean;

public interface CommentMapper {
	
	@Insert("INSERT INTO notice_comments (comment_id, com_content_idx, com_userID, comment_text, create_date) "
			+ "VALUES(#{comment_id}, #{com_content_idx}, #{com_userID}, #{comment_text}, #{create_date})")
	void insertComment(BoardCommentBean insertcomment);

	@Select("SELECT nc.comment_id, nc.com_userID, nc.comment_text, nc.com_content_idx, "
            + "to_char(nc.create_date, 'YYYY-MM-DD') as createDate, "
            + "cn.title as noticeTitle FROM notice_comments nc "
            + "JOIN content_notice cn ON nc.com_content_idx = cn.noticeID "
            + "WHERE nc.com_content_idx = #{com_content_idx} "
            + "ORDER BY nc.create_date DESC")
	List<BoardCommentBean> getCommentsByNoticeID(String com_content_idx);
	
	@Select("SELECT * FROM notice_comments where comment_id = #{comment_id}")
	List<BoardCommentBean> getAllComments();
	
	@Delete("DELETE FROM notice_comments WHERE comment_id = #{comment_id} and (com_userID = #{userID} OR #{roleCD} = 'M')")
	boolean deleteComment(@Param("comment_id") String comment_id, @Param("userID") String userID, @Param("roleCD") String roleCD);
	
	@Update("UPDATE notice_comments SET comment_text = #{comment_text}, create_date = CURRENT_TIMESTAMP WHERE comment_id = #{comment_id}")
    void updateComment(BoardCommentBean comment);

}
