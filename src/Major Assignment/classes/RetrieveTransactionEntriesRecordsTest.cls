/**
*  Description     :  Test Class for retrieve transaction records
*                     
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  09/20/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
@isTest(SeeAllData = false)
public class RetrieveTransactionEntriesRecordsTest {

    @TestSetup
    static void makeData(){
        
        Transaction_Limit__c limitOfSbiBank = new Transaction_Limit__c();
        limitOfSbiBank.name = 'SBI';
        limitOfSbiBank.Maximum_Debit_Allowed_per_Month__c = 900000;
        limitOfSbiBank.Maximum_Transactions_Allowed_per_Month__c = 50;
        limitOfSbiBank.Maximum_Debit_Allowed_per_Day__c = 30000;
        limitOfSbiBank.Maximum_Transactions_Allowed_per_Day__c = 5;
        limitOfSbiBank.Maximum_Debit_Allowed_per_Transaction__c = 10000;   
        insert limitOfSbiBank;
        
        Contact conObj = new Contact();
        conObj.LastName = 'Testing';
        conObj.email = 'Testing@gmail.com';
        conObj.status__c = 'Active';
        conObj.Transaction_Limit__c = limitOfSbiBank.id;
        insert conObj;
    }
    
    @isTest
    private static void deleteCheck(){
        
        List<Contact> listOfCon = [Select Id From Contact Where LastName = 'Testing'];
        
        Transaction_Entry__c entry = new Transaction_Entry__c();
        entry.Amount__c = 25000;
        entry.Type__c = 'Credit';
        entry.status__c = 'Pending';
        entry.contact__c = listOfCon.get(0).id;
        entry.Transaction_Date__c = System.today();
        insert entry;
        
        test.startTest();
        	RetrieveTransactionEntriesRecords.getEntriesRecord(entry.id, 1);
        test.stopTest();
    }
    
    @isTest
    private static void showRecordWithLimit(){
        
        List<Contact> listOfCon = [Select Id From Contact Where LastName = 'Testing'];
        
        Transaction_Entry__c entry = new Transaction_Entry__c();
        entry.Amount__c = 25000;
        entry.Type__c = 'Credit';
        entry.status__c = 'Pending';
        entry.contact__c = listOfCon.get(0).id;
        entry.Transaction_Date__c = System.today();
        insert entry;
        
        test.startTest();
        	RetrieveTransactionEntriesRecords.getEntriesRecord(entry.id, 1);
        test.stopTest();
    }
    
     @isTest
    private static void showRecordWithDate(){
        
        List<Contact> listOfCon = [Select Id From Contact Where LastName = 'Testing'];        
        Transaction_Entry__c entry = new Transaction_Entry__c();
        entry.Amount__c = 25000;
        entry.Type__c = 'Credit';
        entry.status__c = 'Pending';
        entry.contact__c = listOfCon.get(0).id;
        entry.Transaction_Date__c = System.today();
        insert entry;
        
        Date x = Date.valueOf('2022-12-31');
        Date y = Date.valueOf('2020-12-31');
        test.startTest();
        	RetrieveTransactionEntriesRecords.getEntriesRecordForStatement(entry.id, x , entry.Transaction_Date__c);
        	RetrieveTransactionEntriesRecords.getEntriesRecordForStatement(entry.id, y , entry.Transaction_Date__c);
        test.stopTest();
    }  
}