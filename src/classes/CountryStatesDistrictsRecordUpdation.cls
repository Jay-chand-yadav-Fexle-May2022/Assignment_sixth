/**
*  Description     :  Fill the country, states and districts records on the map and Find out
*                     Country State and District which starts with a particular Keyword.
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/15/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
public with sharing class CountryStatesDistrictsRecordUpdation {

    public static Map<String, Map<String, List<String>>> mapWithCountryWithStateWithDistrict = new Map<String, Map<String, List<String>>>();

    public CountryStatesDistrictsRecordUpdation(String word) {

        // Call all the methods from the constructor
        //mapWithCountryWithStateWithDistrict = fillCountryStatesAndDistrictsOnMap();
        fillCountryStateDistrictMapUseSingleLoopAndSingleQuery(word);
        //findCountryStateAndDistrictStartWithParticularKeyword(word);
        updateTotalNumberOfDistrictsOnTheStateDatabase();             
        updateTotalNumberOfDistrictsAndStatesOnCountry();
        countryJSONGenerator('China');
    }

    public static Map<String, Map<String, List<String>>> fillCountryStatesAndDistrictsOnMap() {

        // Map Countries with states
        Map<String, List<String>> mapOfStateWithCountry = new Map<String, List<String>>();
        List<Country__c> listOfCountryAndStates = [
            SELECT Id, Name, (SELECT Id, Name FROM States__r) 
            FROM Country__c];

        for(Country__c country : listOfCountryAndStates) 
        {  
            List<String> ListOfStates = new List<String>();
            for(State__c stateName : country.States__r) 
            {
                ListOfStates.add(stateName.Name); 
            }
            mapOfStateWithCountry.put(country.Name, ListOfStates);
        }

        // Map States with districts
        Map<String, List<String>> mapDistrictWithState = new Map<String, List<String>>();
        List<State__c> listOfStatesAndDistricts = [
            SELECT Id, Name, (SELECT Id, Name FROM Districts__r) 
            FROM State__c];

        for(State__c states : listOfStatesAndDistricts) 
        {  
            List<String> listOfDistricts = new List<String>();
            for(District__c districtsName : states.Districts__r) 
            {
                listOfDistricts.add(districtsName.Name); 
            }
            mapDistrictWithState.put(states.Name, listOfDistricts);
        }

        // Fill country state district records on map 
        for(String key : mapOfStateWithCountry.keySet()) {
            if(!mapWithCountryWithStateWithDistrict.containsKey(key)) 
                mapWithCountryWithStateWithDistrict.put(key, new Map<String, List<String>>());

            if(mapWithCountryWithStateWithDistrict.containsKey(key)) {
                for(String state : mapOfStateWithCountry.get(key)) {
                    mapWithCountryWithStateWithDistrict.get(key).put(state, new List<String>());

                    if(mapWithCountryWithStateWithDistrict.get(key).containsKey(state)) {
                        mapWithCountryWithStateWithDistrict.get(key).get(state).addAll(mapDistrictWithState.get(state));
                    }
                }
            }
        }
        return mapWithCountryWithStateWithDistrict;
    }

    // Fill country state district usnig single map and single query and Find out Country State and District starts with a particular Keyword. this is a second way to fill tha map
    public static void fillCountryStateDistrictMapUseSingleLoopAndSingleQuery(String word) {

        List<District__c> listOfDistricts = [
            SELECT Name, State_Name__r.Name, State_Name__r.Country_Name__r.Name 
            FROM District__c];

        for(District__c district : listOfDistricts) {    
            if(!mapWithCountryWithStateWithDistrict.containsKey(district.State_Name__r.Country_Name__r.Name)) {
                mapWithCountryWithStateWithDistrict.put(district.State_Name__r.Country_Name__r.Name,
                new Map<String, List<String>>());
            }
                                                        
            if(!mapWithCountryWithStateWithDistrict.get(district.State_Name__r.Country_Name__r.Name).containsKey(district.State_Name__r.Name)) {
                mapWithCountryWithStateWithDistrict.get(district.State_name__r.Country_Name__r.Name).put(district.State_Name__r.Name, new List<String>());
            }
                                                
            if(!mapWithCountryWithStateWithDistrict.get(district.State_Name__r.Country_Name__r.Name).get(district.State_Name__r.Name).contains(district.Name)) {
                mapWithCountryWithStateWithDistrict.get(district.State_Name__r.Country_Name__r.Name).get(district.State_Name__r.Name).add(district.Name);
                
                // Find out Country State and District starts with a particular Keyword.
                if(district.State_Name__r.Country_Name__r.Name.startsWithIgnoreCase(word)) {
                    if(district.State_Name__r.Name.startsWithIgnoreCase(word)) {
                        if(district.Name.startsWithIgnoreCase(word)) {
                            System.debug(district.State_Name__r.Country_Name__r.Name + ' -> ' + district.State_Name__r.Name + ' -> ' + district.Name);
                        }
                    }
                }
            }
        }
    }

    // Find out Country State and District starts with a particular Keyword.
    public static void findCountryStateAndDistrictStartWithParticularKeyword(String word) {

        if(!mapWithCountryWithStateWithDistrict.isEmpty()) {

            for(String country_1 : mapWithCountryWithStateWithDistrict.keySet()) {
                if(country_1.startsWith(word.toUppercase())) {

                    for(String state_1 : mapWithCountryWithStateWithDistrict.get(country_1).keySet()) {             
                        if(state_1.startsWith(word.toUppercase())) {

                            for(String district_1 : mapWithCountryWithStateWithDistrict.get(country_1).get(state_1)) {
                                if(district_1.startsWith(word.toUppercase())) {
                                    System.debug(country_1 + ' -> ' + state_1 + ' -> ' + district_1);
                                }
                            }
                        }
                    }
                }
            }
        }   
    }

    // Update total number of districts on state
    public static void updateTotalNumberOfDistrictsOnTheStateDatabase() {

        List<AggregateResult> groupedResults = [
            SELECT State_Name__c, COUNT(Id) Total_Districts 
            FROM District__c 
            GROUP BY State_Name__c];

        List<State__c> listOfStates = new List<State__c>();
        for(AggregateResult aggRecord : groupedResults) {
            State__c stateObj = new State__c();
            stateObj.Id = (Id)aggRecord.get('State_Name__c');
            stateObj.Total_Number_of_Districts__c = (Integer)aggRecord.get('Total_Districts');
            listOfStates.add(stateObj);
        }
        if(!listOfStates.isEmpty()) {
            update listOfStates;
        }
    }

    // Update total number of states and sum of district on country
    public static void updateTotalNumberOfDistrictsAndStatesOnCountry() {

        List<AggregateResult> groupedResults = [
            SELECT Country_Name__c, COUNT(Id) Total_States, SUM(Total_Number_of_Districts__c) Total_Districts 
            FROM State__c
            GROUP BY Country_Name__c];

        List<Country__c> listOfCountry = new List<Country__c>();
        for(AggregateResult aggRecord : groupedResults) {
            Country__c country = new Country__c();
            country.id = (Id)aggRecord.get('Country_Name__c');
            country.Total_Number_of_States__c = (Integer)aggRecord.get('Total_States');
            country.Total_Number_of_Districts__c = (Decimal)aggRecord.get('Total_Districts');
            listofCountry.add(country);
        }
        if(!listOfCountry.isEmpty()) {
            update listOfCountry;
        }
    }

    // JSON Generator
    public static void countryJSONGenerator(String countryName) {

        List<Country__c> countries = [
            SELECT Name, Total_Number_of_Districts__c, Total_Number_of_States__c, Country_Code__c, Country_JSON_Data__c 
            FROM Country__c
            WHERE Name =: countryName ];

        if(!countries.isEmpty()) {
            List<CountryStateJSONGenerator.States> states = new List<CountryStateJSONGenerator.States>();
            if(!mapWithCountryWithStateWithDistrict.get(countryName).keySet().isEmpty()){
                for(String state: mapWithCountryWithStateWithDistrict.get(countryName).keySet()){
                    CountryStateJSONGenerator.States statesWrapper = new CountryStateJSONGenerator.States();
                    statesWrapper.stateName = state;
                    List<CountryStateJSONGenerator.Districts> Districts = new List<CountryStateJSONGenerator.Districts>();
                    if(!mapWithCountryWithStateWithDistrict.get(countryName).get(state).isEmpty()){
                        for(String dis: mapWithCountryWithStateWithDistrict.get(countryName).get(state)){
                            CountryStateJSONGenerator.Districts District = new CountryStateJSONGenerator.Districts();
                            District.districtName = dis;
                            Districts.add(District);
                        }
                    }
                    statesWrapper.districts = Districts;
                    states.add(statesWrapper);
                }
            }
            CountryStateJSONGenerator.Country countryWrapper = new CountryStateJSONGenerator.Country();
            countryWrapper.countryName = countries[0].Name;
            countryWrapper.countryCode = countries[0].Country_Code__c;
            countryWrapper.totalStatesNumber = (Integer)countries[0].Total_Number_of_States__c;
            countryWrapper.totalDistricts = (Integer)countries[0].Total_Number_of_Districts__c;
            countryWrapper.states = states;

            System.debug(countryWrapper);
            System.debug(JSON.serialize(countryWrapper));
   
            countries[0].Country_JSON_Data__c = JSON.serialize(countryWrapper);
            update countries[0];
        }
    } 
}