package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kr.co.soldesk.beans.BoardInfoBean;

public interface TopMenuMapper {
	
	//select * from 이렇게 입력해도됨
	@Select("select board_IDX, board_info_Nm " +
			"from board_notice " + 
			"order by board_IDX")
	List<BoardInfoBean> getTopMenuList();
	
	

}