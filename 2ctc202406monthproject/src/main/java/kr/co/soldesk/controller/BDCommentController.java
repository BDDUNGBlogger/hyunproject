package kr.co.soldesk.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soldesk.beans.BoardCommentBean;
import kr.co.soldesk.beans.BoardInfoBean;
import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.service.BoardService;
import kr.co.soldesk.service.CommentService;

@Controller
@RequestMapping("/comments")
public class BDCommentController {

	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;
	
    @Autowired
    private CommentService commentService;

    @PostMapping(value = "/add", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> addComment(@Valid @RequestParam String comment_text, @RequestParam String com_content_idx, HttpSession session) {
    	
    	try {
    		UserBean loginUser = (UserBean) session.getAttribute("loginUserBean");
    		if (loginUser == null || loginUser.getUserID() == null) {
    			return ResponseEntity.status(400).body("로그인이 필요합니다.");
    		}
    		
    		String com_userID = loginUser.getUserID();

//    		System.out.println("글 추가 시 comment_text: " + comment_text);
//            System.out.println("글 추가 시 com_content_idx: " + com_content_idx);
//            System.out.println("글 추가 시 com_userID: " + com_userID);
    		
            System.out.println();
    		
    		BoardCommentBean insertcomment = new BoardCommentBean();
    		insertcomment.setCom_content_idx(com_content_idx);
    		insertcomment.setCom_userID(com_userID);
    		insertcomment.setComment_text(comment_text);
    		insertcomment.setCreate_date(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));
    		
    		commentService.insertComment(insertcomment);
    		List<BoardCommentBean> comments = commentService.getCommentsByNoticeID(com_content_idx);
    		return ResponseEntity.ok(comments);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(500).body("서버 에러가 발생했습니다.");
		}
    }

    @PostMapping(value = "/delete", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> deleteComment(@RequestParam String comment_id, @RequestParam String com_content_idx) {
    	
    	try {
    		
    		List<BoardCommentBean> deletecomment = commentService.getCommentsByNoticeID(com_content_idx);
    		
    		boolean isDelected = commentService.deleteComment(comment_id, loginUserBean.getUserID(), loginUserBean.getRolecd());
    		
    		if(!isDelected) {
//    			model.addAttribute("errorMessage", "삭제 권한이 없거나 삭제 중 오류가 발생했습니다.");
//                return "board/not_writer";
    		}
    		return ResponseEntity.ok(deletecomment);
    		
		} catch (Exception e) {
			e.printStackTrace();
            return ResponseEntity.status(500).body("서버 에러가 발생했습니다.");
		}
    	
    }

    @GetMapping(value = "/list", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> getComments(@RequestParam String com_content_idx) {
    	
    	try {
    		List<BoardCommentBean> commentlist = commentService.getCommentsByNoticeID(com_content_idx);
            return ResponseEntity.ok(commentlist);
		} catch (Exception e) {
			e.printStackTrace();
            return ResponseEntity.status(500).body("서버 에러가 발생했습니다.");
		}
    }

    @GetMapping(value = "/all", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> getAllComments() {
        try {
            List<BoardCommentBean> allcomments = commentService.getAllComments();
            return ResponseEntity.ok(allcomments);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("서버 에러가 발생했습니다.");
        }
    }
    
    @PostMapping(value = "/update", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> updateComment(@Valid @RequestParam String comment_id, @RequestParam String comment_text, @RequestParam String com_content_idx) {
        try {
            BoardCommentBean comment = new BoardCommentBean();
            comment.setComment_id(comment_id);
            comment.setComment_text(comment_text);

            commentService.updateComment(comment);
            List<BoardCommentBean> comments = commentService.getCommentsByNoticeID(com_content_idx);
            return ResponseEntity.ok(comments);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("서버 에러가 발생했습니다.");
        }
    }
    
}