/**
*  Description     :  Showing the results as per user input and download the documentation (CSV) 
*                     file
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  09/15/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
public with sharing class RetrieveTransactionEntriesRecords {
    // Shoiwng entries records as the users requirements
    @AuraEnabled(cacheable=true)
    public static List<Transaction_Entry__c> getEntriesRecord(Id recordId, Integer transLimit){

        return [SELECT Id, Name, Amount__c, Type__c, Transaction_Date__c FROM Transaction_Entry__c WHERE Contact__c =: recordId  Limit: transLimit];
    }

    // Fetch the records for (CSV) file 
    @AuraEnabled(cacheable=true)
    public static List<Transaction_Entry__c> getEntriesRecordForStatement(Id recordId, Date start_Date, Date end_Date){

        
        List<Transaction_Entry__c> listOfEntriesRecord = new List<Transaction_Entry__c>();

        Integer dt1 = (start_Date). daysBetween(end_Date);
        System.debug('=================>  Days ===============> ' + dt1);

        try{
            if(182 >= dt1){
                listOfEntriesRecord = [SELECT Id, Name, Amount__c, Type__c, Transaction_Date__c FROM Transaction_Entry__c WHERE Contact__c =: recordId  AND Transaction_Date__c >= :start_Date AND Transaction_Date__c <=: end_Date];
            }
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        return listOfEntriesRecord;
    }
}