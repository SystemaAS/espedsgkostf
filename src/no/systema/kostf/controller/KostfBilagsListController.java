package no.systema.kostf.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import no.systema.main.model.SystemaWebUser;
import no.systema.main.validator.LoginValidator;

/**
 * Controller  for Kostnadsforing.
 * 
 * @author Fredrik Möller
 * @date Sep 20 , 2018
 * 
 */
@Controller
public class KostfBilagsListController {
	private static Logger logger = Logger.getLogger(KostfBilagsListController.class.getName());
	private ModelAndView loginView = new ModelAndView("redirect:logout.do");
	private LoginValidator loginValidator = new LoginValidator();
	
	@RequestMapping(value="kostf_bilagslist.do", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView doFind(HttpSession session, HttpServletRequest request){
		ModelAndView successView = new ModelAndView("kostf_bilagslist"); 
		SystemaWebUser appUser = loginValidator.getValidUser(session);		
	
		if (appUser == null) {
			return loginView;
		} else {
			return successView;
		}		
		
	}

	@RequestMapping(value="kostf_bilag_edit.do", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView doEdit(HttpSession session, HttpServletRequest request){
		ModelAndView successView = new ModelAndView("kostf_bilag_edit"); 
		SystemaWebUser appUser = loginValidator.getValidUser(session);		
	
		if (appUser == null) {
			return loginView;
		} else {
			return successView;
		}		
		
	}	
	
	

}

