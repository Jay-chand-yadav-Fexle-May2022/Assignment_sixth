/**
*  Description     :  Perform DML and SOQL operations, insert opportunity with account reference.
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  07/11/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public with sharing class PerformDMLandSOQLoperation {

    /**
    *   @description    :  Insert ten Account Records and pass list delete and update methods 
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 11/07/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void insertAccountRecords() {

        List<Account> listOfAccountRecords = new List<Account>();
        Account accInsert;
        for(Integer i=1; i<=10; i++) {
            accInsert = new Account();
            accInsert.Name = 'Account ' + i;
            listOfAccountRecords.add(accInsert);
        }
        insert listOfAccountRecords;
    }

    /**
    *   @description    :  Delete one to five records which name is start with Account 
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 11/07/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void deleteAccountRecords() {
 
	List<Account>  listOfAccountRecords = new List<Account>();
        for(Account acc : [SELECT Id, name from Account WHERE name IN ('Account 1', 'Account 2', 'Account 3', 'Account 4', 'Account 5')])
        {
            listOfAccountRecords.add(acc);     
            System.debug(acc);
        }
        delete listOfAccountRecords;
    }

    /**
    *   @description    :  Update five accounts name who end with Account 6 to 10 value 
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 11/07/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void updateAccountRecords() {

        List<Account> listOfAccountRecords = new List<Account>();
        for(Account acc : [SELECT Id, Name from Account WHERE name IN ('Account 6', 'Account 7', 'Account 8', 'Account 9', 'Account 10')])
        {
            for(Integer i = 6; i <= 10; i++) {
                if(('Account '+i).equals(acc.Name)) {
                    acc.Name = 'Account ' + (i - 5);
                    listOfAccountRecords.add(acc);
                    System.debug(acc);
                }
            }      
        } 
        update listOfAccountRecords;
    }

    /**
    *   @description    :  Using upsert and update contact description whose department is finance
                           if department is not equal to finance so creating new contact.
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 11/07/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void updateContactRecord() {

        List<Contact> updateList = new List<Contact>();
        for(Contact con : [SELECT Department, Description FROM Contact]) {

            if(con.Department == 'Finance') {
                con.Description = 'New description';
                updateList.add(con);
            }

            else {
                Contact newContact = new Contact(department = 'Other',lastName = 'Smith');
                updateList.add(newContact);
            }
        }
        upsert updateList;
    }

    /**
    *   @description    :  Merging accounts and add mergeAcct Id in contact
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 11/07/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void mergeAccounts() {
        // Insert new accounts
        List<Account> ls = new List<Account>{
            new Account(name='Acme Inc.'),
            new Account(name='Acme')
        };                                        
        insert ls;

        // Queries to get the inserted accounts 
        Account masterAcct = [SELECT Id, Name FROM Account WHERE Name = 'Acme Inc.' LIMIT 1];
        Account mergeAcct = [SELECT Id, Name FROM Account WHERE Name = 'Acme' LIMIT 1];

        // Add a contact to the account to be merged
        Contact c = new Contact(FirstName='Joe',LastName='Merged');
        c.AccountId = mergeAcct.Id;
        insert c;

        try {
            merge masterAcct mergeAcct;
        } catch (DmlException e) {
        // Process exception
        System.debug('An unexpected error has occurred: ' + e.getMessage()); 
        }

        // Once the account is merged with the master account,
        // the related contact should be moved to the master record.
        masterAcct = [SELECT Id, Name, (SELECT FirstName,LastName From Contacts) 
                     FROM Account WHERE Name = 'Acme Inc.' LIMIT 1];
        System.assert(masterAcct.getSObjects('Contacts').size() > 0);
        System.assertEquals('Joe', masterAcct.getSObjects('Contacts')[0].get('FirstName'));
        System.assertEquals('Merged', masterAcct.getSObjects('Contacts')[0].get('LastName'));

        // Verify that the merge record got deleted
        Account[] result = [SELECT Id, Name FROM Account WHERE Id=:mergeAcct.Id];
        System.assertEquals(0, result.size());
    }

    /**
    *   @description    :   Insert Opportunity With Account Reference
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 11/07/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void insertOpportunityWithAccountReference() {

        Opportunity newOpportunity = new Opportunity(
        Name='OpportunityWithAccountInsert',
        StageName='Prospecting',
        CloseDate=Date.today().addDays(7));

        // Create the parent record reference.
        // An account with external ID = 'SAP111111' already exists.
        // This sObject is used only for foreign key reference
        // and doesn't contain any other fields.
        Account accountReference = new Account(
        SLASerialNumber__c='SAP111112'); // The id should be exist on account otherwise it won't work

        // Add the account sObject to the opportunity.
        newOpportunity.Account = accountReference;

        // Create the opportunity.
        Database.SaveResult results = Database.insert(newOpportunity);
    }

    /**
    *   @description    :   Create Parent and Child Records Single Statement Using ForeignKey
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 11/07/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void createParentChildRecordSingleStatementUsingForeignKey() {

        Date dt = Date.today();
        dt = dt.addDays(7);
        Opportunity newOpportunity = new Opportunity(
            Name='OpportunityWithAccountInsert',
            StageName='Prospecting',
            CloseDate=dt);
        
        // Create the parent reference.
        // Used only for foreign key reference
        // and doesn't contain any other fields.
        Account accountReference = new Account(
            SLASerialNumber__c='SAP111114');           // The id shouldn't be exit on account    
        newOpportunity.Account = accountReference;
        
        // Create the Account object to insert.
        // Same as above but has Name field.
        // Used for the insert.
        Account parentAccount = new Account(
            Name='Hallie',
            SLASerialNumber__c='SAP111114');            // The id shouldn't be exit on account 
        
        // Create the account and the opportunity.
        Database.SaveResult[] results = Database.insert(new SObject[] {
            parentAccount, newOpportunity });
        
        // Check results.
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
            System.debug('Successfully created ID: '
                  + results[i].getId());
            } else {
            System.debug('Error: could not create sobject '
                  + 'for array element ' + i + '.');
            System.debug('   The error reported was: '
                  + results[i].getErrors()[0].getMessage() + '\n');
            }
        }
    }

    /**
    *   @description    :   Update Contacts Records using map
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 11/07/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void updateContactRecordsWithMap() {

        List<Contact> updatedList = new List<Contact>();
        Map<Id, Contact> mapWithContacts = new Map<Id, Contact>();
        for(Contact con : [SELECT Department, Description From Contact WHERE Department = 'Management']) {
            con.Description = 'New Management';
            // Add updated contact sObject to the list
            updatedList.add(con);
            mapWithContacts.put(con.Id, con);
        }

        // Call update on the list contacts.
        //This results in one DML call for the entire list.
        Database.SaveResult[] saveresults = database.update(mapWithContacts.values(), true);
    }
}
