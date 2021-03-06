//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

public class EnphaseEnergyLifetime {

    public class Meta {
        public String status;
        public Integer last_report_at;
        public Integer last_energy_at;
        public Integer operational_at;
    }

    public Integer system_id;
    public String start_date;
    public String meter_start_date;
    public List<Integer> production;
    public List<Integer> micro_production;
    public List<Integer> meter_production;
    public Meta meta;

	
    public static EnphaseEnergyLifetime parse(String json) {
        return (EnphaseEnergyLifetime) System.JSON.deserialize(json, EnphaseEnergyLifetime.class);
    }
}