package org.zerock.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Application Lifecycle Listener implementation class BoardListener
 *
 */
public class AppListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public AppListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce)  { 
    	ServletContext application = sce.getServletContext();
    	application.setAttribute("appRoot", application.getContextPath());
    	
    	// 은비 aws s3 bucket 주소
		/*
		 * 각자 분담한 파트에따라 imgRoot 1~n 만들어서
		 * https://choongang-gohome.s3.ap-northeast-2.amazonaws.com/본인 파트 경로/
		 * 수정,생성 추천합니다 
		 * uploade의 저장경로는 serviceImpl id=uploade 에서 지정해줬지만
		 * getdetail, update, delete의 경로는 ${imgRoot }를 사용하므로  여기서 수정함
		 *
		 * String bucketUrl =
		 * "https://choongang-gohome.s3.ap-northeast-2.amazonaws.com/market/";
		 * application.setAttribute("imgRoot", bucketUrl);
		 */    	
    	String bucketUrl = "https://choongang-gohome.s3.ap-northeast-2.amazonaws.com/";
    	application.setAttribute("imgRoot", bucketUrl);
    }
	
}
