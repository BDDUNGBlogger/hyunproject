package kr.co.soldesk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.soldesk.beans.ProductBean;
import kr.co.soldesk.dao.ProductDao;

@Service
public class ProductService {
	
	@Autowired
	private ProductDao productDao;
	
	public boolean getProductInfo(String Product) {
		String Product_name = productDao.getProductInfo(Product);
		
		if(Product_name !=null) {
			System.out.println("물건있음");
			return true;
		}
		return false;
	}
	
	public void addProductInfo(ProductBean Addproduct) {
		productDao.addProductInfo(Addproduct);
		System.out.println("안녕?");
	}
	
	public List<ProductBean> getAllProducts(){
		return productDao.getAllProducts();
	}
	
	public void updateInventory(String productID , int quantity) {		
		productDao.updateInventory(productID, quantity);
	}
	
}


