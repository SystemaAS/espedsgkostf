package no.systema.kostf.controller;

import java.net.URI;
import java.util.ArrayList;
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
import no.systema.jservices.common.dto.KostbDto;
import no.systema.jservices.common.json.JsonDtoContainer;
import no.systema.jservices.common.json.JsonReader;
import no.systema.jservices.common.util.StringUtils;
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
	public ModelAndView doBilagsLinesList(@RequestParam(value = "kabnr", required = true) Integer kabnr,
			HttpSession session, HttpServletRequest request){
		ModelAndView successView = new ModelAndView("kostf_bilag_lines_edit"); 
		SystemaWebUser appUser = loginValidator.getValidUser(session);		
		
		StringBuilder bilagUrl = new StringBuilder("kostf_bilag_lines_list.do"); 
		StringBuilder bilagUrl_read = new StringBuilder("kostf_bilag_edit.do");

		logger.info("Inside kostf_bilag_lines_list.do");
		logger.info("kabnr="+kabnr);
		
		
		if (appUser == null) {
			return loginView;
		} else {
			
			bilagUrl.append("?action=").append(CRUDEnum.CREATE.getValue()); //=href in nav-new
			successView.addObject("bilagUrl_create", bilagUrl.toString());
			bilagUrl_read.append("?kabnr=").append(kabnr).append("&action=").append(CRUDEnum.READ.getValue()); // =href

			successView.addObject("bilagUrl_read", bilagUrl_read.toString());
			successView.addObject("kabnr", kabnr);
			
			successView.addObject("action", CRUDEnum.CREATE.getValue());
			
			
			return successView;
		}		
		
	}



	/**
	 * This method supports CRU on {@linkplain KostaDto}.
	 * 
	 * 
	 * @param action
	 * @param kabnr
	 * @param session
	 * @param request
	 * @return {@linkplain KostaDto}
	 */
	@RequestMapping(value="kostf_bilag_lines_edit.do", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView doEditLines( @ModelAttribute ("record") KostbDto record, 
								@RequestParam(value = "action", required = true) Integer action,
								BindingResult bindingResult, HttpSession session, HttpServletRequest request){
		
		ModelAndView successView = new ModelAndView("kostf_bilag_lines_edit"); 
		StringBuilder bilagUrl_read = new StringBuilder("kostf_bilag_edit.do");

		SystemaWebUser appUser = loginValidator.getValidUser(session);		
		
		logger.info("Inside kostf_bilag_lines_edit.do");
		logger.info("record="+record);		
		logger.info("action="+action);		
		
		if (appUser == null) {
			return loginView;
		} else {

			if (action.equals(CRUDEnum.CREATE.getValue())) {
				logger.info("Create...");
				saveRecord(appUser, record, "A");
			}  else if (action.equals(CRUDEnum.UPDATE.getValue())) {
				logger.info("Update...");
				saveRecord(appUser, record, "U");
			} 
			
			bilagUrl_read.append("?kabnr=").append(record.getKbbnr()).append("&action=").append(CRUDEnum.READ.getValue()); //=href 
			successView.addObject("bilagUrl_read", bilagUrl_read.toString());

			successView.addObject("action", CRUDEnum.UPDATE.getValue());  //User can update
			
			successView.addObject("kabnr", record.getKbbnr());  
			
			return successView;
			

		}		
		
	}	
	
	/* no return dto due to not possible to get rrn on new  */
	private void saveRecord(SystemaWebUser appUser, KostbDto record, String mode) {
		logger.info("updateRecord::record::"+ReflectionToStringBuilder.toString(record));
		MultiValueMap<String, String> recordParams = UrlRequestParameterMapper.getUriParameter(record);

	    UriComponentsBuilder builder = UriComponentsBuilder.fromUriString(KostfUrlDataStore.KOSTB_BASE_DML_UPDATE_URL)
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
		JsonReader<JsonDtoContainer<KostbDao>> jsonReader = new JsonReader<JsonDtoContainer<KostbDao>>();
		jsonReader.set(new JsonDtoContainer<KostbDao>());
		List<KostbDao> list = new ArrayList<KostbDao>();
		KostbDao dao = null;
		JsonDtoContainer<KostbDao> container = (JsonDtoContainer<KostbDao>) jsonReader.get(body);
		if (container != null) {
			if (StringUtils.hasValue(container.getErrMsg())) {
				String errMsg = String.format("DML-error on bilag, kbbnr: %s. Error message: %s", record.getKbbnr(), container.getErrMsg()) ;
				logger.info(errMsg);
				throw new RuntimeException(container.getErrMsg());
			}		
			list = container.getDtoList();
			if (list.isEmpty() || list.size() != 1){
				String errMsg = String.format("Expecting KostbDao in return! DML-error on bilag, kabnr: %s. Error message: %s", record.getKbbnr(), container.getErrMsg()) ;
				throw new RuntimeException(errMsg);
			} else {
				dao = list.get(0);
			}
		}	
		
	}

	private KostbDto fetchRecord(SystemaWebUser appUser, String rrn) {
		String BASE_URL = KostfUrlDataStore.KOSTB_GET_MAIN_URL;
		StringBuilder urlRequestParams = new StringBuilder();
		urlRequestParams.append("?user=" + appUser.getUser());
		urlRequestParams.append("&rrn=" + rrn);
		logger.info("Full url: " + BASE_URL +urlRequestParams.toString());

		ResponseEntity<KostbDto> response = restTemplate.exchange(BASE_URL + urlRequestParams.toString(),
				HttpMethod.GET, null, new ParameterizedTypeReference<KostbDto>() {});
		return response.getBody();		
	}
	
}

