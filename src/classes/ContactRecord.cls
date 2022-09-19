/**
*  Description     :  Retrieve the all contact record and the class is calling from contactLwc component
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  09/16/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
public with sharing class ContactRecord {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> userContactRecord(){
        return [SELECT Id, Name, Phone, Title FROM Contact];
    }
}