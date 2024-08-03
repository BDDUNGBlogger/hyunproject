package kr.co.soldesk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.soldesk.beans.CartBean;

public interface CartMapper {
    
    // 사용자와 제품에 대해 카트 항목이 존재하는지 확인
    @Select("select count(*) from cart where userID=#{userID} and productID=#{productID} ")
    int checkCartIDExists(@Param("userID") String userID, @Param("productID") String productID);
    
    // 사용자와 제품에 대해 카트 ID를 가져옴 
    @Select("select cartID from cart where userID=#{userID} and Rownum= 1 ")
    String getCartIDByUserIDAndProductID(@Param("userID") String userID);


    // 상품 수량 업데이트 detail창에서의 변경
    @Update("update cart set quantity = quantity + #{quantity} where userID = #{userID} and productID = #{productID}")
    void updateCartQuantity(CartBean cart);
    
    //상품 추가
    @Update("update cart set productID=#{productID}, quantity=#{quantity} where cartID=#{cartID}")
    void addproduct(CartBean cart);
    
    // 카트에 상품 추가
    @Insert("insert into cart (cartID ,userID, productID, quantity) values (#{cartID,jdbcType=VARCHAR},#{userID}, #{productID}, #{quantity})")
    void addCart(CartBean cart);
    
    
    // 카트 항목 조회
    @Select("select c.cartID, c.userID, c.productID, c.quantity, p.color, p.product_name, p.price, p.product_img " +
            "from cart c, product p " +
            "where c.productID = p.productID and c.userID = #{userID}")
    List<CartBean> getAllCartItems(@Param("userID") String userID);

    // 카트 항목 삭제
    @Delete("DELETE FROM cart WHERE userID = #{userID} AND productID = #{productID}")
    void deleteCartItem(@Param("userID") String userID, @Param("productID") String productID);
    
    //상품 수량 직접 설정 업데이트
    @Update("update cart set quantity = #{quantity} where userID = #{userID} and productID = #{productID}")
    void updateCartItemQuantity(@Param("userID") String userID, @Param("productID") String productID, @Param("quantity") int quantity);

}
