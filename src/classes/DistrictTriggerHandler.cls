/**
*  Description     :  Whenever DML will be perform on district object after that total number of district will be increase
*                     and decrease on state and country.
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  08/19/2022
*
*  Revision Logs   :  V1.0 - Created - Jay Chand Yadav
**/
public with sharing class DistrictTriggerHandler {
    // Insert district on state and Update district one state to another state & Delete district from state
    public static void insertDeleteAndUpdateDistrict(List<District__c> newList, List<District__c> oldList) {
        // Insert district on state and create district on another state during updation of state name
        if(newList != null){
            Map<Id, Integer> mapOfStateId = new Map<Id, Integer>();
            for(District__c dist : newList){
                if(mapOfStateId.containsKey(dist.State_Name__c)){
                    mapOfStateId.put(dist.State_Name__c, mapOfStateId.get(dist.State_Name__c) + 1);
                }
                else{
                    mapOfStateId.put(dist.State_Name__c, 1);
                }
            }
            List<State__c> listOfStates = [
                Select Id, Total_Number_of_Districts__c, Country_Name__c 
                From State__c 
                Where Id =: mapOfStateId.keySet()];
            List<State__c> listOfState = new List<State__c>();  
            Map<Id, Integer> mapOfCountryIds = new Map<Id, Integer>();
            // Increment Total number of District on  State object
            if(!listOfStates.isEmpty()){
                for(State__c lstState : listOfStates){
                    State__c state = new State__c();
                    state.id = lstState.id;
                    if(lstState.Total_Number_of_Districts__c != null){
                        state.Total_Number_of_Districts__c = lstState.Total_Number_of_Districts__c + mapOfStateId.get(lstState.id);
                    }
                    else{
                        lstState.Total_Number_of_Districts__c = 0;
                        state.Total_Number_of_Districts__c = lstState.Total_Number_of_Districts__c + mapOfStateId.get(lstState.id);
                    }               
                    listOfState.add(state);
                    
                    if(mapOfCountryIds.containsKey(lstState.Country_Name__c)){
                        mapOfCountryIds.put(lstState.Country_Name__c, mapOfCountryIds.get(lstState.Country_Name__c) + mapOfStateId.get(lstState.id));
                    }
                    else{
                        mapOfCountryIds.put(lstState.Country_Name__c, mapOfStateId.get(lstState.id));
                    }
                }               
                // Increment Total number of District on  Country object
                List<Country__c> listOfCountry = [
                    Select Id, Total_Number_of_Districts__c 
                    From Country__c 
                    Where Id =: mapOfCountryIds.keySet()];
                List<Country__c> listOfUpdatedCountry = new List<Country__c>();
                for(Country__c lstCountry : listOfCountry){
                    Country__c country = new Country__c();
                    country.id = lstCountry.id;
                    if(lstCountry.Total_Number_of_Districts__c != null){
                        country.Total_Number_of_Districts__c = lstCountry.Total_Number_of_Districts__c + mapOfCountryIds.get(lstCountry.id);
                    }else{
                        lstCountry.Total_Number_of_Districts__c = 0;
                        country.Total_Number_of_Districts__c = lstCountry.Total_Number_of_Districts__c + mapOfCountryIds.get(lstCountry.id);
                    }               
                    listOfUpdatedCountry.add(country);
                }
                // Update on country Country
                if(!listOfUpdatedCountry.isEmpty()){
                    update listOfUpdatedCountry;
                } 
                // Update on state
                if(!listOfState.isEmpty()){
                    update listOfState;
                }
            } 
        }
        //  For Update and delete Operation
        if(oldList != null){
            // Decrement Total number of District on old state object
            Map<Id, Integer> mapOfStateOldListId = new Map<Id, Integer>();
            for(District__c dist : oldList){
                if(mapOfStateOldListId.containsKey(dist.State_Name__c)){
                    mapOfStateOldListId.put(dist.State_Name__c, mapOfStateOldListId.get(dist.State_Name__c) + 1);
                }
                else{
                    mapOfStateOldListId.put(dist.State_Name__c, 1);
                }
            }
            List<State__c> listOfStates_1 = [
                Select Id, Total_Number_of_Districts__c, Country_Name__c 
                From State__c 
                Where Id =: mapOfStateOldListId.keySet()];
            List<State__c> listOfState_1 = new List<State__c>();
            Map<Id, Integer> mapOfCountryIds_1 = new Map<Id, Integer>();
            if(!listOfStates_1.isEmpty()){
                for(State__c lstState : listOfStates_1){
                    State__c state = new State__c();
                    state.id = lstState.id;
                    if(lstState.Total_Number_of_Districts__c != null){
                        state.Total_Number_of_Districts__c = lstState.Total_Number_of_Districts__c - mapOfStateOldListId.get(lstState.id);
                    }              
                    listOfState_1.add(state);     
                    
                    if(mapOfCountryIds_1.containsKey(lstState.Country_Name__c)){
                        mapOfCountryIds_1.put(lstState.Country_Name__c, mapOfCountryIds_1.get(lstState.Country_Name__c) + mapOfStateOldListId.get(lstState.id));
                    }
                    else{
                        mapOfCountryIds_1.put(lstState.Country_Name__c, mapOfStateOldListId.get(lstState.id));
                    }
                }
            }                  
            // Decrement Total number of District on old Country object
            List<Country__c> listOfCountry_1 = [
                Select Id, Total_Number_of_Districts__c 
                From Country__c 
                Where Id =: mapOfCountryIds_1.keySet()];               
            List<Country__c> listOfUpdatedCountry_1 = new List<Country__c>();
            for(Country__c lstCountry : listOfCountry_1){
                Country__c country = new Country__c();
                country.id = lstCountry.id;
                if(lstCountry.Total_Number_of_Districts__c != null){
                    country.Total_Number_of_Districts__c = lstCountry.Total_Number_of_Districts__c - mapOfCountryIds_1.get(lstCountry.id);
                }      
                listOfUpdatedCountry_1.add(country);
            }
            // Update on country
            if(!listOfUpdatedCountry_1.isEmpty()){
                update listOfUpdatedCountry_1;
            }  
            // Update on state
            if(!listOfState_1.isEmpty()){
                update listOfState_1;
            }           
        }
        updateStateJSONdata(Trigger.new, Trigger.old);
    }  
    // Update State JSON Data
     public static void updateStateJSONdata(List<District__c> newList, List<District__c> oldList){

        Map<String, List<String>> mapWithStateAndDistrict = new Map<String, List<String>>();
        Set<String> stateNames = new Set<String>();
        if(newList != null){
            for(District__c newDist : newList){
                stateNames.add(newDist.State_name__c);
            }
        }
        if(oldList != null){
            for(District__c oldDist : oldList){
                stateNames.add(oldDist.State_name__c);
            }
        }
        List<District__c> listOfDistricts = [
            SELECT Name, State_Name__r.Name 
            FROM District__c Where State_Name__r.Id =: stateNames];

        for(District__c district : listOfDistricts) {    

            if(!mapWithStateAndDistrict.containsKey(district.State_Name__r.Name)){
                mapWithStateAndDistrict.put(district.State_Name__r.Name,
                new List<String>());
            }

            if(!mapWithStateAndDistrict.get(district.State_Name__r.Name).contains(district.Name)){
                mapWithStateAndDistrict.get(district.State_Name__r.Name).add(district.Name);
            }                                                                 
        }
        List<State__c> statesData = [
            SELECT Name, Total_Number_of_Districts__c, Country_Name__c, State_Code__c, State_JSON_Data__c 
            FROM State__c
            WHERE Id =: stateNames];
        List<State__c> listOfStates = new List<State__c>();
        if(!statesData.isEmpty()) {
            for(State__c statesRecord : statesData){
                List<CountryStateJSONGenerator.StatesDist> states = new List<CountryStateJSONGenerator.StatesDist>();
                CountryStateJSONGenerator.StatesDist statesWrapper = new CountryStateJSONGenerator.StatesDist();
                statesWrapper.stateName = statesRecord.name;
                List<CountryStateJSONGenerator.Districts> Districts = new List<CountryStateJSONGenerator.Districts>();
                if(!mapWithStateAndDistrict.get(statesRecord.name).isEmpty()){
                    for(String dis: mapWithStateAndDistrict.get(statesRecord.name)){
                        CountryStateJSONGenerator.Districts District = new CountryStateJSONGenerator.Districts();
                        District.districtName = dis;
                        Districts.add(District);
                    }
                }
                statesWrapper.districts = Districts;
                states.add(statesWrapper);
                CountryStateJSONGenerator.StatesDist stateWrapper = new CountryStateJSONGenerator.StatesDist();
                stateWrapper.stateName = statesRecord.Name;
                stateWrapper.stateCode = statesRecord.State_Code__c;
                stateWrapper.totalDistricts = (Integer)statesRecord.Total_Number_of_Districts__c;
                stateWrapper.districts = Districts;

                System.debug(stateWrapper);
                System.debug(JSON.serialize(stateWrapper));
    
                statesRecord.State_JSON_Data__c = JSON.serialize(stateWrapper);
                listOfStates.add(statesRecord);
            }           
        }
        if(!listOfStates.isEmpty())
            update listOfStates;
    }
}