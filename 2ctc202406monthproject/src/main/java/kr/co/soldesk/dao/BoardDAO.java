package kr.co.soldesk.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.BoardCommentBean;
import kr.co.soldesk.beans.BoardInfoBean;
import kr.co.soldesk.beans.ContentBean;
import kr.co.soldesk.mapper.BoardMapper;

@Repository
public class BoardDAO {
	
	@Autowired
	private BoardMapper boardMapper;

//	public int getContentByWriter(String writerID) {
//        return boardMapper.getContentByWriter(writerID);
//    }

	public BoardInfoBean getBoardInfo(int board_IDX) {
		return boardMapper.getBoardInfo(board_IDX);
	}

	public void addContentInfo(ContentBean writeContentBean) {
		boardMapper.addContentInfo(writeContentBean);
	}

	public String getBoardInfoName(int board_IDX) {
		return boardMapper.getBoardInfoName(board_IDX);
	}

	public List<ContentBean> getContentList(int board_IDX, RowBounds rowBounds) {

		return boardMapper.getContentList(board_IDX, rowBounds);
	}

	public ContentBean getContentInfo(String noticeID) {
		return boardMapper.getContentInfo(noticeID);
	}

	public void modifyContentInfo(String title, String content_text, String img, String noticeID, String userID,
			String roleCD) {
		boardMapper.modifyContentInfo(title, content_text, img, noticeID, userID, roleCD);
	}

	public boolean deleteContentInfo(String noticeID, String userID, String roleCD) {
		return boardMapper.deleteContentInfo(noticeID, userID, roleCD);
	}

	public int getContentCnt(int board_IDX) {
		return boardMapper.getContentCnt(board_IDX);
	}

	public String getLastInsertedNoticeID(String writerID) {
		return boardMapper.getLastInsertedNoticeID(writerID);
	}
}
