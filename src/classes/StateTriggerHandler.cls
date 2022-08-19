/**
*  Description     :  Whenever DML will be perform on State object after that total number of district and total number of
*                     state will be increase and decrease on country.
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  08/19/2022
*
*  Revision Logs   :  V1.0 - Created - Jay Chand Yadav
**/
public class StateTriggerHandler {
	// Increment Total number of state on country object during insertion of new state
    public static void insertState(List<State__c> newList){
		
        Map<Id, Integer> mapOfCountryIds = new Map<Id, Integer>();
        for(State__c state : newList){
            if(mapOfCountryIds.containsKey(state.Country_Name__c)){
                mapOfCountryIds.put(state.Country_Name__c, mapOfCountryIds.get(state.Country_Name__c) + 1);
            }else{
                mapOfCountryIds.put(state.Country_Name__c, 1);
            }
		}       
        List<Country__c> listOfCountries = [
            Select Id, Name, Total_Number_of_States__c 
            From Country__c 
            Where Id =: mapOfCountryIds.keySet()];
        List<Country__c> updateCountryList = new List<Country__c>();
        for(Country__c country : listOfCountries){
            Country__c country_1 = new Country__c();
            country_1.Id = country.Id;
            if(country.Total_Number_of_States__c != null){
                country_1.Total_Number_of_States__c = country.Total_Number_of_States__c + mapOfCountryIds.get(country.id);
            }else{
                country.Total_Number_of_States__c = 0;
                country_1.Total_Number_of_States__c = country.Total_Number_of_States__c + mapOfCountryIds.get(country.id);
            }
            updateCountryList.add(country_1);
        }
        if(!updateCountryList.isEmpty()){
            update updateCountryList;
		}
        updateCountryJSONdata(Trigger.new, Trigger.old);
    }
    // Decrement Total number of state on country object during deletion of old state
    public static void deleteState(List<State__c> oldList){

        Map<Id, Integer> mapOfCountryIdsWithTotalNumState = new Map<Id, Integer>();
        Map<Id, Decimal> mapOfCountryIdsWithTotalNumDist = new Map<Id, Decimal>();
        for(State__c state : oldList){
            if(mapOfCountryIdsWithTotalNumState.containsKey(state.Country_Name__c)){
                 mapOfCountryIdsWithTotalNumState.put(state.Country_Name__c, mapOfCountryIdsWithTotalNumState.get(state.Country_Name__c) + 1);
            }else{
                mapOfCountryIdsWithTotalNumState.put(state.Country_Name__c, 1);
            }
		}
        for(State__c state : oldList){
            if(mapOfCountryIdsWithTotalNumDist.containsKey(state.Country_Name__c)){              
                mapOfCountryIdsWithTotalNumDist.put(state.Country_Name__c, mapOfCountryIdsWithTotalNumDist.get(state.Country_Name__c) + state.Total_Number_of_Districts__c);
            }else{                
                mapOfCountryIdsWithTotalNumDist.put(state.Country_Name__c, state.Total_Number_of_Districts__c);
            }
		}       
        List<Country__c> listOfCountry = [
            Select Id, Name, Total_Number_of_States__c, Total_Number_of_Districts__c 
            From Country__c 
            Where Id =: mapOfCountryIdsWithTotalNumState.keySet()];
        List<Country__c> listOfUpdateCountry = new List<Country__c>();
        for(Country__c country : listOfCountry){
            Country__c countryObj = new Country__c();
            countryObj.Id = country.Id;
            countryObj.Total_Number_of_States__c = country.Total_Number_of_States__c - mapOfCountryIdsWithTotalNumState.get(country.Id);
            if(mapOfCountryIdsWithTotalNumDist.get(country.Id) != null){
                countryObj.Total_Number_of_Districts__c = country.Total_Number_of_Districts__c - mapOfCountryIdsWithTotalNumDist.get(country.Id);
            }
            listOfUpdateCountry.add(countryObj);
        }
        if(!listOfUpdateCountry.isEmpty()){
            update listOfUpdateCountry;
        }
        updateCountryJSONdata(Trigger.new, Trigger.old);
    }
    // Updata state Whenever we will update state one country to another country then it will work
    public static void updateState(List<State__c> newList, List<State__c> oldList){
        if(newList[0].Country_Name__c != oldList[0].Country_Name__c){
            Map<Id, Integer> mapOfCountryIdsWithTotalNumState = new Map<Id, Integer>();
            Map<Id, Decimal> mapOfCountryIdsWithTotalNumDist = new Map<Id, Decimal>();
            for(State__c state : oldList){
                if(mapOfCountryIdsWithTotalNumState.containsKey(state.Country_Name__c)){
                     mapOfCountryIdsWithTotalNumState.put(state.Country_Name__c, mapOfCountryIdsWithTotalNumState.get(state.Country_Name__c) + 1);
                }else{
                    mapOfCountryIdsWithTotalNumState.put(state.Country_Name__c, 1);
                }
            }
            for(State__c state : oldList){
                if(mapOfCountryIdsWithTotalNumDist.containsKey(state.Country_Name__c)){              
                    mapOfCountryIdsWithTotalNumDist.put(state.Country_Name__c, mapOfCountryIdsWithTotalNumDist.get(state.Country_Name__c) + state.Total_Number_of_Districts__c);
                }else{                
                    mapOfCountryIdsWithTotalNumDist.put(state.Country_Name__c, state.Total_Number_of_Districts__c);
                }
            }
            // Decrement state and district on old country
            List<Country__c> listOfCountry = [
                Select Id, Name, Total_Number_of_States__c, Total_Number_of_Districts__c 
                From Country__c 
                Where Id =: mapOfCountryIdsWithTotalNumState.keySet()];
            List<Country__c> listOfUpdateCountry = new List<Country__c>();
            for(Country__c country : listOfCountry){
                Country__c countryObj = new Country__c();
                countryObj.Id = country.Id;
                if(country.Total_Number_of_States__c != null){
                    countryObj.Total_Number_of_States__c = country.Total_Number_of_States__c - mapOfCountryIdsWithTotalNumState.get(country.id);
                }
                if(country.Total_Number_of_Districts__c != null){
                    countryObj.Total_Number_of_Districts__c = country.Total_Number_of_Districts__c - mapOfCountryIdsWithTotalNumDist.get(country.id);
                }
                listOfUpdateCountry.add(countryObj);
            }
            if(!listOfUpdateCountry.isEmpty()){
                update listOfUpdateCountry;
            }
            // Increment state and district on new country
            Map<Id, Integer> mapOfCountryIdsWithTotalNumState_1 = new Map<Id, Integer>();
            Map<Id, Decimal> mapOfCountryIdsWithTotalNumDist_1 = new Map<Id, Decimal>();
            for(State__c state : newList){
                if(mapOfCountryIdsWithTotalNumState_1.containsKey(state.Country_Name__c)){
                     mapOfCountryIdsWithTotalNumState_1.put(state.Country_Name__c, mapOfCountryIdsWithTotalNumState_1.get(state.Country_Name__c) + 1);
                }else{
                    mapOfCountryIdsWithTotalNumState_1.put(state.Country_Name__c, 1);
                }
            }
            for(State__c state : newList){
                if(mapOfCountryIdsWithTotalNumDist_1.containsKey(state.Country_Name__c)){              
                    mapOfCountryIdsWithTotalNumDist_1.put(state.Country_Name__c, mapOfCountryIdsWithTotalNumDist_1.get(state.Country_Name__c) + state.Total_Number_of_Districts__c);
                }else{                
                    mapOfCountryIdsWithTotalNumDist_1.put(state.Country_Name__c, state.Total_Number_of_Districts__c);
                }
            }
            List<Country__c> listOfCountry_1 = [
                Select Id, Name, Total_Number_of_States__c, Total_Number_of_Districts__c 
                From Country__c 
                Where Id =: mapOfCountryIdsWithTotalNumState_1.keySet()];
            List<Country__c> listOfUpdateCountry_1 = new List<Country__c>();
            for(Country__c country : listOfCountry_1){
                Country__c countryObj = new Country__c();
                countryObj.Id = country.Id;
                if(country.Total_Number_of_States__c != null){
                    countryObj.Total_Number_of_States__c = country.Total_Number_of_States__c + mapOfCountryIdsWithTotalNumState_1.get(country.id);
                }else{
                    country.Total_Number_of_States__c = 0;
                    countryObj.Total_Number_of_States__c = country.Total_Number_of_States__c + mapOfCountryIdsWithTotalNumState_1.get(country.id);
                }
                if(country.Total_Number_of_Districts__c != null){
                    countryObj.Total_Number_of_Districts__c = country.Total_Number_of_Districts__c + mapOfCountryIdsWithTotalNumDist_1.get(country.id);
                }else{
                    country.Total_Number_of_Districts__c = 0;
                     countryObj.Total_Number_of_Districts__c = country.Total_Number_of_Districts__c + mapOfCountryIdsWithTotalNumDist_1.get(country.id);
                }
                listOfUpdateCountry_1.add(countryObj);
            }
            if(!listOfUpdateCountry_1.isEmpty()){
                update listOfUpdateCountry_1;
            }
        }
        updateCountryJSONdata(newList, oldList);          
    }
    // Update JSON DATA on Country Object after performing DMl
    public static void updateCountryJSONdata(List<State__c> newList, List<State__c> oldList){

        Map<String, Map<String, List<String>>> mapWithCountryWithStateWithDistrict = new Map<String, Map<String, List<String>>>();
        Set<String> countryNames = new Set<String>();
        if(newList != null){
            for(State__c state : newList){
                countryNames.add(state.Country_Name__c);
            }
        }
        if(oldList != null){
            for(State__c state : oldList){
                countryNames.add(state.Country_Name__c);
            }
        }
        List<District__c> listOfDistricts = [
            SELECT Name, State_Name__r.Name, State_Name__r.Country_Name__r.Name 
            FROM District__c 
            Where State_Name__r.Country_Name__r.Id =: countryNames];
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
            }
        }
        List<Country__c> countries = [
            SELECT Name, Total_Number_of_Districts__c, Total_Number_of_States__c, Country_Code__c, Country_JSON_Data__c 
            FROM Country__c
            WHERE Id =: countryNames];
        List<Country__c> listOfCountries = new List<Country__c>();
        if(!countries.isEmpty()) {
            for(Country__c countriesRecord : countries){
                List<CountryStateJSONGenerator.States> states = new List<CountryStateJSONGenerator.States>();
                if(!mapWithCountryWithStateWithDistrict.get(countriesRecord.name).keySet().isEmpty()){
                    for(String state: mapWithCountryWithStateWithDistrict.get(countriesRecord.name).keySet()){
                        CountryStateJSONGenerator.States statesWrapper = new CountryStateJSONGenerator.States();
                        statesWrapper.stateName = state;
                        List<CountryStateJSONGenerator.Districts> Districts = new List<CountryStateJSONGenerator.Districts>();
                        if(!mapWithCountryWithStateWithDistrict.get(countriesRecord.name).get(state).isEmpty()){
                            for(String dis: mapWithCountryWithStateWithDistrict.get(countriesRecord.name).get(state)){
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
                countryWrapper.countryName = countriesRecord.Name;
                countryWrapper.countryCode = countriesRecord.Country_Code__c;
                countryWrapper.totalStatesNumber = (Integer)countriesRecord.Total_Number_of_States__c;
                countryWrapper.totalDistricts = (Integer)countriesRecord.Total_Number_of_Districts__c;
                countryWrapper.states = states;
                System.debug(countryWrapper);
                System.debug(JSON.serialize(countryWrapper));   
                countriesRecord.Country_JSON_Data__c = JSON.serialize(countryWrapper);
                listOfCountries.add(countriesRecord);
            }           
        }
        if(!listOfCountries.isEmpty())
            update listOfCountries;
    }
}