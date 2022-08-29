/**
*  Description     :  Trigger will be fire whenever we will perform any DML on District Object 
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  08/19/2022
*
*  Revision Logs   :  V1.0 - Created - Jay Chand Yadav
**/
trigger Trigger_District on District__c (after insert, after delete, after update) {

    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete){
        if(Trigger.isAfter){
            DistrictTriggerHandler.insertDeleteAndUpdateDistrict(Trigger.new, Trigger.old);
        }
    }
}