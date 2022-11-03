/**
*  Description     :  Test class for Transaction entries 
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  09/20/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
@isTest(SeeAllData = false)
private with sharing class TransactionEntryTriggerHandlerTest {
    
    @TestSetup
    static void makeData() {

        List<Transaction_Limit__c> listOfTransactionLimit = new List<Transaction_Limit__c>();
        
        Transaction_Limit__c limitOfSbiBank = new Transaction_Limit__c();
        limitOfSbiBank.name = 'SBI';
        limitOfSbiBank.Maximum_Debit_Allowed_per_Month__c = 900000;
        limitOfSbiBank.Maximum_Transactions_Allowed_per_Month__c = 50;
        limitOfSbiBank.Maximum_Debit_Allowed_per_Day__c = 30000;
        limitOfSbiBank.Maximum_Transactions_Allowed_per_Day__c = 5;
        limitOfSbiBank.Maximum_Debit_Allowed_per_Transaction__c = 10000;   
        listOfTransactionLimit.add(limitOfSbiBank);
        
        Transaction_Limit__c limitOfAXISBank = new Transaction_Limit__c();
        limitOfAXISBank.name = 'AXIS';
        limitOfAXISBank.Maximum_Debit_Allowed_per_Month__c = 300000;
        limitOfAXISBank.Maximum_Transactions_Allowed_per_Month__c = 20;
        limitOfAXISBank.Maximum_Debit_Allowed_per_Day__c = 10000;
        limitOfAXISBank.Maximum_Transactions_Allowed_per_Day__c = 2;
        limitOfAXISBank.Maximum_Debit_Allowed_per_Transaction__c = 10000;      
        listOfTransactionLimit.add(limitOfAXISBank);
        
        Transaction_Limit__c limitOfSaving = new Transaction_Limit__c();
        limitOfSaving.name = 'AXIS';
        limitOfSaving.Maximum_Debit_Allowed_per_Month__c = 10000;
        limitOfSaving.Maximum_Transactions_Allowed_per_Month__c = 15;
        limitOfSaving.Maximum_Debit_Allowed_per_Day__c = 5000;
        limitOfSaving.Maximum_Transactions_Allowed_per_Day__c = 10;
        limitOfSaving.Maximum_Debit_Allowed_per_Transaction__c = 2000;      
        listOfTransactionLimit.add(limitOfSaving);
        insert listOfTransactionLimit;
        
        
        List<Contact> listOfContact = new List<Contact>();
        Contact conForSbi = new Contact();
        conForSbi.LastName = 'Smith';
        conForSbi.status__c = 'Active';
        conForSbi.Transaction_Limit__c = listOfTransactionLimit.get(0).Id;
        listOfContact.add(conForSbi);
        
        Contact conForAxis = new Contact();
        conForAxis.LastName = 'John';
        conForAxis.status__c = 'Active';
        conForAxis.Transaction_Limit__c = listOfTransactionLimit.get(1).Id;
        listOfContact.add(conForAxis);
        
        Contact conForHDFC = new Contact();
        conForHDFC.LastName = 'Jay';
        conForHDFC.status__c = 'Inactive';
        conForHDFC.Transaction_Limit__c = listOfTransactionLimit.get(0).Id;
        listOfContact.add(conForHDFC);
        
        Contact conForPunjab = new Contact();
        conForPunjab.LastName = 'Mosh';
        conForPunjab.status__c = 'Active';
        conForPunjab.Transaction_Limit__c = listOfTransactionLimit.get(1).Id;
        listOfContact.add(conForPunjab);
        
        Contact conForNational = new Contact();
        conForNational.lastName = 'Harry';
        conForNational.status__c = 'Active';
        conForNational.Transaction_Limit__c = listOfTransactionLimit.get(0).Id;
        listOfContact.add(conForNational);
        
        Contact conForSaving = new Contact();
		conForSaving.lastName = 'Testing';
        conForSaving.status__c = 'Active';
        conForSaving.Transaction_Limit__c = listOfTransactionLimit.get(2).Id;
        listOfContact.add(conForSaving);
        
        Test.startTest();              	
        	insert listOfContact;
        Test.stopTest();
    }
    
    
    
    
    @isTest
    private static void testTransactionEntryForCreditDebitForSBI(){

        List<Contact> listOfConId = new List<Contact>([Select Id From Contact Where name = 'Smith']);
        
        List<Transaction_Entry__c> listOfCreditEntry = new List<Transaction_Entry__c>();
        for(Integer i=0; i<4; i++){
            Transaction_Entry__c  creditEntry = new Transaction_Entry__c();
            creditEntry.Amount__c = 25000;
            creditEntry.Type__c = 'Credit';
            creditEntry.status__c = 'Pending';
            creditEntry.contact__c = listOfConId.get(0).id;
            creditEntry.Transaction_Date__c = System.today();
            listOfCreditEntry.add(creditEntry);
        }
        
        insert listOfCreditEntry;
        
        
        List<Contact> listOfCon = [Select Id, LastName, Available_Balance__c From Contact Where id = : listOfConId.get(0).id];
        System.assertEquals(100000, listOfCon.get(0).Available_Balance__c);    
        
        List<Transaction_Entry__c> listOfEntry = new List<Transaction_Entry__c>();
        for(Integer i = 0; i < 2; i++){
            Transaction_Entry__c  entryObj = new Transaction_Entry__c();
            entryObj.Amount__c = 1000;
            entryObj.Type__c = 'Debit';
            entryObj.status__c = 'Pending';
            entryObj.contact__c = listOfConId.get(0).id;
            entryObj.Transaction_Date__c = Date.newInstance(2022, 10, 10);
            listOfEntry.add(entryObj);
        }
        insert listOfEntry;
        
        List<Contact> listOfCon3 = [Select Id, LastName, Available_Balance__c From Contact Where id = : listOfConId.get(0).id]; 
		System.assertEquals(98000, listOfCon3.get(0).Available_Balance__c); 
        
        
		Transaction_Entry__c  entry1 = new Transaction_Entry__c();
        entry1.Amount__c = 10000;
        entry1.Type__c = 'Debit';
        entry1.status__c = 'Pending';
        entry1.contact__c = listOfConId.get(0).id;
        entry1.Transaction_Date__c = System.today();
        insert entry1;      
        
        List<Contact> listOfCon1 = [Select Id, LastName, Available_Balance__c From Contact Where id = : listOfConId.get(0).id];
        System.assertEquals(88000, listOfCon1.get(0).Available_Balance__c); 
        
        List<Transaction_Entry__c> listOfEntries = new List<Transaction_Entry__c>();
        for(Integer i=0; i<2; i++){
            Transaction_Entry__c  entry2 = new Transaction_Entry__c();
            entry2.Amount__c = 10000;
            entry2.Type__c = 'Debit';
            entry2.status__c = 'Pending';
            entry2.contact__c = listOfConId.get(0).id;
            entry2.Transaction_Date__c = System.today();
            listOfEntries.add(entry2);
        }
        
        insert listOfEntries;   
        
        List<Contact> listOfCon2 = [Select Id, LastName, Available_Balance__c From Contact Where id = : listOfConId.get(0).id];
        System.assertEquals(68000, listOfCon2.get(0).Available_Balance__c); 
        System.debug('');
        
        
        Transaction_Entry__c  entry2 = new Transaction_Entry__c();
        entry2.Amount__c = 10000;
        entry2.Type__c = 'Debit';
        entry2.status__c = 'Pending';
        entry2.contact__c = listOfConId.get(0).id;
        entry2.Transaction_Date__c = System.today();
        
        Test.startTest();
            try
            {
                insert entry2;
            }
            catch (DmlException d)
            {
               System.debug('Limit exceed');
            }
        Test.stopTest();

        List<Contact> contactIds = [Select Id, status__c, Available_Balance__c From Contact Where LastName='Jay'];
        Transaction_Entry__c  entry3 = new Transaction_Entry__c();
        entry3.Amount__c = 10000;
        entry3.Type__c = 'Debit';
        entry3.status__c = 'Pending';
        entry3.contact__c = contactIds.get(0).id;
        entry3.Transaction_Date__c = System.today();
        System.debug('==================> status of contact =============> ' + contactIds);
        try{
            insert entry3;
        }
        catch(DmlException d){
            System.debug('Contact is deactivated');
        }
        
        
        List<Contact> listOfPunjab = [Select Id, status__c, Available_Balance__c From Contact Where LastName='Mosh'];
        Transaction_Entry__c  entry4 = new Transaction_Entry__c();
        entry4.Amount__c = 1000;
        entry4.Type__c = 'Credit';
        entry4.status__c = 'Pending';
        entry4.contact__c = listOfPunjab.get(0).id;
        entry4.Transaction_Date__c = System.today();
        insert entry4;
        
        List<Contact> listOfPunjabRecord = [Select Id, status__c, Available_Balance__c From Contact Where LastName='Mosh'];
        System.assertEquals(1000, listOfPunjabRecord.get(0).Available_Balance__c);
        
        Transaction_Entry__c  entry5 = new Transaction_Entry__c();
        entry5.Amount__c = 1000;
        entry5.Type__c = 'Debit';
        entry5.status__c = 'Pending';
        entry5.contact__c = listOfPunjab.get(0).id;
        entry5.Transaction_Date__c = System.today();
               
        try{
           insert entry5; 
        }
        catch(DmlException d){
            System.debug('You don\'t have enough balance');
        }
        
        List<Contact> listOfNational = [Select Id, status__c, Available_Balance__c From Contact Where LastName='Harry'];
        Transaction_Entry__c  entry6 = new Transaction_Entry__c();
        entry6.Amount__c = 100000;
        entry6.Type__c = 'Credit';
        entry6.status__c = 'Pending';
        entry6.contact__c = listOfNational.get(0).id;
        entry6.Transaction_Date__c = System.today();
        insert entry6;
        
        List<Contact> listOfNationalRecord = [Select Id, status__c, Available_Balance__c From Contact Where LastName='Harry'];
        System.assertEquals(100000, listOfNationalRecord.get(0).Available_Balance__c);
        
        Transaction_Entry__c  entry7 = new Transaction_Entry__c();
        entry7.Amount__c = 10001;
        entry7.Type__c = 'Debit';
        entry7.status__c = 'Pending';
        entry7.contact__c = listOfNational.get(0).id;
        entry7.Transaction_Date__c = System.today();
        
        try{
           insert entry7;
        }
        catch(DmlException d){
            System.debug('Exceed per transaction limit');
        }
            
        List<Contact> listOfSaving = [Select Id, status__c, Available_Balance__c From Contact Where LastName='Testing'];
        Transaction_Entry__c  entry8 = new Transaction_Entry__c();
        entry8.Amount__c = 200000;
        entry8.Type__c = 'Credit';
        entry8.status__c = 'Pending';
        entry8.contact__c = listOfSaving.get(0).id;
        entry8.Transaction_Date__c = System.today();
        insert entry8;
        
        List<Contact> listOfSavingRecord = [Select Id, status__c, Available_Balance__c From Contact Where LastName='Testing'];
        System.assertEquals(200000, listOfSavingRecord.get(0).Available_Balance__c);
        
        List<Transaction_Entry__c> lstSaving = new List<Transaction_Entry__c>();
        for(Integer i = 0; i < 5 ; i++){
            Transaction_Entry__c  entry9 = new Transaction_Entry__c();
            entry9.Amount__c = 1000;
            entry9.Type__c = 'Debit';
            entry9.status__c = 'Pending';
            entry9.contact__c = listOfSaving.get(0).id;
            entry9.Transaction_Date__c = Date.newInstance(2022, 10, 10);
            lstSaving.add(entry9);
        }
		insert lstSaving;
        
        List<Contact> listOfSavingRecord1 = [Select Id, status__c, Available_Balance__c From Contact Where LastName='Testing'];
        System.assertEquals(195000, listOfSavingRecord1.get(0).Available_Balance__c);
        
        List<Transaction_Entry__c> lstSaving1 = new List<Transaction_Entry__c>();
        for(Integer i = 0; i < 6 ; i++){
            Transaction_Entry__c  entry9 = new Transaction_Entry__c();
            entry9.Amount__c = 1000;
            entry9.Type__c = 'Debit';
            entry9.status__c = 'Pending';
            entry9.contact__c = listOfSaving.get(0).id;
            entry9.Transaction_Date__c = System.today();
            lstSaving1.add(entry9);
        }
        try{
            insert lstSaving1;
        }
        catch(DmlException d){
            System.debug('Exceed per month amount');
        }		
    }
}