//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

public with sharing class EnphaseSummary {

    public Integer system_id;
    public Integer modules;
    public Integer size_w;
    public Integer current_power;
    public Integer energy_today;
    public Integer energy_lifetime;
    public String summary_date;
    public String source;
    public String status;
    public Integer operational_at;
    public Integer last_report_at;
    public Integer last_interval_end_at;

    public static EnphaseSummary parse(String json) {
	return (EnphaseSummary) System.JSON.deserialize(json, EnphaseSummary.class);
    }
}