package com.icia.cheatingday.admin.controller.mvc;

import java.io.*;
import java.util.*;

import javax.validation.constraints.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.lang.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.core.type.*;
import com.fasterxml.jackson.databind.*;
import com.icia.cheatingday.admin.service.mvc.*;

@Controller
public class AdminController {
	@Autowired
	private AdminService service;
	@Autowired
	private ObjectMapper objectmapper;
	
	
	@GetMapping("/admin/main")
	public ModelAndView adminmain() {
		return new ModelAndView("main").addObject("viewHeader", "include/viewAdminHeader.jsp")
				.addObject("viewName","admin/main.jsp");
	}
	
	
	@GetMapping("/admin/report_list")
	public ModelAndView list(@RequestParam(defaultValue = "1") int pageno) {
		return new ModelAndView("main").addObject("viewHeader", "include/header.jsp").addObject("viewName", "admin/report_list.jsp").addObject("page", service.list(pageno));
	}
	
	@GetMapping("/admin/user_list")
	public ModelAndView ulist(@RequestParam(defaultValue = "user_list") String job) {
		if(job.equals("block_list"))
			return new ModelAndView("main").addObject("viewHeader", "include/header.jsp").addObject("list", service.blockList()).addObject("viewName", "admin/userlist.jsp").addObject("title","블록유저 목록");
		else
			return new ModelAndView("main").addObject("viewHeader", "include/header.jsp").addObject("list", service.ulist()).addObject("viewName", "admin/userlist.jsp").addObject("title","유저 목록");
	}
	@PostMapping("/admin/user_block")
	public String userBlock(@RequestParam @NotNull String uUsernames) {	
		// "11,22,33,"을 받아서 split() 함수로 정수 변환
		List<String> list = new ArrayList<>();
		String[] strings = uUsernames.split(",");
		for(String str:strings) {
			list.add(str);
		}
		service.userBlock(list);
		return "redirect:/admin/user_list?job=user_list";
	}
	@PostMapping("/admin/user_unblock")
	public String unblockList(@RequestParam @NotNull String uUsernames) throws JsonParseException, JsonMappingException, IOException {
		// json 문자열을 MessageConverter가 객체로 변환하게 하려면 @RequestBody
		// json 문자열을 String으로 받아 객체로 내가 바꾼다
		List<String> list = objectmapper.readValue(uUsernames, new TypeReference<List<String>>() {});
		service.unblock(list);
		return "redirect:/admin/user_list?job=block_list";
	}
	
	@GetMapping("/admin/manager_list")
	public ModelAndView mlist() {
		return new ModelAndView("main").addObject("viewHeader", "include/header.jsp").addObject("list", service.mlist()).addObject("viewName", "admin/managerlist.jsp");
	}
	
	@GetMapping("/admin/manager_read")
	public ModelAndView mread(String mUsername) {
		return new ModelAndView("main").addObject("viewHeader", "include/header.jsp").addObject("manager", service.mread(mUsername)).addObject("viewName", "admin/managerread.jsp");
	}

}
