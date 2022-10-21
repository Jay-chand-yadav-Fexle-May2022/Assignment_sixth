/**
*  Description     :  Test Controller for contact 
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  09/21/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
@isTest(SeeAllData = false)
public class StatementPdfEmailTest {
	
    @isTest
    private static void deleteCheck(){
    	
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
        
        Transaction_Entry__c entry = new Transaction_Entry__c();
        entry.Amount__c = 25000;
        entry.Type__c = 'Credit';
        entry.status__c = 'Pending';
        entry.contact__c = conObj.id;
        entry.Transaction_Date__c = System.today();
        insert entry;
        
        List<Contact> conList = [Select Id, Available_Balance__c From Contact];
        System.assertEquals(25000, conlist[0].Available_Balance__c);
        Date x = Date.valueOf('2022-12-31');
        Date y = Date.valueOf('2020-12-31');
        StatementPdfEmail.sendEmail(conObj.id, '2022-12-31', '2020-12-31');
        
        
    }
}