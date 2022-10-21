/**
*  Description     :  Send the record on owner email, last day of the months
*                     
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  09/15/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
global class EmailOfTransactionEntriesRecord implements Schedulable  {
	
    global void execute(SchedulableContext ctx){
        
        Integer mnth = System.Today().Month();

        // Collection of contact ids which is used in transaction entry
        Set<Id> setOfConId = new Set<Id>();
        // Map store contact ia as a id and store Entry record as a value
        Map<Id, List<Transaction_Entry__c>> mapOfTransactionEntry = new Map<Id, List<Transaction_Entry__c>>();

        for(Transaction_Entry__c transEntry: [
		SELECT Id, Type__c, Amount__c, Contact__c, Transaction_Date__c FROM Transaction_Entry__c
		WHERE CALENDAR_MONTH(Transaction_Date__c) =: mnth
		AND status__c = 'Completed']){
            
            setOfConId.add(transEntry.contact__c);

            if(mapOfTransactionEntry.containsKey(transEntry.contact__c)){
                mapOfTransactionEntry.get(transEntry.contact__c).add(transEntry);
            }
            else{
                mapOfTransactionEntry.put(transEntry.contact__c, new List<Transaction_Entry__c>{transEntry});
            }
        }
		System.debug('mapOfTransactionEntry ============> ' + mapOfTransactionEntry);
        for(Contact con: [SELECT Id, Account_Number__c,OwnerId, Available_Balance__c FROM Contact WHERE status__c = 'Active' AND Id IN: setOfConId]){
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();        
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendTo = new List<String>();
            sendTo.add(con.OwnerId);
            mail.setToAddresses(sendTo);
            mail.setSubject('Account Details ');
            String body = '';
            body = '<table border="1" style="border-collapse: collapse"><caption style="font-weight:bold;text-align: left;">Transaction Detail:<br/><br/></caption><tr><th>Account number</th><th>Type</th><th>Amount</th><th>Date</th></tr>';
            
            for(Transaction_Entry__c thisMonthEntryRecord: mapOfTransactionEntry.get(con.id)){
		body += '<tr><td>'+ '&nbsp;' + con.Account_Number__c + '&nbsp;'  +'</td><td>' + '&nbsp;' + thisMonthEntryRecord.type__c + '&nbsp;' + '</td><td>' +  '&nbsp;&nbsp;' + thisMonthEntryRecord.Amount__c + '&nbsp;' +'</td><td>'+ '&nbsp;' + thisMonthEntryRecord.Transaction_Date__c + '&nbsp;'  + '</td></tr>';
            }
            
            body += '</table>';
            String body1 = '';
            body1 = '<br/> Available Balance: ' + con.Available_Balance__c;
            body += body1;
            mail.setHtmlBody(body);
            mails.add(mail);       
            Messaging.sendEmail(mails); 
        }
        
        //YourScheduleApexClass s=new YourScheduleApexClass();
		//s.excute(null) ;
    }
}
