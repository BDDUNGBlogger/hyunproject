package kr.co.soldesk.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.soldesk.beans.CartBean;
import kr.co.soldesk.beans.OrdersBean;
import kr.co.soldesk.beans.ProductBean;
import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.service.CartService;
import kr.co.soldesk.service.OrdersService;
import kr.co.soldesk.service.ProductService;
import kr.co.soldesk.service.UserService;

@Controller
@RequestMapping("/product") 
public class ProductController {

   @Autowired
   private OrdersService ordersService; 

   @Autowired
   private ProductService productService;

   @Resource(name = "loginUserBean")
   private UserBean loginUserBean;

   @Autowired
   private UserService userService;

   @Autowired
   private CartService cartService;

   @GetMapping("/productList")
   public String productList(Model model) {
      List<ProductBean> products = productService.getAllProducts();
      model.addAttribute("products", products);
      return "product/productList";
   }

   /* @PostMapping("/productdetail") */
   @RequestMapping(value = "/productdetail", method = {RequestMethod.GET, RequestMethod.POST})
   public String productdetail(@RequestParam("product_name") String product_name, 
                        @RequestParam("productID") String productID,
                        @RequestParam("price") int price, 
                        @RequestParam("product_img") String product_img, 
                        Model model) {
      model.addAttribute("product_name", product_name);
      model.addAttribute("loginUserBean", loginUserBean);
      model.addAttribute("product_img", product_img);
      model.addAttribute("productID", productID);
      model.addAttribute("price", price);
      return "product/productdetail";
   }
   
   /* @PostMapping("/productbuy") */
   @RequestMapping(value = "/productbuy", method = {RequestMethod.GET, RequestMethod.POST})
   public String productbuy(
                      @RequestParam("product_name") String product_name, 
                      @RequestParam("productID") String productID,
                      @RequestParam("price") Integer price, 
                      @RequestParam("product_img") String product_img,
                      @RequestParam("quantity") Integer quantity, 
                      @RequestParam("color") String color,  
                      Model model) {

      if (!loginUserBean.isUserLogin()) {
         return "redirect:/user/not_login";
      }

      System.out.println("product_name:" + product_name);
      System.out.println("productID: " + productID);
      System.out.println("product_img: " + product_img);
      System.out.println("price: " + price);
      System.out.println("quantity: " + quantity);
      System.out.println("color: " + color);

      UserBean user = userService.getFindUser();

      int totalprice = 0;
      totalprice = price * quantity;

      model.addAttribute("name", user.getName());
      model.addAttribute("address", user.getAddress());
      model.addAttribute("phone", user.getPhone());
      model.addAttribute("post_num", user.getPost_num());
      model.addAttribute("product_name", product_name);
      model.addAttribute("loginUserBean", loginUserBean);
      model.addAttribute("productID", productID);
      model.addAttribute("price", price);
      model.addAttribute("product_img", product_img);
      model.addAttribute("quantity", quantity);
      model.addAttribute("color", color);
      model.addAttribute("totalprice", totalprice);
            

      return "product/productbuy";
   }

   @GetMapping("/productmodify")
   public String productmodify() {
      return "product/productmodify";
   }

   @PostMapping("/product_payment")
   public String product_payment(@ModelAttribute("addordersInfo")OrdersBean addordersInfo,
                          @RequestParam("orderID") String orderID,
                          @RequestParam("productID") String productID,
                          @RequestParam("userID") String userID, 
                          @RequestParam("username") String username,
                          @RequestParam("phone") String phone, 
                          @RequestParam("address") String address,
                          @RequestParam("post_num") String post_num, 
                          @RequestParam("quantity") int quantity,
                          @RequestParam("price") int price,  
                          @RequestParam("product_name") String product_name,  
                          @RequestParam("product_img") String product_img,  
                          Model model) {
      if (!loginUserBean.isUserLogin()) {
         return "redirect:/user/not_login";
      }
      
      UserBean user =userService.getFindUser();
      int totalprice = price * quantity;
      
      addordersInfo.setUserID(loginUserBean.getUserID());
      
      model.addAttribute("loginUserBean", loginUserBean);
      model.addAttribute("orderID", orderID);
      model.addAttribute("productID", productID);
      model.addAttribute("userID", user.getUserID());
      model.addAttribute("username", user.getName());
      model.addAttribute("phone", user.getPhone());
      model.addAttribute("address", user.getAddress());
      model.addAttribute("post_num", user.getPost_num());
      model.addAttribute("quantity", quantity);
      model.addAttribute("price", price);
      model.addAttribute("product_name", product_name);
      model.addAttribute("product_img", product_img);
      model.addAttribute("totalprice", totalprice);
      
      addordersInfo.setOrderID(orderID);
      addordersInfo.setProductID(productID);
      addordersInfo.setUserID(user.getUserID());
      addordersInfo.setUsername(user.getName());
      addordersInfo.setPhone(user.getPhone());
      addordersInfo.setAddress(user.getAddress());
      addordersInfo.setPost_num(user.getPost_num());
      addordersInfo.setQuantity(quantity);
      addordersInfo.setPrice(price);
      
      ordersService.addOrdersInfo(addordersInfo);
      
      System.out.println(loginUserBean);
      System.out.println(addordersInfo.getOrderID());
      System.out.println(addordersInfo.getProductID());
      System.out.println(addordersInfo.getUserID());
      System.out.println(addordersInfo.getUsername());
      System.out.println(addordersInfo.getPhone());
      System.out.println(addordersInfo.getAddress());
      System.out.println(addordersInfo.getPost_num());
      System.out.println(addordersInfo.getQuantity());
      System.out.println(addordersInfo.getPrice());
      
      System.out.println("=======================================");

      return "product/product_payment";
   }
   
