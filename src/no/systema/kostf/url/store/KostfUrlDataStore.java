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
	/**http://localhost:8080/syjserviceskostf/syjsKOSTA.do?user=OSCAR&kabnr=10&kabnr=2*/
	static public String KOSTA_BASE_MAIN_URL = AppConstants.HTTP_ROOT_SERVLET_JSERVICES + "/syjserviceskostf/syjsKOSTA.do";

	/**http://localhost:8080/syjserviceskostf/syjsKOSTB.do?user=OSCAR&kabnr=10 */
	static public String KOSTB_BASE_MAIN_URL = AppConstants.HTTP_ROOT_SERVLET_JSERVICES + "/syjserviceskostf/syjsKOSTB.do";	
	
	//-------------------------
	//[2] UPDATE record (U/A/D
	//-------------------------
	//http://gw.systema.no:8080/syjservicesgodsno/syjsKOSTA_U.do?user=OSCAR&mode=U/A/D&gogn=1234567890123...etc
	static public String KOSTA_BASE_DML_UPDATE_URL = AppConstants.HTTP_ROOT_SERVLET_JSERVICES + "/syjserviceskostf/syjsKOSTA_U.do";

	//http://gw.systema.no:8080/syjservicesgodsno/syjsKOSTB_U.do?user=OSCAR&mode=U/A/D&gogn=1234567890123...etc
	static public String KOSTB_BASE_DML_UPDATE_URL = AppConstants.HTTP_ROOT_SERVLET_JSERVICES + "/syjserviceskostf/syjsKOSTB_U.do";
	
}
