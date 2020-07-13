package com.icia.cheatingday.admin.service.rest;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.cheatingday.admin.dao.*;
import com.icia.cheatingday.exception.*;
import com.icia.cheatingday.review.dao.*;
import com.icia.cheatingday.user.entity.*;

@Service
public class AdminRestService {

	@Autowired
	private ReviewDao rdao;
	@Autowired
	private AdminDao adao;

	public void deleteReport(int rNo) {
		Review review = rdao.findById(rNo);
		if(review==null)
			throw new JobFailException("해당 리뷰를 찾을 수 없습니다");
		rdao.delete(rNo);
		
	}
	public int enabledM(int mNum) {
		return adao.enabledM(mNum);
	}
	
}
