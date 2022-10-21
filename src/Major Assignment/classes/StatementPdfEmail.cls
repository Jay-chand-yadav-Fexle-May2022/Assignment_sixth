/**
*  Description     :  Send the Entries record PDF on the owner email id
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  09/19/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
public with sharing class StatementPdfEmail {
    /**
    *  Description     :  Taking argument through the users and displaying results
    *
    *  Created By      :  Jay Chand Yadav
    *
    *  Created Date    :  09/19/2022
    *
    *  Revision Logs   :  V1.0 - Created - jay Chand Yadav
    **/
    @AuraEnabled(cacheable=true)
    public static void sendEmail(Id recordIdOfContact, String start_Date, String end_Date){
        //Setting page reference
        PageReference statementPDFRef = new PageReference('/apex/Download_PDF');
        System.debug('============== Id  ========== ' + recordIdOfContact);
        System.debug('============== statementPDFRef ========== ' + statementPDFRef);

        System.debug('startdate ====> ' + start_Date + '=======> ' + end_Date);
        //putting value to page 

        statementPDFRef.getParameters().put('id', recordIdOfContact);
        statementPDFRef.getParameters().put('startdate', start_Date);
        statementPDFRef.getParameters().put('enddate', end_Date);

        //To hold pdf body
        Blob bodyOfPDF;

        //For testing class
        if(Test.isRunningTest()){
            bodyOfPDF = blob.valueOf('Unit.Test');
            System.debug(' bodyOfPDF 1  ====================>  ' + bodyOfPDF);
        }else{
            //Content of pdf
            bodyOfPDF = statementPDFRef.getContent();
            System.debug(' bodyOfPDF 2  =====================>  ' + bodyOfPDF);
        }

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        //File attachment
        Messaging.EmailFileAttachment att = new Messaging.EmailFileAttachment();
        
         System.debug('================== Before SOQL ============ ');
        //Calling contact_obj for email body
        Contact contact_obj = [SELECT Id, Name, Email, Account_Number__c FROM Contact WHERE Id =: recordIdOfContact];

        System.debug('================== Contact Record  ============ ' + contact_Obj);

        //formating account number
        String accountNumberFormat = 'AccNo-XXX'+ contact_Obj.Account_Number__c.substringAfter('-').right(2);

        //set address
        email.setToAddresses(new String[] {contact_obj.Email});

        //set subject
        email.setSubject('Requested Bank Statement');

        //set HTML body
        email.setHtmlBody('Hello '+ contact_obj.Name + ', <br><br> As you have requested, Account statement for your account is attached below. ');

        //set attachment
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {att});

        //Defination of attachment
        att.setContentType('application/pdf');
        att.setFileName('Bank_Statement.pdf');
        att.setBody(bodyOfPDF);

        //send email
        Messaging.sendEmail(new messaging.SingleEmailMessage[] {email});

    }
}