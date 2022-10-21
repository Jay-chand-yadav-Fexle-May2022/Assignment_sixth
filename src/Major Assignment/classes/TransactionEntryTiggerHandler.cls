/**
*  Description     :  Create entries record and check the limits from transaction limit and here 
*                     we performing debit and credit whenever user choose credit type so the
*                     amount will be add on the contact available balance and if user choose
*                     debit then it will check all custom validation and limits and after that we
*                     are sending email to the contact owner email id. and when user update the 
*                     type as cancelled so the amount will be readjust.
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  09/09/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
public class TransactionEntryTiggerHandler {

    public static void transaction(List<Transaction_Entry__c> lstEntry){
		//mapOfTransactionEntry
		System.debug('lstEntry ======> ' + lstEntry);

        // Set of contact id only for debit type
        Set<Id> setOfDebitContactId = new Set<Id>();

        // Map of Contact for updation
        Map<Id, Contact> mapOfContactForUpdation = new Map<Id, Contact>();

        // Map of Transaction Entry for updation
        Map<Id, Transaction_Entry__c> mapOfTransactionEntryUpdation = new Map<Id, Transaction_Entry__c>();
        
        // List of New entry Ids
        List<Id> listOfConId = new List<Id>();

        for(Transaction_Entry__c entryNewRecord: lstEntry){
            listOfConId.add(entryNewRecord.contact__c);

            // fill contact id for set only debit type
            if(entryNewRecord.type__c == 'Debit'){
                setOfDebitContactId.add(entryNewRecord.contact__c);
            }
        }

        // Map of entry id and how many record create in one day store in value Today
        Map<Id, Integer> mapOfEntry = new Map<Id, Integer>();
        // Map of entry id and how many record create in one month store in value Today
        Map<Id, Integer> mapofEntryPerMonth = new Map<Id, Integer>();
        // Map of Total amount  of month
        Map<Id, Decimal> mapOfEntryTotalAmountOfMonth = new Map<Id, Decimal>();
        // Map of Total amount of one day/ today
        Map<Id, Decimal> mapOfEntryTotalAmountOfDay = new Map<Id, Decimal>();

        Integer mnth = System.Today().Month();
        for(Transaction_Entry__c entryOldRecord: [SELECT Id, contact__c, Amount__c, Transaction_Date__c FROM Transaction_Entry__c WHERE CALENDAR_MONTH(Transaction_Date__c) =: mnth AND type__c = 'Debit' AND status__c = 'Completed']){

            // Today Records
            if(entryOldRecord.Transaction_Date__c == System.Today()){
                if(mapOfEntry.containsKey(entryOldRecord.contact__c)){
                    mapOfEntry.put(entryOldRecord.contact__c, mapOfEntry.get(entryOldRecord.contact__c) + 1);
                }
                else{
                    mapOfEntry.put(entryOldRecord.contact__c, 1);
                }

                if(mapOfEntryTotalAmountOfDay.containsKey(entryOldRecord.contact__c)){
                    mapOfEntryTotalAmountOfDay.put(entryOldRecord.contact__c, mapOfEntryTotalAmountOfDay.get(entryOldRecord.contact__c) + entryOldREcord.Amount__c);
                }
                else{
                    mapOfEntryTotalAmountOfDay.put(entryOldRecord.contact__c, entryOldREcord.Amount__c);
                }
            }
            // Today with This Month records
            if(mapofEntryPerMonth.containsKey(entryOldRecord.contact__c)){
                mapofEntryPerMonth.put(entryOldRecord.contact__c, mapofEntryPerMonth.get(entryOldRecord.contact__c) + 1);
            }
            else{
                mapofEntryPerMonth.put(entryOldRecord.contact__c, 1);
            }
            
            if(mapOfEntryTotalAmountOfMonth.containsKey(entryOldRecord.contact__c)){
                mapOfEntryTotalAmountOfMonth.put(entryOldRecord.contact__c, mapOfEntryTotalAmountOfMonth.get(entryOldRecord.contact__c) + entryOldREcord.Amount__c);
            }
            else{
                mapOfEntryTotalAmountOfMonth.put(entryOldRecord.contact__c, entryOldREcord.Amount__c);
            }
            
            
        }
		System.debug('=====>' + mapOfEntry);
        // Entry contact id store as a ID and contact fileds store as a value
        Map<Id, Contact> mapOfCon = new Map<Id, Contact>([SELECT Id, Account_Number__c, Status__c, Available_Balance__c, OwnerId FROM Contact WHERE Id IN: listOfConId]);

        // Child to parent - Contact to Transaction Limit store limit as a value and contat id as a Id
        Map<Id, Contact> mapofTransactionLimit = new Map<Id, Contact>([SELECT Id,  Transaction_Limit__r.Maximum_Debit_Allowed_per_Day__c, Transaction_Limit__r.Maximum_Debit_Allowed_per_Month__c, Transaction_Limit__r.Maximum_Debit_Allowed_per_Transaction__c, Transaction_Limit__r.Maximum_Transactions_Allowed_per_Day__c, Transaction_Limit__r.Maximum_Transactions_Allowed_per_Month__c FROM Contact WHERE Id In: setOfDebitContactId ]);

        for(Transaction_Entry__c tranEntry: lstEntry){

            if(mapOfCon.get(tranEntry.contact__c).Status__c == 'Active'){
                
                if(tranEntry.type__c == 'Debit'){
                   
                    if(mapOfCon.get(tranEntry.contact__c).Available_Balance__c >= tranEntry.Amount__c && mapOfCon.get(tranEntry.contact__c).Available_Balance__c >= 3000){

                        if(mapofTransactionLimit.get(tranEntry.contact__c).Transaction_Limit__r.Maximum_Debit_Allowed_per_Transaction__c >= tranEntry.Amount__c){
                                                       
                            if(mapofEntryPerMonth.containsKey(tranEntry.contact__c)){

                                if(mapofTransactionLimit.get(tranEntry.contact__c).Transaction_Limit__r.Maximum_Debit_Allowed_per_Month__c >= mapOfEntryTotalAmountOfMonth.get(tranEntry.contact__c) + tranEntry.Amount__c){

                                    if(mapofTransactionLimit.get(tranEntry.contact__c).Transaction_Limit__r.Maximum_Transactions_Allowed_per_Month__c  > mapofEntryPerMonth.get(tranEntry.contact__c)){

                                        if(mapOfEntry.containsKey(tranEntry.contact__c)){

                                            if(mapofTransactionLimit.get(tranEntry.contact__c).Transaction_Limit__r.Maximum_Debit_Allowed_per_Day__c >=  mapOfEntryTotalAmountOfDay.get(tranEntry.contact__c) + tranEntry.Amount__c){

                                                if(mapofTransactionLimit.get(tranEntry.contact__c).Transaction_Limit__r.Maximum_Transactions_Allowed_per_Day__c  > mapOfEntry.get(tranEntry.contact__c)){
                                                    
                                                    System.debug('Run inside maximum allowed per day ===============');
                                                    Contact contactObj = new Contact();
                                                    contactObj.Id = tranEntry.contact__c;
                                                    contactObj.Available_Balance__c = mapOfCon.get(tranEntry.contact__c).Available_Balance__c - tranEntry.Amount__c;

                                                    mapOfContactForUpdation.put(contactObj.Id, contactObj);

                                                    Transaction_Entry__c transactionEntryObject = new Transaction_Entry__c();
                                                    transactionEntryObject.Id = tranEntry.Id;
                                                    transactionEntryObject.Status__c = 'Completed';

                                                    mapOfTransactionEntryUpdation.put(transactionEntryObject.Id, transactionEntryObject);

                                                    // Fill the debit count on map
                                                    mapOfEntry.put(tranEntry.contact__c, mapOfEntry.get(tranEntry.contact__c) + 1);

                                                    mapofEntryPerMonth.put(tranEntry.contact__c, mapofEntryPerMonth.get(tranEntry.contact__c) + 1);

                                                    //put total amount of month on map mapOfEntryTotalAmountOfMonth 
                                                    mapOfEntryTotalAmountOfMonth.put(tranEntry.contact__c, mapOfEntryTotalAmountOfMonth.get(tranEntry.contact__c) + tranEntry.Amount__c);

                                                    // put total amount of one day/today
                                                    mapOfEntryTotalAmountOfDay.put(tranEntry.contact__c, mapOfEntryTotalAmountOfDay.get(tranEntry.contact__c) + tranEntry.Amount__c);

                                                    // Update amount in mapOfCon
                                                    mapOfCon.get(tranEntry.contact__c).Available_Balance__c = mapOfCon.get(tranEntry.contact__c).Available_Balance__c - tranEntry.Amount__c;

                                                    sendEmail(mapOfCon.get(tranEntry.contact__c).Account_Number__c, tranEntry.Type__c, tranEntry.Amount__c, tranEntry.Transaction_Date__c, mapOfCon.get(tranEntry.contact__c).Available_Balance__c, mapOfCon.get(tranEntry.contact__c).OwnerId);

                                                }
                                                else{
                                                    tranEntry.addError('You have exceed your today transaction limits');
                                                }
                                            }
                                            else{
                                                tranEntry.addError('You have exceed your today debit limit');
                                            }
                                        }
                                        else{
                                            System.debug('Key not containing on map Runing ===============================');
                                            Contact contactObj = new Contact();
                                            contactObj.Id = tranEntry.contact__c;
                                            contactObj.Available_Balance__c = mapOfCon.get(tranEntry.contact__c).Available_Balance__c - tranEntry.Amount__c;

                                            mapOfContactForUpdation.put(contactObj.Id, contactObj);

                                            Transaction_Entry__c transactionEntryObject = new Transaction_Entry__c();
                                            transactionEntryObject.Id = tranEntry.Id;
                                            transactionEntryObject.Status__c = 'Completed';

                                            mapOfTransactionEntryUpdation.put(transactionEntryObject.Id, transactionEntryObject);

                                            mapOfEntry.put(tranEntry.contact__c, 1);
                                            mapofEntryPerMonth.put(tranEntry.contact__c, mapofEntryPerMonth.get(tranEntry.contact__c)+1);
                                            // put total amount of month 
                                            mapOfEntryTotalAmountOfMonth.put(tranEntry.contact__c, mapOfEntryTotalAmountOfMonth.get(tranEntry.contact__c) + tranEntry.Amount__c);

                                            // put total amount of one day/today
                                            mapOfEntryTotalAmountOfDay.put(tranEntry.contact__c, tranEntry.Amount__c);

                                            mapOfCon.get(tranEntry.contact__c).Available_Balance__c = mapOfCon.get(tranEntry.contact__c).Available_Balance__c - tranEntry.Amount__c;

                                            sendEmail(mapOfCon.get(tranEntry.contact__c).Account_Number__c, tranEntry.Type__c, tranEntry.Amount__c, tranEntry.Transaction_Date__c, mapOfCon.get(tranEntry.contact__c).Available_Balance__c, mapOfCon.get(tranEntry.contact__c).OwnerId);
                                        }
                                    }
                                    else{
                                        tranEntry.addError('You have exceed your per month transaction limit');
                                    }
                                }
                                else{
                                    tranEntry.addError('You have exceed your month amount limit');
                                }
                            }
                            else{
                                Contact contactObj = new Contact();
                                contactObj.Id = tranEntry.contact__c;
                                contactObj.Available_Balance__c = mapOfCon.get(tranEntry.contact__c).Available_Balance__c - tranEntry.Amount__c;

                                mapOfContactForUpdation.put(contactObj.Id, contactObj);

                                Transaction_Entry__c transactionEntryObject = new Transaction_Entry__c();
                                transactionEntryObject.Id = tranEntry.Id;
                                transactionEntryObject.Status__c = 'Completed';

                                mapOfTransactionEntryUpdation.put(transactionEntryObject.Id, transactionEntryObject);

                                mapOfEntry.put(tranEntry.contact__c, 1);
                                mapofEntryPerMonth.put(tranEntry.contact__c, 1);
                                mapOfEntryTotalAmountOfMonth.put(tranEntry.contact__c, tranEntry.Amount__c);
                                mapOfEntryTotalAmountOfDay.put(tranEntry.contact__c, tranEntry.Amount__c);
                                

                                mapOfCon.get(tranEntry.contact__c).Available_Balance__c = mapOfCon.get(tranEntry.contact__c).Available_Balance__c - tranEntry.Amount__c;

                                sendEmail(mapOfCon.get(tranEntry.contact__c).Account_Number__c, tranEntry.Type__c, tranEntry.Amount__c, tranEntry.Transaction_Date__c, mapOfCon.get(tranEntry.contact__c).Available_Balance__c, mapOfCon.get(tranEntry.contact__c).OwnerId);
                            }  

                        }
                        else{
                            tranEntry.Amount__c.addError('You have exceed your amount limit of per transaction');
                        }
                    }
                    else{
                        tranEntry.addError('You don\'t have enough amount');
                    }
                }
                else{
                    // For Credit 
                    if(mapOfCon.get(tranEntry.contact__c).Available_Balance__c == null){
                        
                        Contact conObj = new Contact();
                        conObj.Id = tranEntry.contact__c;
                        conObj.Available_Balance__c = tranEntry.Amount__c;
                        mapOfContactForUpdation.put(conObj.Id, conObj);
                    }
                    else{
                        Contact conObj = new Contact();
                        conObj.Id = tranEntry.contact__c;
                        conObj.Available_Balance__c = mapOfCon.get(tranEntry.contact__c).Available_Balance__c + tranEntry.Amount__c;
                        mapOfContactForUpdation.put(conObj.Id, conObj);
                    }

                    Transaction_Entry__c transactionEntryObj = new Transaction_Entry__c();
                    transactionEntryObj.Id = tranEntry.Id;
                    transactionEntryObj.Status__c = 'Completed';
                    mapOfTransactionEntryUpdation.put(transactionEntryObj.Id, transactionEntryObj);

                    if(mapOfCon.get(tranEntry.contact__c).Available_Balance__c == null){
                        mapOfCon.get(tranEntry.contact__c).Available_Balance__c = tranEntry.Amount__c;
                    }
                    else{
                        mapOfCon.get(tranEntry.contact__c).Available_Balance__c = mapOfCon.get(tranEntry.contact__c).Available_Balance__c + tranEntry.Amount__c;
                    }

                    sendEmail(mapOfCon.get(tranEntry.contact__c).Account_Number__c, tranEntry.Type__c, tranEntry.Amount__c, tranEntry.Transaction_Date__c, mapOfCon.get(tranEntry.contact__c).Available_Balance__c, mapOfCon.get(tranEntry.contact__c).OwnerId);
                    
                }
            }
            else{
                tranEntry.addError('Contact Record is Deactivated you can\'t create entry record');
            }
        }

        if(!mapOfContactForUpdation.isEmpty()){
            update mapOfContactForUpdation.values();
        }

        if(!mapOfTransactionEntryUpdation.isEmpty()){
            update mapOfTransactionEntryUpdation.values();
        }      
    }
    
    /**
    *  Description     :  When type will be update as a cancelled then it will be fire and amount 
    *                     will be readjust on the contact field
    *
    *  Created By      :  Jay Chand Yadav
    *
    *  Created Date    :  09/21/2022
    *
    *  Revision Logs   :  V1.0 - Created - jay Chand Yadav
    **/
    public static void updateEntries(list<Transaction_Entry__c> listOfUpdateRecord){

        List<Contact> listOfCon = new List<Contact>();
        List<Id> listOfContactId = new List<Id>();
        for(Transaction_Entry__c entry: listOfUpdateRecord){
            if(entry.status__c == 'Cancelled'){
				listOfContactId.add(entry.contact__c);
            }           
        }

        Map<Id, Contact> mapOfContact = new Map<Id, Contact>([Select id, Available_Balance__c From Contact Where Id In: listOfContactId]);
        for(Transaction_Entry__c entryRecord : listOfUpdateRecord){
            if(listOfContactId.contains(entryRecord.Contact__c)){
                if(entryRecord.type__c == 'Debit'){
                    mapOfContact.get(entryRecord.contact__c).Available_Balance__c = mapOfContact.get(entryRecord.contact__c).Available_Balance__c + entryRecord.Amount__c;
                }
                else{
                    mapOfContact.get(entryRecord.contact__c).Available_Balance__c = mapOfContact.get(entryRecord.contact__c).Available_Balance__c - entryRecord.Amount__c;
                }
            }
        }
        if(!mapOfContact.isEmpty()){
            update mapOfContact.values();
        }
    }

    /**
    *  Description     :  Send the Entries type and amount on the owner the email
    *
    *  Created By      :  Jay Chand Yadav
    *
    *  Created Date    :  09/10/2022
    *
    *  Revision Logs   :  V1.0 - Created - jay Chand Yadav
    **/
     public static void sendEmail(String accountNumber, String type, Decimal amount, Date transacDate, Decimal availableBalance, String ownerEmail){
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> sendTo = new List<String>();
        sendTo.add(ownerEmail);
        mail.setToAddresses(sendTo);
        mail.setSubject('Account Details ');
        String body = 'Your A/C ' + accountNumber + ' is ' + type + ' by Rs.[' + amount + '] on [' + transacDate + '] Available Bal: Rs.[' + availableBalance + ']';
        mail.setHtmlBody(body);
        mails.add(mail);       
        Messaging.sendEmail(mails);        
    }
}