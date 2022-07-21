/**
*  Description     :  Test the working of Trigger.New and Trigger.Old
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  07/21/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
trigger Trigger_Account on Account (before insert, before update) {
	if(Trigger.isBefore){
        
        system.debug('Checking in Before Trigger Operations');
        if(Trigger.isInsert){
            
            system.debug('Check Insert List ::: Trigger.New ' + Trigger.New);
            system.debug('Check Insert List ::: Trigger.old ' + Trigger.old);
        }
        if(Trigger.isUpdate){
            
            system.debug('Check Update List ::: Trigger.New ' + Trigger.New[0].Name + 'Updated');
            system.debug('Check Update List ::: Trigger.old ' + Trigger.old);
            
            if(Trigger.New[0].Type != Trigger.old[0].Type){
                
                system.debug('Type Value Changed');
                system.debug('Trigger.New Data' + Trigger.New[0].Type);
                system.debug('Trigger.old Data' + Trigger.old[0].Type);
            }
        }
    }
    if(Trigger.isAfter){
    
        system.debug('Checking in After Trigger Operations');
    }
}