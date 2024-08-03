package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.ProductBean;

public interface ProductMapper {    
	
	//상품찾기
	@Select("select productID ,product_name ,price "
			+ "from product where productid=#{productid}")
	String getProductInfo(String Product);
	
	//상품추가
	@Insert("insert into product(productID , product_name, price ,quantity ,inventory,status,create_date,last_update,product_img) "
			+ "values(#{productID} , #{product_name} , #{price} , #{quantity} , #{inventory} , #{status} , sysdate , sysdate , jdbcType=VARCHAR)")
	void addProduct(ProductBean Addproduct);
	
	//상품목록 가져오기
	@Select("select * from product")
	List<ProductBean> getAllProducts();
	
	//재고량 변경
	@Update("UPDATE product SET inventory = inventory - #{quantity} WHERE productID = #{productID}")
	void updateInventory(@Param("productID") String productID, @Param("quantity") int quantity);
	
}
