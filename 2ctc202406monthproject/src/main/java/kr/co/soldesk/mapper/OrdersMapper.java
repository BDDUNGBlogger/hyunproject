package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.OrdersBean;



public interface OrdersMapper { 
	
	//구매내역 가져오기
	@Select("select p.product_name, o.color, o.quantity, o.price, p.product_img "
			+ "from orders o, product p , member m "
			+ "where o.productid = p.productid and o.userid = m.userID "
			+ "and m.userID = #{userID}")
	List<OrdersBean> getAllorders(@Param("userID") String userID);
	
	
	//구매내역 정보 넣기
	@Insert("INSERT INTO orders (orderID, userID, productID, username, phone, post_num, address, color, quantity, price, payment_method) "
			+ "VALUES (#{orderID}, #{userID}, #{productID}, #{username}, #{phone}, #{post_num}, #{address}, #{color}, #{quantity}, #{price}, #{payment_method})")
	void addOrdersInfo(OrdersBean addordersInfo);
	
	//변경된 주소 정보 업데이트
	@Update("update orders set username = #{username}, phone = #{phone}, post_num = #{post_num}, address = #{address} "
			+ "where orderID = #{orderID}")
	void updateOrdersInfo(OrdersBean updateordersInfo);
 
}