   @RequestMapping(value = "/cartbuyList", method = {RequestMethod.GET, RequestMethod.POST})
   public String cartbuyList(@RequestParam("productID") List<String> productIDs,
                     @RequestParam("productName") List<String> productNames,
                     @RequestParam("productImg") List<String> productImgs, 
                     @RequestParam("price") List<Integer> prices,
                     @RequestParam("quantity") List<Integer> quantities, 
                     
                     Model model) {

      if (!loginUserBean.isUserLogin()) {
         return "redirect:/user/not_login";
      }

      // 상점에서 물품 삭제
      for (String productID : productIDs) {
         cartService.deleteCartItem(loginUserBean.getUserID(), productID);
      }

      // 상점 총합 확인
      int totalprice = 1000;
      for (int i = 0; i < prices.size(); i++) {
         totalprice += prices.get(i) * quantities.get(i);
      }

      // 데이터 확인용 출력
      System.out.println("Product IDs: " + productIDs);
      System.out.println("Product Names: " + productNames);
      System.out.println("Product Images: " + productImgs);
      System.out.println("Prices: " + prices);
      System.out.println("Quantities: " + quantities);
      System.out.println("totalprice: " + totalprice);

      model.addAttribute("productIDs", productIDs);
      model.addAttribute("productNames", productNames);
      model.addAttribute("productImgs", productImgs);
      model.addAttribute("prices", prices);
      model.addAttribute("quantities", quantities);

      model.addAttribute("totalprice", totalprice); // 총 가격 추가

      model.addAttribute("orderSuccessMessage", "주문이 성공적으로 완료되었습니다.");

      return "product/cartbuyList";
   }
   
   

   @GetMapping("/cart")
   public String cart(Model model) {
      if (!loginUserBean.isUserLogin()) {
         return "redirect:/user/not_login";
      }

      List<CartBean> cartItems = cartService.getAllCartItems(loginUserBean.getUserID());
      model.addAttribute("cartItems", cartItems);
      return "product/cart";
   }

   /* @PostMapping("/cart_pro") */
   @RequestMapping(value = "/cart_pro", method = {RequestMethod.GET, RequestMethod.POST})
   public String cart_pro(@ModelAttribute CartBean cartBean, 
                     @RequestParam("productID") String productID,
                     @RequestParam("price") int price, 
                     @RequestParam("quantity") int quantity, 
                     @RequestParam("product_name") String product_name,
                     @RequestParam("product_img") String product_img,
                     Model model) {
      if (!loginUserBean.isUserLogin()) {
         return "redirect:/user/not_login";
      }

      cartBean.setUserID(loginUserBean.getUserID());
      cartBean.setProductID(productID);
      cartBean.setPrice(price);
      cartBean.setQuantity(quantity);
      cartBean.setProduct_name(product_name);
      cartBean.setProduct_img(product_img);
      cartService.addOrUpdateProductInCart(cartBean);

      model.addAttribute("product_name", product_name);
      model.addAttribute("productID", productID);
      model.addAttribute("price", price);

      return "product/cart_success";
   }

   @PostMapping("/cart_main")
   public String cart_main() {
      return "product/cart";
   }

   // cartID  ߺ üũ    īƮ     ǰ  ߰ 
   @PostMapping("/checkCartIDExists")
   public ResponseEntity<String> checkCartIDExists(@RequestBody CartBean cartBean) {
      cartBean.setUserID(loginUserBean.getUserID());
      if (cartService.checkCartIDExists(cartBean.getUserID(), cartBean.getProductID())) {
         cartService.updateCartQuantity(cartBean);
         return ResponseEntity.ok("카트에 동일한 상품이 업데이트 되었습니다.");
      } else {
         cartService.addCart(cartBean);
         return ResponseEntity.ok("장바구니에 상품이 추가되었습니다.");
      }
   }

