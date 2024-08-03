package kr.co.soldesk.service;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.BoardCommentBean;
import kr.co.soldesk.beans.BoardInfoBean;
import kr.co.soldesk.beans.ContentBean;
import kr.co.soldesk.beans.PageBean;
import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.dao.BoardDAO;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class BoardService {

	@Value("${path.upload}")
	private String path_upload;
	
	@Value("${page.listcnt}")
	private int page_listcnt;
	
	@Value("${page.paginationcnt}")
	private int page_paginationcnt;

	@Autowired
	private BoardDAO boardDao;

	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;

    
	@SuppressWarnings("unused")
	private String saveUploadFile(MultipartFile upload_img) {

		String img_name = System.currentTimeMillis() + "_"
				+ FilenameUtils.getBaseName(upload_img.getOriginalFilename()) + "."
				+ FilenameUtils.getExtension(upload_img.getOriginalFilename());

		try {// 경로와 파일명
			upload_img.transferTo(new File(path_upload + "/" + img_name));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return img_name;

	}// saveUploadFile

	public void addContentInfo(ContentBean writeContentBean) {

		MultipartFile upload_img = writeContentBean.getUpload_img();

        if (upload_img != null && !upload_img.isEmpty()) {
            String img_name = saveUploadFile(upload_img);
            System.out.println(img_name);
            writeContentBean.setImg(img_name); // 오라클에 파일 이름 저장
        }
        writeContentBean.setWriterID(loginUserBean.getUserID());

        boardDao.addContentInfo(writeContentBean);

        String noticeID = boardDao.getLastInsertedNoticeID(writeContentBean.getWriterID());
		writeContentBean.setNoticeID(noticeID);
        
		System.out.println("작성 후 noticeID: "+noticeID);
    }

	public String getBoardInfoName(int board_IDX) {
		return boardDao.getBoardInfoName(board_IDX);
	}

	public List<ContentBean> getContentList(int board_IDX, int page) {
//		DB는 1페이지는 0 2페이지는 10 3페이지는 20 ...
		
		int start=(page-1)*page_listcnt;
		RowBounds rowBounds=new RowBounds(start, page_listcnt);
		
		return boardDao.getContentList(board_IDX, rowBounds);
	}
	
	public ContentBean getContentInfo(String noticeID) {
		return boardDao.getContentInfo(noticeID);
	}
	
	public void modifyContentInfo(ContentBean modifyContentBean, String userID, String roleCD) {
		
		MultipartFile upload_img=modifyContentBean.getUpload_img();
		
		if (upload_img.getSize() > 0) {
			String img_name = saveUploadFile(upload_img);
			modifyContentBean.setImg(img_name); // 오라클에 파일 이름 저장
		}
		
		modifyContentBean.setWriterID(loginUserBean.getUserID());
		
		boardDao.modifyContentInfo(modifyContentBean.getTitle(), modifyContentBean.getContent_text(), modifyContentBean.getImg(), modifyContentBean.getNoticeID(), userID, roleCD);
	    
	}
	
	public boolean deleteContentInfo(String noticeID, String userID, String roleCD, int board_IDX) {
		
		ContentBean tempContentBean = boardDao.getContentInfo(noticeID);
		
		if(tempContentBean != null && (tempContentBean.getWriterID().equals(userID) || "M".equals(roleCD))) {
			boardDao.deleteContentInfo(noticeID, userID, roleCD);
        } else {
            throw new SecurityException("작성자 또는 마스터 권한이 없습니다.");
        }
		
		return boardDao.deleteContentInfo(noticeID, userID, roleCD);
	}
	
	public PageBean getContentCnt(int board_IDX, int curretPage){
		int content_cnt=boardDao.getContentCnt(board_IDX);
		
		PageBean pageBean = new PageBean(content_cnt, curretPage, page_listcnt, page_paginationcnt);
		
		return pageBean;
		
		
	}

	public BoardInfoBean getBoardInfo(int board_IDX) {
		return boardDao.getBoardInfo(board_IDX);
	}

}
