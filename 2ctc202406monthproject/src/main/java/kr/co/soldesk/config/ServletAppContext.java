package kr.co.soldesk.config;

import javax.annotation.Resource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.JdbcType;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import kr.co.soldesk.mapper.CommentMapper;
import kr.co.soldesk.beans.UserBean;
import kr.co.soldesk.interceptor.CheckCampaignInterceptor;
import kr.co.soldesk.interceptor.CheckLoginInterceptor;
import kr.co.soldesk.interceptor.TopMenuInterceptor;
import kr.co.soldesk.mapper.AdminMapper;
import kr.co.soldesk.mapper.BoardMapper;
import kr.co.soldesk.mapper.CampaignMapper;
import kr.co.soldesk.mapper.CartMapper;
import kr.co.soldesk.mapper.DonationMapper;
import kr.co.soldesk.mapper.OrdersMapper;
import kr.co.soldesk.mapper.ProductMapper;
import kr.co.soldesk.mapper.TopMenuMapper;
import kr.co.soldesk.mapper.UserMapper;
import kr.co.soldesk.mapper.WeatherMapper;
import kr.co.soldesk.service.TopMenuService;

@Configuration // Spring MVC �봽濡쒖젥�듃 �꽕�젙
@EnableWebMvc // �뼱�끂�뀒�씠�뀡 �뀑�똿 �꽑�뼵
@ComponentScan("kr.co.soldesk.dao")
@ComponentScan("kr.co.soldesk.service")
@ComponentScan("kr.co.soldesk.controller")
@PropertySource("/WEB-INF/properties/db.properties")
@PropertySource("/WEB-INF/properties/application.properties")
@ComponentScan("kr.co.soldesk.Social")
public class ServletAppContext implements WebMvcConfigurer {

	
  @Value("${db.classname}")
   private String db_classname;

   @Value("${db.url}")
   private String db_url;

   @Value("${db.username}")
   private String db_username;

   @Value("${db.password}")
   private String db_password;

   @Autowired
   private TopMenuService topMenuService;

   @Resource(name = "loginUserBean")
   private UserBean loginUserBean;

   // jsp /html /css /js /jq
   @Override
   public void configureViewResolvers(ViewResolverRegistry registry) {
      WebMvcConfigurer.super.configureViewResolvers(registry);
      registry.jsp("/WEB-INF/views/", ".jsp");
   }

   // �젙�쟻 而⑦뀗痢� �뙆�씪�쓽 寃쎈줈 �꽕�젙
   @Override
   public void addResourceHandlers(ResourceHandlerRegistry registry) {
      WebMvcConfigurer.super.addResourceHandlers(registry);
      registry.addResourceHandler("/**").addResourceLocations("/resources/");
   }

   // �뜲�씠�꽣踰좎씠�뒪 �젒�냽 �젙蹂대�� 愿�由ы븯�뒗 Bean
   @Bean
   public BasicDataSource dataSource() {
      BasicDataSource source = new BasicDataSource();
      source.setDriverClassName(db_classname);
      source.setUrl(db_url);
      source.setUsername(db_username);
      source.setPassword(db_password);

      return source;
   }

   // 荑쇰━臾멸낵 �젒�냽 �젙蹂대�� 愿�由ы븯�뒗 媛앹껜
   @Bean
   public SqlSessionFactory factory(BasicDataSource source) throws Exception {
      SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
      factoryBean.setDataSource(source);
      
      // MyBatis �꽕�젙 異붽�
      org.apache.ibatis.session.Configuration mybatisConfig = new org.apache.ibatis.session.Configuration();
      mybatisConfig.setJdbcTypeForNull(JdbcType.VARCHAR); // �씠 �꽕�젙�쓣 異붽�
      factoryBean.setConfiguration(mybatisConfig);
      
      SqlSessionFactory factory = factoryBean.getObject();

      return factory;
   }

   // 荑쇰━臾� �떎�뻾�쓣 �쐞�븳 媛앹껜(Mapper 愿�由�)
   @Bean
   public MapperFactoryBean<BoardMapper> getBoardMapper(SqlSessionFactory factory) throws Exception {
      MapperFactoryBean<BoardMapper> factoryBean = new MapperFactoryBean<BoardMapper>(BoardMapper.class);
      factoryBean.setSqlSessionFactory(factory);
      return factoryBean;
   }

   @Bean
   public MapperFactoryBean<TopMenuMapper> getTopMenuMapper(SqlSessionFactory factory) throws Exception {
      MapperFactoryBean<TopMenuMapper> factoryBean = new MapperFactoryBean<TopMenuMapper>(TopMenuMapper.class);
      factoryBean.setSqlSessionFactory(factory);
      return factoryBean;
   }
   
   @Bean
   public MapperFactoryBean<ProductMapper> getProductMapper(SqlSessionFactory factory) throws Exception{
      MapperFactoryBean<ProductMapper> factoryBean = new MapperFactoryBean<ProductMapper>(ProductMapper.class);
      factoryBean.setSqlSessionFactory(factory);
      return factoryBean;
   }
   
