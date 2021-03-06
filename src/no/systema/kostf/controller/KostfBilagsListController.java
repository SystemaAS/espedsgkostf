package no.systema.kostf.controller;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
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
public class KostfBilagsListController {
	private static Logger logger = Logger.getLogger(KostfBilagsListController.class.getName());
	private ModelAndView loginView = new ModelAndView("redirect:logout.do");
	private LoginValidator loginValidator = new LoginValidator();
	
	@Autowired
	RestTemplate restTemplate;
	
	/**
	 * This method just render jsp
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value="kostf_bilagslist.do", method={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView doFind(HttpSession session, HttpServletRequest request) {
		ModelAndView successView = new ModelAndView("kostf_bilagslist");
		SystemaWebUser appUser = loginValidator.getValidUser(session);

		if (appUser == null) {
			return loginView;
		} else {
			return successView;
		}

	}

	/**
	 * This method supports CRU on {@linkplain KostaDao}.
	 * 
	 * Note: Outbound/inbound is KostaDto used, since concat of values is needed and non-database-values.
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

		SystemaWebUser appUser = loginValidator.getValidUser(session);		
		if (appUser == null) {
			return loginView;
		}		
		
		ModelAndView editView = new ModelAndView("kostf_bilag_edit"); 
		ModelAndView redirectListView = new ModelAndView("redirect:kostf_bilagslist.do"); 
		ModelAndView returnView = editView; //default

		KostaDto returnDto = new KostaDto();

		logger.info("doEdit, record="+ReflectionToStringBuilder.reflectionToString(record));
		logger.info("action="+action);
		
		if (action.equals(CRUDEnum.CREATE.getValue()) && record.getKabnr() == null) {
			logger.info("Init...");
			editView.addObject("action", CRUDEnum.CREATE.getValue());
			
			return returnView;
		} 

		try {

			if (action.equals(CRUDEnum.CREATE.getValue())) {
				logger.info("Create...");
				KostaDto dto = saveRecord(appUser, record, "A");
				returnDto = fetchRecord(appUser, dto.getKabnr());
				editView.addObject("record", returnDto);

				// Set callback state
				editView.addObject("action", CRUDEnum.UPDATE.getValue());

			} else if (action.equals(CRUDEnum.UPDATE.getValue())) {
				logger.info("Update...");
				returnDto = saveRecord(appUser, record, "U");
				editView.addObject("record", returnDto);
				
				// Set callback state
				editView.addObject("action", CRUDEnum.UPDATE.getValue());

			} else if (action.equals(CRUDEnum.READ.getValue())) {
				logger.info("Read...");
				returnDto = fetchRecord(appUser, record.getKabnr());
				editView.addObject("record", returnDto);

				// Set callback state
				editView.addObject("action", CRUDEnum.UPDATE.getValue());

			} else if (action.equals(CRUDEnum.DELETE.getValue())) {
				logger.info("Delete...");
				returnDto = saveRecord(appUser, record, "D");
				returnView = redirectListView;

				// Set callback state
				editView.addObject("action", CRUDEnum.READ.getValue());

			}

		} catch (Exception e) {
			logger.error("ERROR:", e);
			// Set callback state
			editView.addObject("action", action);
			editView.addObject("error", e.getMessage());

		}
		
		return returnView;
		
	}	


	private KostaDto saveRecord(SystemaWebUser appUser, KostaDto record, String mode) {
		logger.info("saveRecord::record::"+ReflectionToStringBuilder.toString(record));
		MultiValueMap<String, String> recordParams = UrlRequestParameterMapper.getUriParameter(record);
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

		JsonReader<JsonDtoContainer<KostaDao>> jsonReader = new JsonReader<JsonDtoContainer<KostaDao>>();
		jsonReader.set(new JsonDtoContainer<KostaDao>());
		List<KostaDao> list = new ArrayList<KostaDao>();
		KostaDao dao = null;
		KostaDto dto;
		JsonDtoContainer<KostaDao> container = (JsonDtoContainer<KostaDao>) jsonReader.get(body);
		if (container != null) {
			if (StringUtils.hasValue(container.getErrMsg())) {
				String errMsg = String.format("DML-error on bilag, kabnr: %s. Error message: %s", record.getKabnr(), container.getErrMsg()) ;
				logger.info(errMsg);
				throw new RuntimeException(container.getErrMsg());
			}		
			list = container.getDtoList();
			if (list.isEmpty() || list.size() != 1){
				String errMsg = String.format("Expecting KostaDao in return! DML-error on bilag, kabnr: %s. Error message: %s", record.getKabnr(), container.getErrMsg()) ;
				throw new RuntimeException(errMsg);
			} else {
				dao = list.get(0);
			}
		}
		
		dto = get(dao, appUser);
		return dto;
		
	}
	
	private KostaDto fetchRecord(SystemaWebUser appUser, String kabnr) {
		logger.info("fetchRecord::kabnr::"+kabnr);
		String BASE_URL = KostfUrlDataStore.KOSTA_GET_MAIN_URL;
		StringBuilder urlRequestParams = new StringBuilder();
		urlRequestParams.append("?user=" + appUser.getUser());
		urlRequestParams.append("&innregnr=" + kabnr);
		logger.info("Full url: " + BASE_URL +urlRequestParams.toString());

		ResponseEntity<KostaDto> response = restTemplate.exchange(BASE_URL + urlRequestParams.toString(), HttpMethod.GET, null, KostaDto.class);
		KostaDto dto = response.getBody();		
		
		logger.info("dto="+ReflectionToStringBuilder.toString(dto));
			
		return dto;

	}
	
	private String getLevName(SystemaWebUser appUser, Integer levnr) {
		logger.info("getLevName::levnr::"+levnr);
		String BASE_URL = KostfUrlDataStore.LEVEF_NAME_URL;
		StringBuilder urlRequestParams = new StringBuilder();
		urlRequestParams.append("?user=" + appUser.getUser());
		urlRequestParams.append("&levnr=" + levnr);
		logger.info("Full url: " + BASE_URL +urlRequestParams.toString());

		ResponseEntity<String> response = restTemplate.exchange(BASE_URL + urlRequestParams.toString(),
				HttpMethod.GET, null, String.class);

//		logger.info("response="+response);	

		if (response != null) {
			return response.getBody();
		} else {
			return null;
		}

	}	
	
	private KostaDto get(KostaDao dao, SystemaWebUser appUser) {
		if (dao == null) {
			throw new RuntimeException("dao cannot be null.");
		}
		KostaDto dto = KostaDto.get(dao);		
		
		dto.setLevnavn(getLevName(appUser, dao.getKalnr().intValue()));

		return dto;
		
	}
	
	
}

