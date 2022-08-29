/**
*  Description     :  Trigger will be fire whenever we will perform any DML on State Object
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  08/19/2022
*
*  Revision Logs   :  V1.0 - Created - Jay Chand Yadav
**/
trigger Trigger_State on State__c (after insert, after delete, after update) {
    if(Trigger.isInsert){
        if(Trigger.isAfter){
            StateTriggerHandler.insertState(Trigger.new);
        }
	}
    else if(Trigger.isDelete){
        if(Trigger.isAfter){
            StateTriggerHandler.deleteState(Trigger.old);
        }
        
    }
    else if(Trigger.isUpdate){
        if(Trigger.isAfter){
            StateTriggerHandler.updateState(Trigger.new, Trigger.old);
        }
    }
}