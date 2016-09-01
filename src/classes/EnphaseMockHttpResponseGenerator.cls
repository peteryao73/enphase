@isTest
global class EnphaseMockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        // Only send a mock response for a specific endpoint and method.
        String endpoint = req.getEndpoint();
        String method = req.getMethod();
        String body = req.getBody();

        // Create a fake response
        if (endpoint.contains('energy_lifetime')) {
            return(handleEnergyLifetime());
        } else if (endpoint.contains('envoys')) {
            return(handleEnvoys());
        } else if (endpoint.contains('inventory')) {
            return(handleInventory());
        } else if (endpoint.contains('monthly_production')) {
            return(handleMonthlyProduction());
        } else if (endpoint.contains('rgm_stats')) {
            return(handleRGMStats());
        } else if (endpoint.contains('stats')) {
            return(handleStats());
        } else if (endpoint.contains('summary')) {
            return(handleSummary());
        } else {
            return(handleIndex());
        }
    }

    public static HTTPResponse handleEnergyLifetime() 
    {
        HTTPResponse res = getJSON();
        res.setBody(EnphaseAPITest.energyLifetimeJSON);
        return(res);
    }

    public static HTTPResponse handleEnvoys() 
    {
        HTTPResponse res = getJSON();
        res.setBody(EnphaseAPITest.envoysJSON);
        return(res);
    }

    public static HTTPResponse handleInventory() 
    {
        HTTPResponse res = getJSON();
        res.setBody(EnphaseAPITest.inventoryJSON);
        return(res);
    }

    public static HTTPResponse handleMonthlyProduction() 
    {
        HTTPResponse res = getJSON();
        res.setBody(EnphaseAPITest.monthlyProductionJSON);
        return(res);
    }

    public static HTTPResponse handleRGMStats() 
    {
        HTTPResponse res = getJSON();
        res.setBody(EnphaseAPITest.rgmStatsJSON);
        return(res);
    }

    public static HTTPResponse handleStats() 
    {
        HTTPResponse res = getJSON();
        res.setBody(EnphaseAPITest.statsJSON);
        return(res);
    }

    public static HTTPResponse handleSummary() 
    {
        HTTPResponse res = getJSON();
        res.setBody(EnphaseAPITest.summaryJSON);
        return(res);
    }

    public static HTTPResponse handleIndex() 
    {
        HTTPResponse res = getJSON();
        res.setBody(EnphaseAPITest.indexJSON);
        return(res);
    }

    public static HTTPResponse getJSON() 
    {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        return res;
    }
}