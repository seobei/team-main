package org.zerock.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.Criteria;
import org.zerock.domain.MarketVO;
import org.zerock.domain.Market_fileVO;
import org.zerock.mapper.MarketMapper;
import org.zerock.mapper.Market_fileMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
@Log4j
public class MarketServiceImpl implements MarketService {
   private String bucketName;
   private String profileName;
   private S3Client s3;
   
   @Setter (onMethod_ = @Autowired)
   private MarketMapper market_mapper;
   
   @Setter (onMethod_ = @Autowired)
   private Market_fileMapper market_fileMapper;
   
   public MarketServiceImpl() {
	   this.bucketName = "choongang-ys";
	   this.profileName = "spring1";
	   
	   Path contentLocation = new File(System.getProperty("user.home") + "/.aws/credentials").toPath();
	      ProfileFile pf = ProfileFile.builder()
	            .content(contentLocation)
	            .type(ProfileFile.Type.CREDENTIALS)
	            .build();
	      ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
	            .profileFile(pf)
	            .profileName(profileName)
	            .build();
	      
	      this.s3 = S3Client.builder()
	            .credentialsProvider(pcp)
	            .build();
   }
   
   @Override
   // 트랜잭션 작동 여부 확인
   @Transactional
   public void write(MarketVO mvo, MultipartFile[] mfile) {
      write(mvo);
      for (MultipartFile market_file : mfile) { 
         
         if (market_file != null && market_file.getSize() > 0) {
            Market_fileVO mfvo = new Market_fileVO();
            mfvo.setMno(mvo.getMno());
            mfvo.setFileName(market_file.getOriginalFilename());
            
            market_fileMapper.insert(mfvo);
			upload(mvo, market_file);
         }
      }
     }
   
   // s3에 파일 업로드 
   private void upload(MarketVO mvo, MultipartFile mfile) {
	   log.info("####################################3");
	   log.info(mvo.getMno() + "/" + mfile.getOriginalFilename());
	   log.info("####################################3");

	      try (InputStream is = mfile.getInputStream()) {
	         PutObjectRequest objectRequest = PutObjectRequest.builder().bucket(bucketName)
	               .key(mvo.getMno() + "/" + mfile.getOriginalFilename()).contentType(mfile.getContentType())
	               .acl(ObjectCannedACL.PUBLIC_READ).build();

	         s3.putObject(objectRequest, RequestBody.fromInputStream(is, mfile.getSize()));

	      } catch (Exception e) {
	         throw new RuntimeException(e);
	      }

	   }
   
// 수정해야함
   @Override
   public MarketVO getdetail(int mno) {
//	   MarketVO vo = mapper.read(mno);
//	      List<String> mfile = market_fileMapper.getByBno(mno);
//	      vo.setFileName(mfile);
	      return null;
   }

   @Override
   public List<MarketVO> getList(Criteria cri) {
      return market_mapper.getListWithPaging(cri);
   }

   @Override
   public int getTotal(Criteria cri) {
      //게시글 총 갯수 구하는 매퍼  
      return market_mapper.getTotalCount(cri); 
   }
   // 공부!!!
   @Override
	public void write(MarketVO mvo) {
		// TODO Auto-generated method stub
		market_mapper.insertSelectKey(mvo);
	}
}