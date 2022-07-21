/**
*  Description     :  Trigger work when user enter new record
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  07/21/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
trigger TriggerAccount on Account (before insert, after insert) {
	
    if(Trigger.isInsert) {
    	if(Trigger.isBefore) 
        {
            AccountTriggerHandler.updateTheAccountsNumber(Trigger.New);
        }
        
        if(Trigger.isAfter) {
        	AccountTriggerHandler.sendEmail(Trigger.New);
    	}
    }  
}
