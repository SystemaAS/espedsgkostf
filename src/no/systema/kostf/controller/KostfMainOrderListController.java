package no.systema.kostf.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import no.systema.jservices.common.dao.ViskulogDao;
import no.systema.jservices.common.dao.services.BridfDaoService;
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
//@Scope("session")
public class KostfMainOrderListController {
	private static Logger logger = Logger.getLogger(KostfMainOrderListController.class.getName());
//	private ModelAndView loginView = new ModelAndView("login");
	private ModelAndView loginView = new ModelAndView("redirect:logout.do");

	private LoginValidator loginValidator = new LoginValidator();

	
	@RequestMapping(value="kostf_mainorderlist.do", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView doFind(HttpSession session, HttpServletRequest request){
		logger.info("INSIDE: kostf_mainorderlist");
		ModelAndView successView = new ModelAndView("kostf_mainorderlist"); 

		SystemaWebUser appUser = loginValidator.getValidUser(session);		
		
	
		if (appUser == null) {
			return loginView;
		} else {
			return successView;
		}		
		
	}
	

}

