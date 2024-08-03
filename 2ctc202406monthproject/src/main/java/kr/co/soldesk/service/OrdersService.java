package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kr.co.soldesk.beans.OrdersBean;
import kr.co.soldesk.dao.OrdersDao;

@Service
public class OrdersService {

	@Autowired  
	private OrdersDao ordersDao;  

	public List<OrdersBean> getAllorders(String userID) {
		return ordersDao.getAllorders(userID);

	}

	// 구매내역 테이블에 정보 넣기
	public void addOrdersInfo(OrdersBean addordersInfo) {
	
			addordersInfo.setOrderID(generateNewOrderID());
			ordersDao.addOrdersInfo(addordersInfo);
			
			System.out.println("addOrdersInfo : "+addordersInfo.getOrderID());
	}

	// 배송지 변경 업데이트
	public void updateOrdersInfo(OrdersBean updateordersInfo) {		
		ordersDao.updateOrdersInfo(updateordersInfo);
	}

	private String generateNewOrderID() {
		long timeMillis = System.currentTimeMillis();
	    String uniquePart = Long.toString(timeMillis).substring(5); // 마지막 9자리 사용
	    return "O" + uniquePart;
	}
		

}
