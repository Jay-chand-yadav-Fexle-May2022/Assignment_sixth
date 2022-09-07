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
    public static Id accountRecordId = '0015h00000zs02xAAA';
    @AuraEnabled(cacheable=true)
    public static List<Contact> contactRecord(){

        List<Contact> conList = [
            SELECT Id, LastName, Phone, Email 
            FROM Contact 
            WHERE AccountId =: accountRecordId];
        return conList;
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> opportunityRecord(){

        List<Opportunity> oppList = [
            SELECT Id, Name, AccountId, CloseDate, StageName
            FROM Opportunity
            WHERE AccountId =: accountRecordId];
        return oppList;
    }

    @AuraEnabled(cacheable=true)
    public static List<Case> caseRecord(){

        List<Case> caseList = [
            SELECT CaseNumber, Status, Priority, AccountId
            FROM Case
            WHERE AccountId =: accountRecordId];
        return caseList;
    }   
}