   @Bean
   public MapperFactoryBean<CartMapper> getCartMapper(SqlSessionFactory factory) throws Exception{
      MapperFactoryBean<CartMapper> factoryBean = new MapperFactoryBean<CartMapper>(CartMapper.class);
      factoryBean.setSqlSessionFactory(factory);
      return factoryBean;
   }
   
   @Bean
   public MapperFactoryBean<CampaignMapper> getCampaignMapper(SqlSessionFactory factory) throws Exception {
      MapperFactoryBean<CampaignMapper> factoryBean = new MapperFactoryBean<CampaignMapper>(CampaignMapper.class);
      factoryBean.setSqlSessionFactory(factory);
      return factoryBean;
   }
   
   @Bean
   public MapperFactoryBean<DonationMapper> getDonationMapper(SqlSessionFactory factory) throws Exception {
      MapperFactoryBean<DonationMapper> factoryBean = new MapperFactoryBean<DonationMapper>(DonationMapper.class);
      factoryBean.setSqlSessionFactory(factory);
      return factoryBean;
   }
   @Bean
   public MapperFactoryBean<OrdersMapper> getOrdersMapper(SqlSessionFactory factory) throws Exception {
      MapperFactoryBean<OrdersMapper> factoryBean = new MapperFactoryBean<OrdersMapper>(OrdersMapper.class);
      factoryBean.setSqlSessionFactory(factory);
      return factoryBean;
   }
   
   @Bean

     public MapperFactoryBean<AdminMapper> getAdminMapper(SqlSessionFactory factory) throws Exception {
        MapperFactoryBean<AdminMapper> factoryBean = new MapperFactoryBean<AdminMapper>(AdminMapper.class);
        factoryBean.setSqlSessionFactory(factory); 
        return factoryBean;
     }

   
   @Bean
   public MapperFactoryBean<WeatherMapper> getWeatherMapper(SqlSessionFactory factory) throws Exception {
      MapperFactoryBean<WeatherMapper> factoryBean = new MapperFactoryBean<WeatherMapper>(WeatherMapper.class);
      factoryBean.setSqlSessionFactory(factory);
      return factoryBean;
   }
   
   @Bean
   public MapperFactoryBean<CommentMapper> getCommentMapper(SqlSessionFactory factory) throws Exception {
      MapperFactoryBean<CommentMapper> factoryBean = new MapperFactoryBean<CommentMapper>(CommentMapper.class);
      factoryBean.setSqlSessionFactory(factory);
      return factoryBean;
   }

   @Override
   public void addInterceptors(InterceptorRegistry registry) {
      WebMvcConfigurer.super.addInterceptors(registry);

      TopMenuInterceptor topMenuInterceptor = new TopMenuInterceptor(topMenuService, loginUserBean);
      InterceptorRegistration reg1 = registry.addInterceptor(topMenuInterceptor);
      reg1.addPathPatterns("/**");// 紐⑤뱺 �슂泥�二쇱냼�뿉 �룞�옉
      System.out.println("二쇱냼�슂泥�");

      CheckLoginInterceptor checkLoginInterceptor = new CheckLoginInterceptor(loginUserBean);
      InterceptorRegistration reg2 = registry.addInterceptor(checkLoginInterceptor);

      reg2.addPathPatterns("/user/modify", "/user/logout", "/board/*");
      reg2.excludePathPatterns("/board/main", "/board/read");
      
      CheckCampaignInterceptor checkCampaignInterceptor = new CheckCampaignInterceptor(loginUserBean);
      InterceptorRegistration reg3=registry.addInterceptor(checkCampaignInterceptor);
       
      reg3.addPathPatterns("/campaign/portOnepayment");
      
      
   }

   // Properties�뙆�씪�쓣 Bean�쑝濡� �벑濡�
   @Bean
   public static PropertySourcesPlaceholderConfigurer PropertySourcesPlaceholderConfigurer() {
      return new PropertySourcesPlaceholderConfigurer();
   }

   // Properties Message�쐞移� 吏��젙�븯�뿬 �쑀�슚�꽦 寃��궗 �냼�뒪�뒗 紐⑤몢 �씠怨녹쓣 �씫怨� 媛��룄濡�
   @Bean
   public ReloadableResourceBundleMessageSource messageSource() {
      ReloadableResourceBundleMessageSource res = new ReloadableResourceBundleMessageSource();
      res.setBasenames("/WEB-INF/properties/error_message");
      System.out.println("�뿉�윭硫붿꽭吏�");
      return res;
   }

   @Bean
   public MapperFactoryBean<UserMapper> getUserMapper(SqlSessionFactory factory) throws Exception {
      MapperFactoryBean<UserMapper> factoryBean = new MapperFactoryBean<UserMapper>(UserMapper.class);
      factoryBean.setSqlSessionFactory(factory);
      return factoryBean;
   }

   // enctype="multipart/form-data" �궗�슜�븯湲� �쐞�븳 �겢�옒�뒪 媛앹껜 �깮�꽦
   @Bean
   public StandardServletMultipartResolver multipartResolver() {
      return new StandardServletMultipartResolver(); // 媛앹껜 �깮�꽦�븯�뿬 諛섑솚
   }

}
