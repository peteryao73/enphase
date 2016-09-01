/*************************************************************************************
 * Created By: Peter Yao
 * Description: Provides methods to conveniently call the Enphase API as documented here:
 *              https://developer.enphase.com/docs
 * Test Coverage: Provided by EnphaseAPITest
 *
 *************************************************************************************/

public with sharing class EnphaseAPI {

    private static String APIKey = [SELECT API_Key__c
                                    FROM Enphase_Settings__c
                                    WHERE Name = 'System' LIMIT 1].API_Key__c;
    private static String userId = [SELECT User_Id__c
                                    FROM Enphase_Settings__c
                                    WHERE Name = 'System' LIMIT 1].User_Id__c;

    public EnphaseAPI() {
    }

    public static EnphaseEnergyLifetime getEnergyLifetime(Integer systemId,
                                                          Date startDate, Date endDate) {
        String json = enphaseRequest(systemId, 'energy_lifetime', startDate, endDate);

        EnphaseEnergyLifetime lifetime = 
            (EnphaseEnergyLifetime) System.JSON.deserialize(json, EnphaseEnergyLifetime.class);
        System.debug(lifetime);
        return(lifetime);
    }

    public static EnphaseEnvoys getEnvoys(Integer systemId,
                                         Date startDate, Date endDate) {
        String json = enphaseRequest(systemId, 'envoys', null, null);

        EnphaseEnvoys envoy = 
            (EnphaseEnvoys) System.JSON.deserialize(json, EnphaseEnvoys.class);
        System.debug(envoy);
        return(envoy);
    }

    // There's no call to get all systems, this needs to handle pagination.
    public static EnphaseIndex getIndex() {
        String json = enphaseRequest(null, null, null, null);

        EnphaseIndex index = 
            (EnphaseIndex) System.JSON.deserialize(json, EnphaseIndex.class);
        System.debug(index);
        return(index);
    }

    public static EnphaseInventory getInventory(Integer systemId) {
        String json = enphaseRequest(systemId, 'inventory', null, null);

        EnphaseInventory inv = 
            (EnphaseInventory) System.JSON.deserialize(json, EnphaseInventory.class);
        System.debug(inv);
        return(inv);
    }

    public static EnphaseMonthlyProduction getMonthlyProduction(Integer systemId) {
        String json = enphaseRequest(systemId, 'monthly_production', null, null);

        EnphaseMonthlyProduction monthlyProd = 
            (EnphaseMonthlyProduction) System.JSON.deserialize(json, EnphaseMonthlyProduction.class);
        System.debug(monthlyProd);
        return(monthlyProd);
    }

    public static EnphaseRGMStats getRGMStats(Integer systemId) {
        String json = enphaseRequest(systemId, 'rgm_stats', null, null);

        EnphaseRGMStats rgmStats = 
            (EnphaseRGMStats) System.JSON.deserialize(json, EnphaseRGMStats.class);
        System.debug(rgmStats);
        return(rgmStats);
    }

    public static EnphaseStats getStats(Integer systemId) {
        String json = enphaseRequest(systemId, 'stats', null, null);

        EnphaseStats stats = 
            (EnphaseStats) System.JSON.deserialize(json, EnphaseStats.class);
        System.debug(stats);
        return(stats);
    }

    public static EnphaseSummary getSummary(Integer systemId) {
        String json = enphaseRequest(systemId, 'summary', null, null);

        EnphaseSummary summary = 
            (EnphaseSummary) System.JSON.deserialize(json, EnphaseSummary.class);
        System.debug(summary);
        return(summary);
    }

    private static String enphaseRequest(Integer systemId, String call,
                                         Date startDate, Date endDate) {
        HttpRequest req = new HttpRequest();
        String endpoint = 'https://api.enphaseenergy.com/api/v2/systems';
        if (systemId != null) {
            endpoint = endpoint + '/'+systemId;
        }
        if (call != null) {
            endpoint = endpoint + '/'+call;
        }
        endpoint = endpoint + '?key='+apiKey+'&user_id='+userId;
        if (startDate != null) {
            endpoint = endpoint + '&start_date='+startDate+'&end_date='+endDate;
        }
        req.setEndpoint(endpoint);
        req.setMethod('GET');

        // Create a new http object to send the request object
        // A response object is generated as a result of the request
        Http http = new Http();
        System.debug('HTTPRequest: ' + req);
        HTTPResponse res = http.send(req);
        System.debug('HTTPResponse: ' + res.toString());
        return(res.getBody());
    }
}
