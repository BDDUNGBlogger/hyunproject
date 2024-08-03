package kr.co.soldesk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.soldesk.beans.BoardCommentBean;
import kr.co.soldesk.beans.ContentBean;
import kr.co.soldesk.beans.PageBean;
import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.service.BoardService;
import kr.co.soldesk.service.CommentService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CommentService commentService;
	
	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;

	@GetMapping("/main")
	public String main(@RequestParam("board_IDX") int board_IDX,
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		try {
            model.addAttribute("board_IDX", board_IDX);

            String boardInfoName = boardService.getBoardInfoName(board_IDX);
            model.addAttribute("boardInfoName", boardInfoName);

            List<ContentBean> contentList = boardService.getContentList(board_IDX, page);
            model.addAttribute("contentList", contentList);

            PageBean pageBean = boardService.getContentCnt(board_IDX, page);

            model.addAttribute("pageBean", pageBean);
            model.addAttribute("page", page);

            return "board/main";
        } catch (SecurityException e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "board/access_denied";
        }
	}

	@GetMapping("/read")
	public String read(@RequestParam("board_IDX") int board_IDX, @RequestParam("noticeID") String noticeID,
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
//		System.out.println("BoardController noticeID?" + noticeID);
		ContentBean readContentBean = boardService.getContentInfo(noticeID);
		
//		System.out.println("readContentBean noticeID?" + readContentBean.getNoticeID());
		
		String introWithBreaks = readContentBean.getTitle().replaceAll("\n", "<br>");
        String newsWithBreaks = readContentBean.getContent_text().replaceAll("\n", "<br>");
        
        model.addAttribute("introWithBreaks", introWithBreaks);
        model.addAttribute("newsWithBreaks", newsWithBreaks);
		
		List<BoardCommentBean> commentlist = commentService.getCommentsByNoticeID(noticeID);
		model.addAttribute("commentlist", commentlist);

		model.addAttribute("board_IDX", board_IDX);
		model.addAttribute("noticeID", noticeID);
		
		model.addAttribute("loginUserBean", loginUserBean);
		model.addAttribute("readContentBean", readContentBean);
		model.addAttribute("page", page);

		return "board/read";
	}

	@GetMapping("/write")
	public String write(@ModelAttribute("writeContentBean") ContentBean writeContentBean,
			@RequestParam("board_IDX") int board_IDX) {
		
		String roleCD = loginUserBean.getRolecd();
		System.out.println("write roleCD: "+roleCD);
		if("U".equals(roleCD)) {
			if(writeContentBean.getBoard_IDX() != 2) {
				return "board/not_writer";
			}
		}
		
		System.out.println("writeContentBean.getBoard_IDX()" + writeContentBean.getBoard_IDX());

		writeContentBean.setBoard_IDX(board_IDX);

		return "board/write";
	}

	@PostMapping("/write_pro")
	public String write_pro(@Valid @ModelAttribute("writeContentBean") ContentBean writeContentBean, BindingResult result, Model model) {

		if (result.hasErrors()) {
			return "board/write";
		}

		String roleCD = loginUserBean.getRolecd();
		
		if("U".equals(roleCD)) {
			if(writeContentBean.getBoard_IDX() != 2) {
				return "board/not_writer";
			}
		}
		
            boardService.addContentInfo(writeContentBean);
            String noticeID = writeContentBean.getNoticeID();
            int board_IDX = writeContentBean.getBoard_IDX();
            model.addAttribute("noticeID", noticeID);
            model.addAttribute("board_IDX", board_IDX);

            return "board/write_success";
	}

	@GetMapping("/not_writer")
	public String not_writer() {
		return "board/not_writer";
	}

	@GetMapping("/modify")
	public String modify(@RequestParam("board_IDX") int board_IDX, @RequestParam("noticeID") String noticeID,
			@ModelAttribute("modifyContentBean") ContentBean modifyContentBean,
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		ContentBean tempContentBean = boardService.getContentInfo(noticeID);

        // 권한 확인: 작성자이거나 마스터 계정인 경우
		if (!loginUserBean.getUserID().equals(tempContentBean.getWriterID()) && 
	            (loginUserBean.getRolecd() == null || !"M".equals(loginUserBean.getRolecd()))) {
	            return "board/not_writer";
	        }
		// 게시글 하나의 상세 정보 가져오기

		modifyContentBean.setContent_writer_name(tempContentBean.getContent_writer_name());
		modifyContentBean.setCreate_date(tempContentBean.getCreate_date());
		modifyContentBean.setLast_update(tempContentBean.getLast_update());
		modifyContentBean.setTitle(tempContentBean.getTitle());
		modifyContentBean.setContent_text(tempContentBean.getContent_text());
		modifyContentBean.setImg(tempContentBean.getImg());
		modifyContentBean.setWriterID(tempContentBean.getWriterID());
		modifyContentBean.setBoard_IDX(board_IDX);
		modifyContentBean.setNoticeID(noticeID);

		model.addAttribute("board_IDX", board_IDX);
		model.addAttribute("noticeID", noticeID);
		model.addAttribute("page", page);

		return "board/modify";
	}

	@PostMapping("/modify_pro")
	public String modify_pro(@Valid @ModelAttribute("modifyContentBean") ContentBean modifyContentBean,
			@RequestParam("page") int page, BindingResult result, Model model) {

		if (result.hasErrors()) {
			return "board/modify";
		}

		boardService.modifyContentInfo(modifyContentBean, loginUserBean.getUserID(), loginUserBean.getRolecd());
		model.addAttribute("page", page);

		return "board/modify_success";
	}

	@GetMapping("/delete")
	public String delete(@RequestParam("board_IDX") int board_IDX, @RequestParam("noticeID") String noticeID,
			String userID, String roleCD, Model model) {
		
		// 디버깅 로그 추가
        System.out.println("Attempting to delete. Board_IDX: " + board_IDX + ", NoticeID: " + noticeID);
        System.out.println("UserID: " + loginUserBean.getUserID() + ", RoleCD: " + loginUserBean.getRolecd());

		boolean isDelected = boardService.deleteContentInfo(noticeID, loginUserBean.getUserID(), loginUserBean.getRolecd(), board_IDX);
		
		if(!isDelected) {
//			model.addAttribute("errorMessage", "삭제 권한이 없거나 삭제 중 오류가 발생했습니다.");
//            return "board/not_writer";
		}
		
		model.addAttribute("board_IDX", board_IDX);

		return "board/delete";
	}
	
}











