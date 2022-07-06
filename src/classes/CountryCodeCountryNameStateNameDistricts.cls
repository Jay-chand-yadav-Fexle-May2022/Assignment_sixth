/**
*  Description     :  Insert the country code , name, state and districts  and find specific district
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  07/04/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public with sharing class CountryCodeCountryNameStateNameDistricts {
    
    /**
    *   @description    :  Insert country code, name, state and district. Use list and Maps.
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 04/07/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void findDistrictName(String countryCode, String countryName_1, String  stateName, String startWithChar) {

        Map<String, Map<String, Map<String, List<String>>>> countryCodeNameStateAndDistrict = new Map<String, Map<String, Map<String, List<String>>>>();

        // Add district on list
        List<String> district = new List<String>{'Agra', 'Aligarh', 'Prayagraj', 'Azamgarh', 'Ballia', 'Barabanki', 'Bareilly','Chitrakoot',  'Fatehpur', 'Ghaziabad', 'Gorakpur', 'Jhansi', 'Kanpur', 'Lucknow', 'Saharanpur', 'Sant kabir nagar', 'Sitapur', 'Shamli', 'Sambhal', 'Sultanpur', 'siddharthnagar', 'Unnao', 'Varanasi', 'Amethi', 'Bagpat'};

        List<String> district_1 =  new List<String>{'Anuppur', 'Satna', 'Ujjain', 'Indore'};
        
        List<String> district_2 = new List<String>{'Ahmednagar','Mumbai','Pune','Sindhudurg','Solapur','Beed'};

        List<String> district_3 =  new List<String>{'Huelva', 'Cádiz', 'Sevilla', 'Málaga', 'Granada', 'Almería'};

        List<String> district_4 =  new List<String>{'Barcelona', 'Girona', 'Lleida', 'Tarragona'};

        List<String> district_5 =  new List<String>{'Krakau', 'Sandomir', 'Lublin', 'Belz', 'Red Ruthenia', 'Podolia'};

        List<String> district_6 =  new List<String>{'Arundel', 'Bognor Regis', 'Littlehampton'};

        List<String> district_7 =  new List<String>{'Dhanusha' , 'Madhesh'};

        List<String> district_8 = new List<String>{'Dolpa', 'Humla', 'Taplejung', 'Gorkha'};
        
        // Add district on map in state key
        Map<String, List<String>> state = new Map<String, List<String>>();
        state.put('Uttar Pradesh', district);
        state.put('Madhya Pradesh', district_1);
        state.put('Maharashtra', district_2);

        Map<String, List<String>> state_2 = new Map<String, List<String>>();
        state_2.put('Andalusia', district_3);
        state_2.put('Catalonia', district_4);
        state_2.put('Galicia', district_5);

        Map<String, List<String>> state_3 = new Map<String, List<String>>();
        state_3.put('Arun Kshetra', district_6);
        state_3.put('Janakpur Kshetra', district_7);
        state_3.put('Kathmandu', district_8);

        // Add states on map in countries key 
        Map<String, Map<String, List<String>>> countryName = new Map<String, Map<String, List<String>>>();
        countryName.put('India', state);

        Map<String, Map<String, List<String>>> countryName_2 = new Map<String, Map<String, List<String>>>();
        countryName_2.put('Spain', state_2);

        Map<String, Map<String, List<String>>> countryName_3 = new Map<String, Map<String, List<String>>>();
        countryName_3.put('Nepal', state_3);

        // Add country with country code on map
        countryCodeNameStateAndDistrict.put('+91', countryName);
        countryCodeNameStateAndDistrict.put('+34', countryName_2);
        countryCodeNameStateAndDistrict.put('+977', countryName_3);

        findCountryCodeNameStateAndDistricts(countryCodeNameStateAndDistrict, countryCode,  countryName_1, stateName, startWithChar);

    }

    /**
    *   @description    :  Find the country code , name, state, and districts who start with any 
                           specific character which insert by user and length should be greater than how much user want.
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 04/07/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void findCountryCodeNameStateAndDistricts(Map<String, Map<String, Map<String, List<String>>>> countryCodeNameStateAndDistrict, String countryCode, String countryName_1, String  stateName, String startWithChar) {

        // Find the code, country name, states and districts
        if(!countryCodeNameStateAndDistrict.isEmpty()) {
            for(String code : countryCodeNameStateAndDistrict.keySet()) {
                if(code.equals(countryCode)) {
                
                    if(!countryCodeNameStateAndDistrict.get(code).isEmpty()) {
                        for(String countryNames : countryCodeNameStateAndDistrict.get(code).keySet()) {
                            if(countryNames.equals(countryName_1)) {

                                if(!countryCodeNameStateAndDistrict.get(code).get(countryNames).isEmpty()) {
                                    for(String stateNames : countryCodeNameStateAndDistrict.get(code).get(countryNames).keySet()) {
                                        if(stateNames.equals(stateName)) {  

                                            if(!countryCodeNameStateAndDistrict.get(code).get(countryNames).isEmpty()) {
                                                for(String districtName : countryCodeNameStateAndDistrict.get(code).get(countryNames).get(stateNames)) {  

                                                    if(districtName.toUppercase().startsWith(startWithChar.toUppercase()) && districtName.length() >= 5) {
                                                        System.debug(districtName);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
