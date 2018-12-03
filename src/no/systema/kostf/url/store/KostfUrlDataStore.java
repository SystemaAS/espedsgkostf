/**
 * 
 */
package no.systema.kostf.url.store;
import no.systema.main.util.AppConstants;
/**
 * 
 * Static URLs
 * @author Fredrik Möller
 * @date Oct 2018
 * 
 * 
 */
public final class KostfUrlDataStore {
	
	//----------------------
	//[1] FETCH MAIN LIST
	//----------------------
	/**http://localhost:8080/syjserviceskostf/syjsKOSTA?user=SYSTEMA&bilagsnr=10218&innregnr=2001057*/
	static public String KOSTA_BASE_MAIN_URL = AppConstants.HTTP_ROOT_SERVLET_JSERVICES + "/syjserviceskostf/syjsKOSTA.do";

	/**http://localhost:8080/syjserviceskostf/syjsKOSTB.do?user=OSCAR&kabnr=10 */
	static public String KOSTB_BASE_MAIN_URL = AppConstants.HTTP_ROOT_SERVLET_JSERVICES + "/syjserviceskostf/syjsKOSTB.do";	

	/**http://localhost:8080/syjserviceskostf/syjsLEVEF_NAME?user=SYSTEMA&levnr=1*/
	static public String LEVEF_NAME_URL = AppConstants.HTTP_ROOT_SERVLET_JSERVICES + "/syjserviceskostf/syjsLEVEF_NAME.do";		
	
	
	//-------------------------
	//[2] UPDATE record (U/A/D
	//-------------------------
	//http://gw.systema.no:8080/syjservicesgodsno/syjsKOSTA_U.do?user=OSCAR&mode=U/A/D&gogn=1234567890123...etc
	static public String KOSTA_BASE_DML_UPDATE_URL = AppConstants.HTTP_ROOT_SERVLET_JSERVICES + "/syjserviceskostf/syjsKOSTA_U.do";

	//http://gw.systema.no:8080/syjservicesgodsno/syjsKOSTB_U.do?user=OSCAR&mode=U/A/D&gogn=1234567890123...etc
	static public String KOSTB_BASE_DML_UPDATE_URL = AppConstants.HTTP_ROOT_SERVLET_JSERVICES + "/syjserviceskostf/syjsKOSTB_U.do";
	
}
