/**
*  Description     :  Account trigger handler class testing
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  07/21/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
@isTest(SeeAllData = false)
public class AccountTriggerHandlerTests {
	
    @TestSetup
    static void makeData() {
        List<Account> listOfAccounts = new List<Account>();
        listOfAccounts.add(new Account(Name = 'Account1', Type = 'Saving',Email__c = 'jaychand.yadav@fexle.com'));
        listOfAccounts.add(new Account(Name = 'Account2', Type = 'Saving', Email__c = 'testing1@test.com'));
        listOfAccounts.add(new Account(Name = 'Account3', Type = 'FD', Email__c = 'testing2@test.com'));
        insert listOfAccounts;
    }
    
    // Test the updateTheAccountsNumber method
    @isTest
    private static void updateTheAccountsNumberTest() {
    	
        List<Account> listOfAccounts = new List<Account>();
        listOfAccounts.add(new Account(Name = 'Account4', Type = 'Saving',Email__c = 'testing3@fexle.com'));
        listOfAccounts.add(new Account(Name = 'Account5', Type = 'FD',Email__c = 'testing4@fexle.com'));
        Test.startTest();
        	insert listOfAccounts;
        Test.stopTest();
        
        List<Account> acc = [SELECT Id, AccountNumber FROM Account WHERE Id IN:listOfAccounts ORDER BY Name];
        System.assert(acc[0].AccountNumber.startsWith('SB'), 'Account Number should be starts with SB');
        System.assert(acc[1].AccountNumber.startsWith('FD'), 'Account Number should be starts with FD');
    }
    
    // Test the sendEmail method
    @isTest
    private static void sendEmailTest() {
        
        List<Account> listOfAccounts_1 = new List<Account>();
        listOfAccounts_1.add(new Account(Name = 'Account6', Type = 'Saving', Email__c = 'testing5@test.com'));
        listOfAccounts_1.add(new Account(Name = 'Account7', Type = 'FD', Email__c = 'testing6@test.com'));
        Test.startTest();
        	insert listOfAccounts_1;
        Test.stopTest();
        List<Account> acc_1 = [SELECT Id, Email__c FROM Account WHERE Id IN: listOfAccounts_1 ORDER BY Name];
        System.assert(acc_1[0].Email__c.equals('testing5@test.com'), 'Email address should be match');
        System.assert(acc_1[1].Email__c.equals('testing6@test.com'), 'Email address should be match');
    }
}