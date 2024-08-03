package kr.co.soldesk.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.CartBean;
import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.dao.CartDao;

@Service
public class CartService {

    @Autowired
    private CartDao cartDao;

    @Resource(name="loginUserBean")
    private UserBean loginUserBean;

    public boolean checkCartIDExists(String userID, String productID) {
    	
    	 return cartDao.checkCartIDExists(userID, productID) >0;
    }

    //상품 추가시 올라가느것
    public void updateCartQuantity(CartBean cart) {
        cartDao.updateCartQuantity(cart);
    }

    //같은 상품이면 갯수만 올라감


    public void addOrUpdateCart(CartBean cart) {
        String cartID = cartDao.getCartIDByUserIDAndProductID(cart.getUserID());
        if (cartID == null) {
            cartID = generateNewCartID();
            cart.setCartID(cartID);
            cartDao.addCart(cart);
        } else {
            cart.setCartID(cartID);
            if (cartDao.checkCartIDExists(cart.getUserID(), cart.getProductID()) > 0) {
                cartDao.updateCartQuantity(cart);
            } 
        }
    }

    private String generateNewCartID() {
        return "C" + System.currentTimeMillis();
    }


    public void addOrUpdateProductInCart(CartBean cart) {
        if (checkCartIDExists(cart.getUserID(), cart.getProductID())) {
            updateCartQuantity(cart);
        } else {
        	addCart(cart);
        }
    }
    

    

    public void addCart(CartBean cart) {
        cartDao.addCart(cart);
    }

    public List<CartBean> getAllCartItems(String userID) {
        return cartDao.getAllCartItems(userID);
    }

    public void deleteCartItem(String userID, String productID) {
        cartDao.deleteCartItem(userID, productID);
    }
    
    public void updateCartItemQuantity(String userID, String productID, int quantity) {
        cartDao.updateCartItemQuantity(userID, productID, quantity);
    }
}
