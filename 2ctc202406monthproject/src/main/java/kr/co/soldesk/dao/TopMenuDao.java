package kr.co.soldesk.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.BoardInfoBean;
import kr.co.soldesk.mapper.TopMenuMapper;

@Repository
public class TopMenuDao {
	
	@Autowired
	private TopMenuMapper topMenuMapper;
	
	public  List<BoardInfoBean> getTopMenuList(){
		List<BoardInfoBean> topMenuList=topMenuMapper.getTopMenuList();
		return topMenuList; //select의 결과값이 넘어옴
	}
	
	
}