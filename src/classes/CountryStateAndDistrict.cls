/**
*  Description     :  Retrieve the district which is start from s and length is greater than 8
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/30/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public with sharing class CountryStateAndDistrict {
    
    public static void findDistrictName() {

        Map<String, Map<String, List<String>>> country = new Map<String, Map<String, List<String>>>();

        // District  for Uttar Pradesh 
        List<String> district = new List<String>{'Agra', 'Aligarh', 'Prayagraj', 'Azamgarh', 'Ballia', 'Barabanki', 'Bareilly','Chitrakoot',  'Fatehpur', 'Ghaziabad', 'Gorakpur', 'Jhansi', 'Kanpur', 'Lucknow', 'Saharanpur', 'Sant kabir nagar', 'Sitapur', 'Shamli', 'Sambhal', 'Sultanpur', 'Siddharthnagar', 'Unnao', 'Varanasi', 'Amethi', 'Bagpat'};
        
        Map<String, List<String>> state = new Map<String, List<String>>();
        state.put('Uttar Pradesh', district);

        country.put('India', state);

        for(String country_1 : country.keySet()) {
            if(country_1.equals('India')) {

                for(String state_1 : state.keySet()) {
                    if(state_1.equals('Uttar Pradesh')) {

                        for(String district_1 : district) {
                            Integer[] chars = district_1.getChars();

                            if((chars[0] == 83 || chars[0] == 115) && district_1.length() > 8) {
                                System.debug(district_1);
                            }
                        }
                    }
                }
            }
        }
    }

    /**
    *   @description    :  print country with state and district
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 30/06/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void countryWithStateWithDistrict() {

        Map<String, Map<String, List<String>>> mapWithCountryWithStateWithDistrict = new Map<String, Map<String, List<String>>>();

        // Add district in key
        Map<String, List<String>> mapDistrictWithState = new Map<String, List<String>>{
            'Madhya Pradesh' => new List<String>{'Anuppur', 'Ashoknagar', 'Balaghat', 'Betul', 'Bhopal', 'Damoh', 'Dewas', 'Gwalior', 'Indore', 'Jabalpur', 'Katni', 'Rewa', 'Sagar', 'Satna', 'Shahdol', 'Satna', 'Shajapur', 'Singrauli', 'Ujjain', 'Vidisha'},

            'Uttar Pradesh' => new List<String>{'Agra', 'Aligarh', 'Prayagraj', 'Azamgarh', 'Ballia', 'Barabanki', 'Bareilly','Chitrakoot',  'Fatehpur', 'Ghaziabad', 'Gorakpur', 'Jhansi', 'Kanpur', 'Lucknow', 'Saharanpur', 'Sant kabir nagar', 'Sitapur', 'Shamli', 'Sambhal', 'Sultanpur', 'Siddharthnagar', 'Unnao', 'Varanasi', 'Amethi', 'Bagpat'},

            'Maharashtra' => new List<String>{'Ahmednagar',
			'Akola','Amravati','Aurangabad','Bhandara','Beed','Buldhana','Chandrapur','Dhule','Gadchiroli','Gondia','Hingoli','Jalgaon','Jalna','Kolhapur','Latur','Mumbai City','Mumbai suburban','Nandurbar','Nanded','Nagpur','Nashik','Osmanabad','Parbhani','Pune','Raigad','Ratnagiri','Sindhudurg','Sangli','Solapur','Satara','Thane','Wardha','Washim','Yavatmal'},

            'Andalusia' => new List<String>{'Huelva', 'Cádiz', 'Sevilla', 'Málaga', 'Córdoba', 'Jaén', 'Granada', 'Almería'},

            'Catalonia' => new List<String>{'Barcelona', 'Girona', 'Lleida', 'Tarragona'},

            'Galicia' => new List<String>{'Krakau', 'Sandomir', 'Lublin', 'Belz', 'Red Ruthenia', 'Podolia'},

            'Arun Kshetra' => new List<String>{'Arundel', 'Bognor Regis', 'Littlehampton'},

            'Janakpur Kshetra' => new List<String>{'Dhanusha' , 'Madhesh'},

            'Kathmandu' => new List<String>{'Dolpa', 'Humla', 'Taplejung', 'Gorkha'}
        };

        // Add state 
        Map<String, List<String>> mapStateWithCountry = new Map<String, List<String>>{
            'India' => new List<String>{'Madhya Pradesh', 'Uttar Pradesh', 'Maharashtra'},
            'Spain' => new List<String>{'Andalusia', 'Catalonia', 'Galicia'},
            'Nepal' => new List<String>{'Arun Kshetra', 'Janakpur Kshetra', 'Kathmandu'}
        };

        // Add country, state and district on map
        for(String keyOfMap : mapStateWithCountry.keySet()) {
            if(!mapWithCountryWithStateWithDistrict.containsKey(keyOfMap)) 
                mapWithCountryWithStateWithDistrict.put(keyOfMap, new Map<String, List<String>>());

            if(mapWithCountryWithStateWithDistrict.containsKey(keyOfMap)) {
                for(String state : mapStateWithCountry.get(keyOfMap)) {
                    mapWithCountryWithStateWithDistrict.get(keyOfMap).put(state, new List<String>());

                    if(mapWithCountryWithStateWithDistrict.get(keyOfMap).containsKey(state)) {
                        mapWithCountryWithStateWithDistrict.get(keyOfMap).get(state).addAll(mapDistrictWithState.get(state));
                    }
                }
            }
        }

        //System.debug(mapWithCountryWithStateWithDistrict);
        for(String key : mapWithCountryWithStateWithDistrict.keySet()) {
            System.debug(key + mapWithCountryWithStateWithDistrict.get(key));
        }        
    }
}