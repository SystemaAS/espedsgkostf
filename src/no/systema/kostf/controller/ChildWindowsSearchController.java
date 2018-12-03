package no.systema.kostf.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import no.systema.jservices.common.dao.ArkextDao;
import no.systema.jservices.common.dto.ArktxtDto;
import no.systema.main.model.SystemaWebUser;
import no.systema.main.util.AppConstants;
import no.systema.main.util.JsonDebugger;
import no.systema.z.main.maintenance.model.jsonjackson.dbtable.JsonMaintMainChildWindowKofastRecord;

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
	private static final JsonDebugger jsonDebugger = new JsonDebugger();


	@RequestMapping(value="childwindow_codes.do",  method={RequestMethod.GET} )
	public ModelAndView getCodes(HttpSession session, HttpServletRequest request){
		ModelAndView successView = new ModelAndView("childwindow_search_supplier");

		SystemaWebUser appUser = (SystemaWebUser)session.getAttribute(AppConstants.SYSTEMA_WEB_USER_KEY);
		Map model = new HashMap();
		String caller = request.getParameter("caller");  //Field in jsp
		
		if(appUser==null){
			return this.loginView;
		}else{
			  
			List list = getCodeList(appUser, caller);
			model.put("codeList", list);
			model.put("caller", caller);
			
			successView.addObject("model" , model);
			
	    	return successView;
		}
	}
		
	private List<ChildWindowKode> getCodeList(SystemaWebUser appUser, String caller) {
		List<ChildWindowKode> list = null;

		if ("selectSuppliernr".equals(caller)) { 
			list = getArklagKoder(appUser);
		} 
		else {
			throw new IllegalArgumentException(caller + " is not supported.");
		}

		return list;
	}
	
	
	private List<ChildWindowKode>  getArklagKoder(SystemaWebUser appUser) {
		return null;
	}	
	
	private ChildWindowKode getChildWindowKode(ArkextDao dao) {
		ChildWindowKode kode = new ChildWindowKode();
		kode.setCode(dao.getArcext());
		kode.setDescription(dao.getArcane());

		return kode;
	}		

	private List<ChildWindowKode> getArkivuKoder(SystemaWebUser appUser) {
		return null;
	}	
	
	private List<ChildWindowKode> getArktxtKoder(SystemaWebUser appUser) {
		return null;
	}	
	
	private ChildWindowKode getChildWindowKode(JsonMaintMainChildWindowKofastRecord record) {
		ChildWindowKode kode = new ChildWindowKode();
		kode.setCode(record.getKfkod());
		kode.setDescription(record.getKftxt());
		
		return kode;
	}	
	
	private ChildWindowKode getChildWindowKode(ArktxtDto dto) {
		ChildWindowKode kode = new ChildWindowKode();
		kode.setCode(dto.getArtype());
		kode.setDescription(dto.getArtxt());

		return kode;
	}	

}

