/**
*  Description     :  Country states district wrapper class which is fill by CountryJSONmethods
*                      its hold all the records.
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/15/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
public class CountryStateJSONGenerator {
    
    public List<String> countryList{get; set;}

    public class States{
        public string stateName{get; set;}
        public List<Districts> districts{get; set;}
    }

    public class Districts{
        public string districtName{get; set;}
    }

    public class Country{
        public String countryName{get; set;}
        public String countryCode{get; set;}
        public Integer totalStatesNumber{get; set;}
        public Integer totalDistricts{get; set;}
        public List<States> states{get; set;}
    }
}