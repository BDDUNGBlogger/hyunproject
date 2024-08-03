package kr.co.soldesk.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.CartBean;
import kr.co.soldesk.mapper.CartMapper;

@Repository
public class CartDao {
    
    @Autowired
    private CartMapper cartMapper ;
    
    public String getCartIDByUserIDAndProductID(@Param("userID") String userID) {
    	return cartMapper.getCartIDByUserIDAndProductID(userID);
    }

    
    public int checkCartIDExists(String userID , String productID) {
		return cartMapper.checkCartIDExists(userID,productID);
    }
    		
    public void addCart(CartBean cart) {
        cartMapper.addCart(cart);
    }
    
    public List<CartBean> getAllCartItems(String userID) {
        return cartMapper.getAllCartItems(userID);
    }
    
    
    public void updateCartQuantity(CartBean cart) {
    	cartMapper.updateCartQuantity(cart);
    }
    
    public void deleteCartItem(String userID,String productID) {
    	cartMapper.deleteCartItem(userID, productID);
    }
    
    public void updateCartItemQuantity(String userID, String productID, int quantity) {
        cartMapper.updateCartItemQuantity(userID, productID, quantity);
    } 
    
    public void addproduct(CartBean cart) {
    	cartMapper.addproduct(cart);
    }

}
