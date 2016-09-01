//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

public class EnphaseStats {

    public class Intervals {
        public Integer end_at;
        public Integer powr;
        public Integer enwh;
        public Integer devices_reporting;
    }

    public class Meta {
        public String status;
        public Integer last_report_at;
        public Integer last_energy_at;
        public Integer operational_at;
    }

    public Integer system_id;
    public Integer total_devices;
    public Meta meta;
    public List<Intervals> intervals;

	
    public static EnphaseStats parse(String json) {
        return (EnphaseStats) System.JSON.deserialize(json, EnphaseStats.class);
    }
}