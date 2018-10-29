package no.systema.kostf.controller;

import java.net.URI;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import no.systema.jservices.common.dao.KostaDao;
import no.systema.jservices.common.dao.KostbDao;
import no.systema.jservices.common.dto.KostaDto;
import no.systema.jservices.common.util.DateTimeManager;
import no.systema.jservices.common.values.CRUDEnum;
import no.systema.kostf.url.store.KostfUrlDataStore;
import no.systema.main.mapper.url.request.UrlRequestParameterMapper;
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
public class KostfBilagLinesController {
	private static Logger logger = Logger.getLogger(KostfBilagLinesController.class.getName());
	private ModelAndView loginView = new ModelAndView("redirect:logout.do");
	private LoginValidator loginValidator = new LoginValidator();
	
	@Autowired
	RestTemplate restTemplate;
	
	@RequestMapping(value="kostf_bilag_lines_list.do", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView doFind(HttpSession session, HttpServletRequest request){
		ModelAndView successView = new ModelAndView("kostf_bilag_lines_edit"); 
		SystemaWebUser appUser = loginValidator.getValidUser(session);		
		
		StringBuilder bilagUrl = new StringBuilder("kostf_bilag_lines_edit.do"); //TODO bilagslinesedit
	
		if (appUser == null) {
			return loginView;
		} else {
			
			bilagUrl.append("?action=").append(CRUDEnum.CREATE.getValue()); //=href in nav-new
			successView.addObject("bilagUrl_create", bilagUrl.toString());
			
			return successView;
		}		
		
	}



	/**
	 * This method supports CRU on {@linkplain KostaDao}.
	 * 
	 * Note: Outbound is KostaDto used, since concat of values is needed. Inbound is KostaDao used.
	 * 
	 * @param action
	 * @param kabnr
	 * @param session
	 * @param request
	 * @return {@linkplain KostaDto}
	 */
	@RequestMapping(value="kostf_bilag_lines_edit.do", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView doEditLines( @ModelAttribute ("record") KostbDao record, 
								@RequestParam(value = "action", required = true) Integer action,
								BindingResult bindingResult, HttpSession session, HttpServletRequest request){
		
		ModelAndView successView = new ModelAndView("kostf_bilag_lines_edit"); 
		SystemaWebUser appUser = loginValidator.getValidUser(session);		

		StringBuilder bilagUrl_read = new StringBuilder("kostf_bilag_edit.do");
		
		
		KostbDao returnDao = null;  //holding values for UI
		
		if (appUser == null) {
			return loginView;
		} else {
			BilagSessionParams sessionParams = (BilagSessionParams) session.getAttribute("sessionParams");

			if (action.equals(CRUDEnum.CREATE.getValue())) {
				logger.info("Create...");
//				returnDto = getDtoCreated();
//				returnDto = new KostaDto();
			}  else if (action.equals(CRUDEnum.UPDATE.getValue())) {
				logger.info("Update...");
				updateRecord(appUser, record);
			} 
			
//			returnDao = fetchRecord(appUser, sessionParams.getKabnr(), CRUDEnum.READ);
			logger.info("sessionParams.getKabnr()="+sessionParams.getKabnr());
//			logger.info("returnDao.getKbbnr()"+returnDao.getKbbnr());

//			successView.addObject("record", returnDao);
			
			bilagUrl_read.append("?kabnr=").append(sessionParams.getKabnr()).append("&action=").append(CRUDEnum.READ.getValue()); //=href 
			successView.addObject("bilagUrl_read", bilagUrl_read.toString());

			successView.addObject("action", CRUDEnum.UPDATE.getValue());  //User can update
			
			return successView;

		}		
		
	}	
	
	
	private void updateRecord(SystemaWebUser appUser, KostbDao record) {
		logger.info("updateRecord::record::"+ReflectionToStringBuilder.toString(record));
		MultiValueMap<String, String> recordParams = UrlRequestParameterMapper.getUriParameter(record);

	    UriComponentsBuilder builder = UriComponentsBuilder.fromUriString(KostfUrlDataStore.KOSTA_BASE_DML_UPDATE_URL)
		        .queryParam("user", appUser.getUser())
		        .queryParam("mode", "U")
		        .queryParam("lang", appUser.getUsrLang())
		        .queryParams(recordParams);

		URI uri = builder.buildAndExpand().toUri();

		logger.info("uri="+uri);
		
		ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, null, String.class);
		String body = response.getBody();		
		logger.info("body="+body);
		
		//TODO check response for error.
		
	}

//	private KostbDao fetchRecord(SystemaWebUser appUser, Integer kabnr, CRUDEnum action) {
//		String BASE_URL = KostfUrlDataStore.KOSTB_BASE_MAIN_URL;
//		StringBuilder urlRequestParams = new StringBuilder();
//		urlRequestParams.append("?user=" + appUser.getUser());
//		urlRequestParams.append("&innregnr=" + kabnr);
//		urlRequestParams.append("&action=" + action.getValue());
//		logger.info("Full url: " + BASE_URL +urlRequestParams.toString());
//
//		ResponseEntity<List<KostbDao>> response = restTemplate.exchange(BASE_URL + urlRequestParams.toString(),
//				HttpMethod.GET, null, new ParameterizedTypeReference<List<KostbDao>>() {});
//		List<KostbDao> kostbList = response.getBody();		
//		logger.info("kostbList size="+kostbList.size());	
//
//		//Sanity check
//		if (kostbList.size() > 1) {  //implicit: kostaList cannot be null
//			throw new RuntimeException("fetchRecord for innregnr :"+kabnr+ " gives more than one row!");
//		}
//
//		if (kostbList.get(0) != null) {
//			KostaDto dto = new KostaDto();
//			return kostbList.get(0);
//		} else {
//			return null;
//		}
//
//	}
	
	
	
	
}

