/**
*  Description     :  There are three text methods it will be call one by one from js file
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  09/06/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
public with sharing class Textmethod {

    @AuraEnabled(cacheable=true)
    public static String getTextMethod1(){
        return 'METHOD-1';
    }

    @AuraEnabled(cacheable=true)
    public static String getTextMethod2(){
        return 'METHOD-2';
    }

    @AuraEnabled(cacheable=true)
    public static String getTextMethod3(){
        return 'METHOD-3';
    }
}