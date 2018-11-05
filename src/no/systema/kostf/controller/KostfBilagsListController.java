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
public class KostfBilagsListController {
	private static Logger logger = Logger.getLogger(KostfBilagsListController.class.getName());
	private ModelAndView loginView = new ModelAndView("redirect:logout.do");
	private LoginValidator loginValidator = new LoginValidator();
	
	private static String SESSION_PARAMS = "sessionParams";
	
	@Autowired
	RestTemplate restTemplate;
	
	@RequestMapping(value="kostf_bilagslist.do", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView doFind(HttpSession session, HttpServletRequest request){
		ModelAndView successView = new ModelAndView("kostf_bilagslist"); 
//		ModelAndView successView = new ModelAndView("NewFile"); 

		SystemaWebUser appUser = loginValidator.getValidUser(session);		
		
	
		if (appUser == null) {
			return loginView;
		} else {

			StringBuilder bilagUrl_create = new StringBuilder("kostf_bilag_edit.do");
			bilagUrl_create.append("?action=").append(CRUDEnum.CREATE.getValue()); //=href in nav-new
			successView.addObject("bilagUrl_create", bilagUrl_create.toString());
			
			return successView;
		}		
		
	}

	/**
	 * This method supports CRU on {@linkplain KostaDao}.
	 * 
	 * Note: Outbound is KostaDto used, since concat of values is needed. Inbound is KostaDao used.  TODO overhaul....
	 * 
	 * @param action
	 * @param session
	 * @param request
	 * @return {@linkplain KostaDto}
	 */
	@RequestMapping(value="kostf_bilag_edit.do", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView doEdit( @ModelAttribute ("record") KostaDto record, 
								@RequestParam(value = "action", required = true) Integer action,
								BindingResult bindingResult, HttpSession session, HttpServletRequest request){
		
		ModelAndView successView = new ModelAndView("kostf_bilag_edit"); 
		SystemaWebUser appUser = loginValidator.getValidUser(session);		

		StringBuilder bilagLinesUrl_read = new StringBuilder("kostf_bilag_lines_edit.do");		
		
		BilagSessionParams sessionParams =  (BilagSessionParams) session.getAttribute(SESSION_PARAMS);
		KostaDto returnDto = null;  //holding values for UI
		
		logger.info("sessionParams="+sessionParams);
		logger.info("doEdit, record="+ReflectionToStringBuilder.reflectionToString(record));
		
		if (appUser == null) {
			return loginView;
		} else {

			if (action.equals(CRUDEnum.CREATE.getValue())) {
				if (sessionParams == null) {
					logger.info("Create init...");
					sessionParams = new BilagSessionParams();
					session.setAttribute(SESSION_PARAMS, sessionParams);
					returnDto = new KostaDto();
				} else {
					logger.info("Create save...");
					KostaDao resultDao = saveRecord(appUser, record, "A");
					returnDto = fetchRecord(appUser, record.getKabnr(), CRUDEnum.READ); //TODO get kabnr
					
					sessionParams.setKabnr(record.getKabnr());
					session.setAttribute(SESSION_PARAMS, sessionParams);
				
				}
				//Set callback state
				successView.addObject("action", CRUDEnum.CREATE.getValue());

			}  else if (action.equals(CRUDEnum.UPDATE.getValue())) {
				logger.info("Update...");
				saveRecord(appUser, record, "U");
				returnDto = fetchRecord(appUser, record.getKabnr(), CRUDEnum.READ);
				bilagLinesUrl_read.append("?kabnr=").append(returnDto.getKabnr()).append("&action=").append(CRUDEnum.READ.getValue()); //=href 		
				successView.addObject("bilagLinesUrl_read", bilagLinesUrl_read.toString());

				
			} else if (action.equals(CRUDEnum.READ.getValue())) {
				logger.info("Read...");
				returnDto = fetchRecord(appUser, record.getKabnr(), CRUDEnum.READ);
				bilagLinesUrl_read.append("?kabnr=").append(returnDto.getKabnr()).append("&action=").append(CRUDEnum.READ.getValue()); //=href 		
				successView.addObject("bilagLinesUrl_read", bilagLinesUrl_read.toString());

			} 

			successView.addObject("record", returnDto);
			
			return successView;
			
		}		
		
	}	

	
	private KostaDao saveRecord(SystemaWebUser appUser, KostaDto record, String mode) {
		logger.info("saveRecord::record::"+ReflectionToStringBuilder.toString(record));
		MultiValueMap<String, String> recordParams = UrlRequestParameterMapper.getUriParameter(record);
//		if ("A".equals(mode)) {
//			recordParams.add("kttyp", "A");
//		}
		
	    UriComponentsBuilder builder = UriComponentsBuilder.fromUriString(KostfUrlDataStore.KOSTA_BASE_DML_UPDATE_URL)
		        .queryParam("user", appUser.getUser())
		        .queryParam("mode", mode)
		        .queryParam("lang", appUser.getUsrLang())
		        .queryParams(recordParams);

		URI uri = builder.buildAndExpand().toUri();

		logger.info("uri="+uri);
		
		ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, null, String.class);
		String body = response.getBody();		
		logger.info("body="+body);
		
		//TODO check response for error.
		
		//TODO retur dao
		return null;
		
		
	}
	private KostaDto fetchRecord(SystemaWebUser appUser, Integer kabnr, CRUDEnum action) {
		logger.info("fetchRecord::kabnr::"+kabnr);
		String BASE_URL = KostfUrlDataStore.KOSTA_BASE_MAIN_URL;
		StringBuilder urlRequestParams = new StringBuilder();
		urlRequestParams.append("?user=" + appUser.getUser());
		urlRequestParams.append("&innregnr=" + kabnr);
		urlRequestParams.append("&action=" + action.getValue());
		logger.info("Full url: " + BASE_URL +urlRequestParams.toString());

		ResponseEntity<List<KostaDao>> response = restTemplate.exchange(BASE_URL + urlRequestParams.toString(),
				HttpMethod.GET, null, new ParameterizedTypeReference<List<KostaDao>>() {});
		List<KostaDao> kostaList = response.getBody();		
		logger.info("kostaList size="+kostaList.size());	

		//Sanity check
		if (kostaList.size() > 1) {  //implicit: kostaList cannot be null
			throw new RuntimeException("fetchRecord for kabnr :"+kabnr+ " gives more than one row!");
		}

		if (kostaList.get(0) != null) {
			KostaDto dto = new KostaDto();
			setDtoValues(dto, kostaList.get(0));
			return dto;
		} else {
			return null;
		}

	}
	
	private void setDtoValues(KostaDto dto, KostaDao dao) {
		dto.setKabb(dao.getKabb());
		dto.setKabdt(dao.getKabdt());
		dto.setKabl(dao.getKabl());
		dto.setKabnr(dao.getKabnr());
		dto.setKabnr2(dao.getKabnr2());
		dto.setKadte(dao.getKadte());
		dto.setKadtr(dao.getKadtr());
		dto.setKafdt(dao.getKafdt());
		dto.setKaffdt(dao.getKaffdt());
		dto.setKafnr(dao.getKafnr());
		dto.setKalkid(dao.getKalkid());
		dto.setKalnr(dao.getKalnr());
		dto.setKapmn(dao.getKapmn());
		dto.setKAPÅR(dao.getKAPÅR());
		dto.setKasg(dao.getKasg());
		dto.setKast(dao.getKast());
		dto.setKatdr(dao.getKatdr());
		dto.setKatme(dao.getKatme());
		dto.setKatxt(dao.getKatxt());
		dto.setKauser(dao.getKauser());
		
		dto.setOpp_dato(DateTimeManager.getDateTime(dao.getKadte(),dao.getKatme()));
		dto.setReg_dato(DateTimeManager.getDateTime(dao.getKadtr(),dao.getKatdr()));
	}

	
}

