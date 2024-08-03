package kr.co.soldesk.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.OrdersBean;
import kr.co.soldesk.mapper.OrdersMapper;

@Repository
public class OrdersDao { 
	
	@Autowired
	private OrdersMapper ordersMapper;
	
	public List<OrdersBean> getAllorders(String userID) {
		return ordersMapper.getAllorders(userID);
		
	}
	
	public void addOrdersInfo(OrdersBean addordersInfo) {
		ordersMapper.addOrdersInfo(addordersInfo);
	}
	
	//변경된 주소 정보 업데이트
	public void updateOrdersInfo(OrdersBean updateordersInfo) {
		ordersMapper.updateOrdersInfo(updateordersInfo);
	}

}
