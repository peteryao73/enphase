@IsTest
public with sharing class EnphaseAPITest {
	
    @testSetup static void setupTestData() {
        Enphase_Settings__c es =
            new Enphase_Settings__c(Name = 'System',
                                    User_Id__c = 'asdfjhjdhfjdf',
                                    API_Key__c = 'asdfjhdkjf');
        insert es;
    }

    static testMethod void testAPI() {
        Test.setMock(HttpCalloutMock.class, new EnphaseMockHttpResponseGenerator());

        Test.startTest();
        EnphaseAPI.getEnergyLifetime(61, null, null);
        EnphaseAPI.getEnvoys(61, null, null);
        EnphaseAPI.getIndex();
        EnphaseAPI.getInventory(61);
        EnphaseAPI.getMonthlyProduction(61);
        EnphaseAPI.getRGMStats(61);
        EnphaseAPI.getStats(61);
        EnphaseAPI.getSummary(61);
        Test.stopTest();
    }

    public static String energyLifetimeJSON =
        '{'+
        '  \"system_id\": 66,'+
        '  \"start_date\": \"2013-01-01\",'+
        '  \"meter_start_date\": \"2013-01-04\",'+
        '  \"production\": [15422,15421,17118,18505,18511,18487],'+
        '  \"micro_production\": [15422,15421,17118,18513,18520,18494],'+
        '  \"meter_production\": [0,0,11388,18505,18511,18487],'+
        '  \"meta\": {\"status\": \"normal\", \"last_report_at\": 1445619615, \"last_energy_at\": 1445619033, \"operational_at\": 1357023600}'+
        '}';

    static testMethod void testEnergyLifetimeParse() {
        EnphaseEnergyLifetime obj = EnphaseEnergyLifetime.parse(energyLifetimeJSON);
        System.assert(obj != null);
    }

    public static String errorJSON =
        '{\"errorCode\": 7, \"errorMessages\": [\"Data temporarily unavailable.\"]}';

    static testMethod void testErrorParse() {
        EnphaseError obj = EnphaseError.parse(errorJSON);
        System.assert(obj != null);
    }

    public static String inventoryJSON =
        '{ \"system_id\":1765,'+
        '  \"inverters\": ['+
        '     {\"sn\": \"123456789123\", \"model\": \"M215\"},'+
        '     {\"sn\": \"123455589199\", \"model\": \"M215\"}'+
        '  ],'+
        '  \"meters\": ['+
        '     {\"sn\": \"999111222333\", \"manufacturer\": \"GE\", \"model\": \"I-210+\"}'+
        '  ]'+
        '}';
    
    static testMethod void testInventoryParse() {
        EnphaseInventory obj = EnphaseInventory.parse(inventoryJSON);
        System.assert(obj != null);
    }

    public static String rgmStatsJSON =
        '{'+
        '  \"system_id\": 1765, '+
        '  \"total_devices\": 1, '+
        '  \"meta\": {\"status\": \"normal\", \"last_report_at\": 1445619615, \"last_energy_at\": 1445619033, \"operational_at\": 1357023600},'+
        '  \"intervals\":['+
        '    {\"end_at\": 1384122700, \"wh_del\": 0, \"devices_reporting\": 1},'+
        '    {\"end_at\": 1384123600, \"wh_del\": 0, \"devices_reporting\": 1},'+
        '    {\"end_at\": 1384124500, \"wh_del\": 15, \"devices_reporting\": 1},'+
        '    {\"end_at\": 1384125400, \"wh_del\": 21, \"devices_reporting\": 1},'+
        '    {\"end_at\": 1384126300, \"wh_del\": 34, \"devices_reporting\": 1}'+
        '  ]'+
        '}';
    
    static testMethod void testRGMStatsParse() {
        EnphaseRGMStats obj = EnphaseRGMStats.parse(rgmStatsJSON);
        System.assert(obj != null);
    }

    public static String summaryJSON =
        '{\"system_id\":67,\"modules\":35,\"size_w\":6650,\"current_power\":4524,\"energy_today\":11255,\"energy_lifetime\":11286828,\"summary_date\":\"2016-08-15\",\"source\":\"meter\",\"status\":\"normal\",\"operational_at\":1201362300,\"last_report_at\":1471293045,\"last_interval_end_at\":1471293000}';

    static testMethod void testSummaryParse() {
        EnphaseSummary obj = EnphaseSummary.parse(summaryJSON);
        System.assert(obj != null);
    }

    public static String envoysJSON =
        '{'+
            '  \"system_id\": 67,'+
            '  \"envoys\": ['+
            '    {'+
            '      \"envoy_id\": 512,'+
            '      \"last_report_at\": 1308008107,'+
            '      \"name\": \"Envoy 010731000003\",'+
            '      \"part_number\": \"800-00002-r00\",'+
            '      \"serial_number\": \"010731000003\",'+
            '      \"status\": \"normal\"'+
            '    },'+
            '    {'+
            '      \"envoy_id\": 841,'+
            '      \"last_report_at\": null,'+
            '      \"name\": \"Envoy 010814000001\",'+
            '      \"part_number\": \"910-10000-r01\",'+
            '      \"serial_number\": \"010814000001\",'+
            '      \"status\": \"normal\"'+
            '    }'+
            '  ]'+
            '}';

    static testMethod void testEnvoysParse() {
        EnphaseEnvoys obj = EnphaseEnvoys.parse(envoysJSON);
        System.assert(obj != null);
    }

    public static String indexJSON =
        '{'+
        '  \"systems\": ['+
        '    {'+
        '      \"system_id\": 67,'+
        '      \"system_name\": \"Eich Residence\",'+
        '      \"system_public_name\": \"Eich Residence\",'+
        '      \"status\": \"normal\",'+
        '      \"timezone\": \"America/Los_Angeles\",'+
        '      \"country\": \"US\",'+
        '      \"state\": \"CA\",'+
        '      \"city\": \"Sebastopol\",'+
        '      \"postal_code\": \"95472\",'+
        '      \"connection_type\": \"ethernet\",'+
        '      \"meta\": {\"status\": \"normal\", \"last_report_at\": 1445619615, \"last_energy_at\": 1445619033, \"operational_at\": 1357023600}'+
        '    },'+
        '    {'+
        '      \"system_id\": 72,'+
        '      \"system_name\": \"Sample Residence\",'+
        '      \"system_public_name\": \"Sample Residence\",'+
        '      \"status\": \"normal\",'+
        '      \"timezone\": \"America/Los_Angeles\",'+
        '      \"country\": \"US\",'+
        '      \"state\": \"CA\",'+
        '      \"city\": \"Placerville\",'+
        '      \"postal_code\": \"95667\",'+
        '      \"connection_type\": \"ethernet\",'+
        '      \"meta\": {\"status\": \"comm\", \"last_report_at\": 1449959488, \"last_energy_at\": 1449945104, \"operational_at\": 1418912581}'+
        '    }'+
        '  ],'+
        '  \"next\": \"4e7a453d0a\"'+
        '}';

    static testMethod void testIndexParse() {
        EnphaseIndex obj = EnphaseIndex.parse(indexJSON);
        System.assert(obj != null);
    }

    public static String monthlyProductionJSON =
        '{'+
        '  \"system_id\": 66,'+
        '  \"start_date\": \"2011-07-01\",'+
        '  \"end_date\": \"2011-07-31\",'+
        '  \"production_wh\": 208435,'+
        '  \"meter_readings\": [{\"serial_number\": \"123123123123\", \"start\": 196077, \"end\": 404512}],'+
        '  \"meta\": {\"status\": \"normal\", \"last_report_at\": 1445619615, \"last_energy_at\": 1445619033, \"operational_at\": 1357023600}'+
        '}';

    static testMethod void testMonthlyProductionParse() {
        EnphaseMonthlyProduction r = EnphaseMonthlyProduction.parse(monthlyProductionJSON);
        System.assert(r != null);

        String json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        EnphaseMonthlyProduction.Meta objMeta = new EnphaseMonthlyProduction.Meta(System.JSON.createParser(json));
        System.assert(objMeta != null);
        System.assert(objMeta.status == null);
        System.assert(objMeta.last_report_at == null);
        System.assert(objMeta.last_energy_at == null);
        System.assert(objMeta.operational_at == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        EnphaseMonthlyProduction.Meter_readings objMeter_readings = new EnphaseMonthlyProduction.Meter_readings(System.JSON.createParser(json));
        System.assert(objMeter_readings != null);
        System.assert(objMeter_readings.serial_number == null);
        System.assert(objMeter_readings.start == null);
        System.assert(objMeter_readings.end_Z == null);

        json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
        EnphaseMonthlyProduction objRoot = new EnphaseMonthlyProduction(System.JSON.createParser(json));
        System.assert(objRoot != null);
        System.assert(objRoot.system_id == null);
        System.assert(objRoot.start_date == null);
        System.assert(objRoot.end_date == null);
        System.assert(objRoot.production_wh == null);
        System.assert(objRoot.meter_readings == null);
        System.assert(objRoot.meta == null);
    }

    public static String statsJSON =
        '{'+
        '  \"system_id\":1765, '+
        '  \"total_devices\":31, '+
        '  \"meta\": {\"status\": \"normal\", \"last_report_at\": 1445619615, \"last_energy_at\": 1445619033, \"operational_at\": 1357023600},'+
        '  \"intervals\":['+
        '    {\"end_at\":1381496400, \"powr\":173, \"enwh\":14, \"devices_reporting\":27},'+
        '    {\"end_at\":1381496700, \"powr\":258, \"enwh\":22, \"devices_reporting\":31},'+
        '    {\"end_at\":1381497000, \"powr\":308, \"enwh\":26, \"devices_reporting\":31},'+
        '    {\"end_at\":1381497300, \"powr\":386, \"enwh\":32, \"devices_reporting\":31},'+
        '    {\"end_at\":1381497600, \"powr\":476, \"enwh\":40, \"devices_reporting\":31}'+
        '  ]'+
        '}';

    static testMethod void testStatsParse() {
        EnphaseStats obj = EnphaseStats.parse(statsJSON);
        System.assert(obj != null);
    }
}
