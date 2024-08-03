package kr.co.soldesk.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.soldesk.beans.ProductBean;

import kr.co.soldesk.mapper.ProductMapper;

@Repository
public class ProductDao {
	
	@Autowired
	private ProductMapper productMapper ;
	
	public String getProductInfo(String product) {
		return productMapper.getProductInfo(product);
	}

	public void addProductInfo(ProductBean Addproduct) {
		productMapper.addProduct(Addproduct);
		
	}
	
	public List<ProductBean> getAllProducts(){
		return productMapper.getAllProducts();
	}
	
	public void updateInventory(String productID, int quantity) {
		productMapper.updateInventory(productID, quantity);
	} 
	
}