   //   ǰ    
   @DeleteMapping("/cart_item")
   @ResponseBody
   public ResponseEntity<String> deleteCartItem(@RequestParam("productID") String productID) {

      cartService.deleteCartItem(loginUserBean.getUserID(), productID);

      //  ѱ        ذ 
      HttpHeaders headers = new HttpHeaders();
      headers.setContentType(MediaType.TEXT_PLAIN);
      headers.set("Content-Type", "text/plain; charset=UTF-8");

      return new ResponseEntity<>("삭제가 완료되었습니다", headers, HttpStatus.OK);
   }

   //   ǰ             
   @PostMapping("/update_quantity")
   @ResponseBody
   public ResponseEntity<String> updateQUEntity(@RequestParam("productID") String productID,
                                     @RequestParam("quantity") int quantity) {
      cartService.updateCartItemQuantity(loginUserBean.getUserID(), productID, quantity);
      return ResponseEntity.ok(" 수량이 업데이트 되었습니다 ");
   }
   
   @RequestMapping(value = "/orderList", method = {RequestMethod.GET, RequestMethod.POST})
   public String orderList(@RequestParam("productID") List<String> productIDs,
                     @RequestParam("productName") List<String> productNames,
                     @RequestParam("productImg") List<String> productImgs, 
                     @RequestParam("price") List<Integer> prices,
                     @RequestParam("quantity") List<Integer> quantities, 
                     @RequestParam("color") List<String> colors,
                     @RequestParam("orderID") List<String> orderIDs,
                     Model model) {

      if (!loginUserBean.isUserLogin()) {
         return "redirect:/user/not_login";
      }

      //            ǰ     
      for (String productID : productIDs) {
         cartService.deleteCartItem(loginUserBean.getUserID(), productID);
      }
      
      /*
       * for(String orderID : orderIDs) {
       * ordersService.getAllorders(loginUserBean.getUserID(), orderID);
       * 
       * }
       */

      //           Ȯ  
      int totalprice = 0;
      for (int i = 0; i < prices.size(); i++) {
         totalprice += prices.get(i) * quantities.get(i);
      }

      //        Ȯ ο     
      System.out.println("Product IDs: " + productIDs);
      System.out.println("Product Names: " + productNames);
      System.out.println("Product Images: " + productImgs);
      System.out.println("Prices: " + prices);
      System.out.println("Quantities: " + quantities);
      System.out.println("totalprice: " + totalprice);
      
      
      model.addAttribute("orderIDs", orderIDs);
      model.addAttribute("productIDs", productIDs);
      model.addAttribute("productNames", productNames);
      model.addAttribute("productImgs", productImgs);
      model.addAttribute("prices", prices);
      model.addAttribute("quantities", quantities);
      model.addAttribute("colors", colors);
      model.addAttribute("totalprice", totalprice); //          ߰ 

      model.addAttribute("orderSuccessMessage", "주문이 완료 되었습니다.");

      return "product/orderList";
   }
   

   @PostMapping("/product_delivery")
   public String product_delivery() {
      return "product/product_delivery";
   }

   /* @PostMapping("/order_detail") */
   @RequestMapping(value = "/order_detail", method = {RequestMethod.GET, RequestMethod.POST})
   public String order_detail(@RequestParam("orderID") String orderID, 
                        @RequestParam("productID") String productID,
                        @RequestParam("userID") String userID, 
                        @RequestParam("product_img") String product_img,
                        @RequestParam("product_name") String product_name, 
                        @RequestParam("color") String color,
                        @RequestParam("username") String username, 
                        @RequestParam("phone") String phone,
                        @RequestParam("address") String address, 
                        @RequestParam("post_num") String post_num,
                        @RequestParam("quantity") int quantity, 
                        @RequestParam("price") int price, 
                        Model model) {
      

      if (!loginUserBean.isUserLogin()) {
         return "redirect:/user/not_login";
      }
      
      UserBean user = userService.getFindUser();

      int totalprice = price * quantity;
      
      
      model.addAttribute("orderID", orderID);
      model.addAttribute("productID", productID);
      model.addAttribute("userID", userID);
      model.addAttribute("product_img", product_img);
      model.addAttribute("product_name", product_name);
      model.addAttribute("color", color);
      model.addAttribute("totalprice", totalprice);
      model.addAttribute("price", price);
      model.addAttribute("username", user.getName());
      model.addAttribute("phone", user.getPhone());
      model.addAttribute("post_num", user.getPost_num());
      model.addAttribute("address", user.getAddress());
      model.addAttribute("quantity", quantity);

      return "product/order_detail";
   }
}
