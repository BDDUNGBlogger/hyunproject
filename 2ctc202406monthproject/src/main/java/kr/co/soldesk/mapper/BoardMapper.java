package kr.co.soldesk.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import kr.co.soldesk.beans.BoardCommentBean;
import kr.co.soldesk.beans.BoardInfoBean;
import kr.co.soldesk.beans.ContentBean;

public interface BoardMapper {
   @SelectKey(statement = "SELECT 'N' || TO_CHAR(notice_seq.NEXTVAL, 'FM00000') FROM dual", keyProperty = "noticeID", before = true, resultType = String.class)
   
//   @Select("SELECT COUNT(*) FROM member WHERE userID = #{writerID}")
//    int getContentByWriter(@Param("writerID") String writerID);
   
   // 글쓰기
   @Insert("insert into content_notice(noticeID, title, content_text, "
         + "img, comments, writerID, board_IDX, create_date, last_update) "
         + "values (#{noticeID, jdbcType=VARCHAR}, #{title}, #{content_text}, #{img, jdbcType=VARCHAR}, "
         + "#{comments, jdbcType=VARCHAR}, #{writerID}, #{board_IDX}, sysdate, sysdate)")
   void addContentInfo(ContentBean writeContentBean);
   
   @Select("select noticeID from content_notice where rowid = (select max(rowid) from content_notice where writerID = #{writerID})")
    String getLastInsertedNoticeID(String writerID);

   // 게시판 번호
   @Select("SELECT * FROM board_notice WHERE board_IDX = #{board_IDX}")
   BoardInfoBean getBoardInfo(int board_IDX);
   
   // 게시판 이름
   @Select("select board_info_Nm " + "from board_notice " + "where board_IDX = #{board_IDX}")
   String getBoardInfoName(int board_IDX);

   // 글목록
   @Select("select a1.noticeID, a1.title, a2.name as content_writer_name, "
         + "       to_char(a1.create_date, 'YYYY-MM-DD') as create_date, to_char(a1.last_update, 'YYYY-MM-DD') as last_update"
         + " from content_notice a1, member a2"
         + " where a1.writerID = a2.userID"
         + " and a1.board_IDX = #{board_IDX}"
         + " order by a1.noticeID desc")
   List<ContentBean> getContentList(int board_IDX, RowBounds rowBounds);

   // 상세정보
   @Select("select a2.name as content_writer_name,"
         + "       to_char(a1.create_date, 'YYYY-MM-DD') as create_date, to_char(a1.last_update, 'YYYY-MM-DD') as last_update,"
         + "       a1.title, a1.content_text, a1.img, a1.writerID, a1.comments"
         + "       from content_notice a1, member a2"
         + "       where a1.writerID = a2.userID"
         + "       and noticeID = #{noticeID}")
   ContentBean getContentInfo(String noticeID);

   // 수정하기
   @Update("UPDATE content_notice SET title = #{title}, content_text = #{content_text},"
         + " img = #{img, jdbcType=VARCHAR} WHERE noticeID = #{noticeID} AND (writerID = #{userID} OR #{roleCD} = 'M')")
   void modifyContentInfo(@Param("title") String title, @Param("content_text") String content_text, @Param("img") String img, @Param("noticeID") String noticeID, @Param("userID") String userID, @Param("roleCD") String roleCD);

   // 삭제하기
   @Delete("DELETE FROM content_notice WHERE noticeID = #{noticeID} AND (writerID = #{userID} OR #{roleCD} = 'M')")
   boolean deleteContentInfo(@Param("noticeID") String noticeID, @Param("userID") String userID, @Param("roleCD") String roleCD);
   
   //해당 게시판의 전체 글의 수 가져오기
   @Select("select count(*) from content_notice where board_IDX = #{board_IDX}")
   int getContentCnt(int board_IDX);
   
   //댓글
   @Update("update notice_comments set comment_text=#{comment_text} where cno=#{cno}")
   void modifycommentInfo(@Param("cno") int cno, @Param("comment_text") String comment_text);

   //글 번호에 따른 작성한 댓글 보기
//   @Select("SELECT nc.comment_id,\r\n"
//         + "       nc.com_content_idx,\r\n"
//         + "       nc.com_userID,\r\n"
//         + "       nc.comment_text,\r\n"
//         + "       nc.create_date,\r\n"
//         + "       cn.title,\r\n"
//         + "       cn.content_text\r\n"
//         + "FROM notice_comments nc\r\n"
//         + "JOIN content_notice cn\r\n"
//         + "ON nc.com_content_idx = cn.noticeID\r\n"
//         + "WHERE cn.noticeID = :noticeID\r\n"
//         + "ORDER BY nc.create_date ASC;")
//   List<E>
   
   @Insert("INSERT INTO notice_comments (comment_id, com_content_idx, com_userID, comment_text, create_date, cno) " +
            "VALUES (#{commentId}, #{com_content_idx}, #{com_userID}, #{comment_text}, sysdate, #{cno})")
    void addComment(BoardCommentBean comment);

    @Select("SELECT * FROM notice_comments, content_notice WHERE com_content_idx = #{noticeID}")
    List<BoardCommentBean> getComments(@Param("noticeID") String noticeID);

    @Delete("DELETE FROM notice_comments WHERE cno = #{cno}")
    void deleteComment(@Param("cno") int cno);
   
   
}
