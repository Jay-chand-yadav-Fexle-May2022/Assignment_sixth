/**
*  Description     :  Account trigger handler class which is creating account number during insertion 
*                     record and compare the industry then send the mail with detail of account
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  07/21/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public with sharing class AccountTriggerHandler {
    
    // Create random account number and compare the industry
    public static void updateTheAccountsNumber(List<Account> listOfAccount) {
        
        for(Account acc : listOfAccount) {
            Integer len = 14;
	    String str = string.valueof(Math.abs(Crypto.getRandomLong()));
	    System.debug(str);
	    String randomNumber = str.substring(0, len);
            system.debug('Random Number-' + randomNumber);
			
            if(acc.Type == 'Saving') {
                acc.AccountNumber = 'SB-' + randomNumber;
            }
            else if(acc.Type == 'FD') {
                acc.AccountNumber = 'FD-' + randomNumber;
            }
        }
    }
    
    // Send the mail of the user with the account details
    public static void sendEmail(List<Account> listOfAccount) {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for(Account acc : listOfAccount) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendTo = new List<String>();
            sendTo.add('jaychand.yadav@fexle.com');
            mail.setToAddresses(sendTo);
            mail.setSubject('Account has created ');
            String body = 'Dear ' + acc.Name + ', ';
            body += 'Congratulations you account type is ' + acc.Type + ' and your account number is ' + acc.AccountNumber;
            mail.setHtmlBody(body);
            mails.add(mail);
        }
        Messaging.sendEmail(mails);
    }
}
