/**
*  Description     :  Data Provider
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/28/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public with sharing class StudentDataProvider {
    
    // Way of Caching the Data
    public static Student__c stData {

        get {

            if(stData == null) {

                // One Time Run
                stData = [SELECT ID, Name FROM Student__c WHERE Name != NULL];
            }
            return stData;
        }

        set {

            stData.Name = stData.Name + DateTime.now();
            System.debug('Check stData.Name ' + stData.Name);
        }
    }
    // public static Student__c stData{get;set;}
    public static Student__c stData_1;

    @AUraEnabled 
    public static Student__c getStData() {

        Student__c stLocal;

        if(stLocal == null) {

            // stLocal = [SELECT ID, Name FROM Student__c WHERE Name != NULL];
            stLocal = [SELECT ID, Name FROM Student__c LIMIT 1 ];
        }
        return stLocal;
    }

    @AUraEnabled 
    public static Student__c getStData_1() {

        Student__c stData1;
        if(stData1 == null) {

            // stData1 = [SELECT ID, Name FROM Student__c WHERE Name != NULL];
            stData1 = [SELECT ID, Name FROM Student__c LIMIT 1];
        }
        System.debug(stData1);
        return stData1;
    }
}