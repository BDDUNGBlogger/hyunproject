package kr.co.soldesk.service;

import java.io.File;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soldesk.beans.CampaignBean;
import kr.co.soldesk.beans.PageBean;
import kr.co.soldesk.dao.CampaignDao;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class CampaignService {
    
    @Value("${path.upload}")
    private String path_upload;
    
    private int page_listcnt = 12; // 한 페이지에 12개의 게시글
   
    
    @Value("${page.paginationcnt}")
    private int page_paginationcnt;
    
    @Autowired
    private CampaignDao campaignDao;
    
    private String saveUploadFile(MultipartFile upload_file) {
        String file_name = System.currentTimeMillis() + "_" +   
               FilenameUtils.getBaseName(upload_file.getOriginalFilename()) + "." + 
               FilenameUtils.getExtension(upload_file.getOriginalFilename());
                  
        try {
            // 경로와 파일 이름
            File destinationFile = new File(path_upload + "/" + file_name);
            upload_file.transferTo(destinationFile);
            System.out.println("File uploaded to: " + destinationFile.getAbsolutePath());
        } catch(Exception e) {
            e.printStackTrace();
        }
                  
        return file_name;
    }
    
    public void addCampaignInfo(CampaignBean writeCampaignBean) {
        System.out.println(writeCampaignBean.getCam_title());
        System.out.println(writeCampaignBean.getCam_host());
        System.out.println(writeCampaignBean.getCategory());
        System.out.println(writeCampaignBean.getGoal_amount());
        System.out.println(writeCampaignBean.getStart_date());
        System.out.println(writeCampaignBean.getEnd_date());
        System.out.println(writeCampaignBean.getCam_intro());
        System.out.println(writeCampaignBean.getCam_news());
        System.out.println(writeCampaignBean.getUpload_file().getSize());
        
        MultipartFile upload_file = writeCampaignBean.getUpload_file();
        
        if(upload_file.getSize() > 0) {
             String file_name = saveUploadFile(upload_file);
             System.out.println("Uploaded file name: " + file_name);
             writeCampaignBean.setCam_img(file_name);
          }
          
          campaignDao.addCampaignInfo(writeCampaignBean);
    }
    
    public List<CampaignBean> getCampaignList(String category, int page) {
        int start = (page - 1) * page_listcnt;
        RowBounds rowBounds = new RowBounds(start, page_listcnt);
        return campaignDao.getCampaignList(category, rowBounds);
    }
    
    public CampaignBean getCampaignInfo(String campaignID) {
        return campaignDao.getCampaignInfo(campaignID);
    }
    
    public void deleteCampaignInfo(String campaignID) {
        campaignDao.deleteCampaignInfo(campaignID);
    }
    
    public void modifyCampaignInfo(CampaignBean modifyCampaignBean) {
        // 이미지 처리
        MultipartFile upload_file = modifyCampaignBean.getUpload_file();

        if (upload_file.getSize() > 0) {
            String file_name = saveUploadFile(upload_file);
            modifyCampaignBean.setCam_img(file_name);// 오라클에 파일 이름 저장
        }
        campaignDao.modifyCampaignInfo(modifyCampaignBean);
    }
    
    public PageBean getCampaignCount(String category, int currentPage) {
        int campaign_count = campaignDao.getCampaignCount(category);
        PageBean pageBean = new PageBean(campaign_count, currentPage, page_listcnt, page_paginationcnt);
        return pageBean;
    }
}
