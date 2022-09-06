/**
*  Description     :  Return the account related records after that opportunity then case records
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  09/06/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
public with sharing class AccountRelated {
    //	Contact method return single record
    @AuraEnabled(cacheable=true)
    public static List<Contact> contactRecord(){

        List<Contact> conList = [
            SELECT Id, LastName, Phone, Email 
            FROM Contact 
            WHERE AccountId =: '0015h00000zs02xAAA'];
        return conList;
    }
    //	Opportunity method return single record
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> opportunityRecord(){

        List<Opportunity> oppList = [
            SELECT Id, Name, AccountId, CloseDate, StageName
            FROM Opportunity
            WHERE AccountId =: '0015h00000zs02xAAA'];
        return oppList;
    }
    //	Casemethod return single record
    @AuraEnabled(cacheable=true)
    public static List<Case> caseRecord(){

        List<Case> caseList = [
            SELECT CaseNumber, Status, Priority, AccountId
            FROM Case
            WHERE AccountId =: '0015h00000zs02xAAA'];
        return caseList;
    }
    
}