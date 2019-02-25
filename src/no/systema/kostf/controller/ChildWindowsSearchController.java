package no.systema.kostf.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import no.systema.main.model.SystemaWebUser;
import no.systema.main.util.AppConstants;

/**
 * 
 * Child windows codes for Kostnadsföring
 * 
 * 
 * @author Fredrik Möller
 * @date Nov 29, 2018
 * 	
 */

@Controller
public class ChildWindowsSearchController {
	private static final Logger logger = Logger.getLogger(ChildWindowsSearchController.class.getName());
	private ModelAndView loginView = new ModelAndView("login");


	@RequestMapping(value="childwindow_codes.do",  method={RequestMethod.GET} )
	public ModelAndView getCodes(HttpSession session, HttpServletRequest request,
								@RequestParam(value = "caller", required = true) String caller){

		SystemaWebUser appUser = (SystemaWebUser)session.getAttribute(AppConstants.SYSTEMA_WEB_USER_KEY);
		
		if (appUser == null) {

			return this.loginView;

		} else {

			return successView(caller);

		}
	}
		
	private ModelAndView successView(String caller) {
		ModelAndView successView;
		Map model = new HashMap();

		switch (caller) {
		case "kalnr":
			successView = new ModelAndView("childwindow_search_supplier");
			break;
		case "selectSuppliernr":
			successView = new ModelAndView("childwindow_search_supplier");
			break;
		case "kaval":
			successView = new ModelAndView("childwindow_search_valutakode");
			break;			
		case "kavk":
			successView = new ModelAndView("childwindow_search_gebyrkode");
			break;		
		case "selectFrisokKode":
			successView = new ModelAndView("childwindow_search_kodfri");
			break;				
		default:
			String errMsg = String.format("caller %s not supported!", caller);
			throw new RuntimeException(errMsg);
		}
		
		model.put("caller", caller);
		successView.addObject("model" , model);
		
    	return successView;		
		
		
	}

}

