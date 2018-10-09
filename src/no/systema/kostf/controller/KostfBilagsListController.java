package no.systema.kostf.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import no.systema.jservices.common.dao.KostaDao;
import no.systema.jservices.common.dao.services.KostaDaoService;
import no.systema.jservices.common.values.CRUDEnum;
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
	
	@Autowired
	private KostaDaoService kostaDaoService;
	
	@RequestMapping(value="kostf_bilagslist.do", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView doFind(HttpSession session, HttpServletRequest request){
		ModelAndView successView = new ModelAndView("kostf_bilagslist"); 
		SystemaWebUser appUser = loginValidator.getValidUser(session);		
		
		StringBuilder bilagUrl = new StringBuilder("kostf_bilag_edit.do");
	
		if (appUser == null) {
			return loginView;
		} else {
			
			bilagUrl.append("?action=").append(CRUDEnum.CREATE.getValue()); //href in nav-new
			successView.addObject("bilagUrl_create", bilagUrl.toString());
			
			return successView;
		}		
		
	}

	/**
	 * This method supports CRU on {@linkplain KostaDao} and {@linkplain KostabDao}
	 * 
	 * @param action
	 * @param kabnr
	 * @param session
	 * @param request
	 * @return {@linkplain KostaDao}
	 */
	@RequestMapping(value="kostf_bilag_edit.do", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView doEdit( @RequestParam(value = "action", 	required = true) Integer action, 	
								@RequestParam(value = "kabnr", 	required = false) Integer kabnr, 
								HttpSession session, HttpServletRequest request){
		ModelAndView successView = new ModelAndView("kostf_bilag_edit"); 
		SystemaWebUser appUser = loginValidator.getValidUser(session);		
	
		KostaDao returnDao;
		
		if (appUser == null) {
			return loginView;
		} else {
			if (action.equals(CRUDEnum.CREATE.getValue())) {
				logger.info("Create...");
				returnDao = new KostaDao();
			} else if (action.equals(CRUDEnum.READ.getValue())) {
				logger.info("Read...");
				returnDao = get(kabnr);
			} else {
				throw new RuntimeException("action not valid!, value="+action);
			}
			
			logger.info("returnDao="+ReflectionToStringBuilder.toString(returnDao));
			
			successView.addObject("record", returnDao);
			
			return successView;
		}		
		
	}	
	
	private KostaDao get(Integer kabnr) {
		KostaDao qDao = new KostaDao();
		qDao.setKabnr(kabnr);
		return kostaDaoService.find(qDao);
		
	}

}

