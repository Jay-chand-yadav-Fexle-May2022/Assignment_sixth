/**
*  Description     :  Download the PDF as per user require arguments
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  09/14/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
public with sharing class Records_PDF_Controller {
    public List<Transaction_Entry__c> transaction_Entry_List{get;set;}
    public String startDateString {set;get;}
    public String endDateString {set;get;}
    public Contact contact_Object{set;get;}

    public Records_PDF_Controller() {
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=BankStatement.pdf');
    }

    public void recordPdf(){
        Id idOfContacts = ApexPages.currentPage().getParameters().get('id');
        String newStartDate = ApexPages.currentPage().getParameters().get('startdate');
        String newEndDate = ApexPages.currentPage().getParameters().get('enddate');

        Date startDate = Date.valueOf(newStartDate);
        Date endDate = Date.valueOf(newEndDate);

        System.debug('Startdate ==========> ' + startDate);
        System.debug('Enddate ============> ' + endDate);
        String stringStartDate = String.valueOf(date.newinstance(startDate.year(), startDate.month(), startDate.day()));
        String stringEndDate = String.valueOf(date.newinstance(endDate.year(), endDate.month(), endDate.day()));
        System.debug('------stringStartDate ' + stringStartDate);
        System.debug('-------stringEndDate---' + stringEndDate);
        Transaction_Entry_List  = [SELECT Id, Name, Transaction_Date__c, Amount__c,  Type__c, Status__c 
                                   FROM Transaction_Entry__c WHERE Contact__c = :idOfContacts 
                                   AND CreatedDate >= :startDate AND CreatedDate <= :endDate];
                                   System.debug('List Of Records'+Transaction_Entry_List);

        contact_Object = [SELECT Id, Title, Name , Email, Account_Number__c FROM Contact WHERE ID = :idOfContacts];
        System.debug('Contacts' +contact_Object);

        startDateString = newStartDate;
        endDateString = newEndDate;
    }

    
}
