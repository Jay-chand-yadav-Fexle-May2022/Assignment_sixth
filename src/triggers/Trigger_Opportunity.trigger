/**
*  Description     :  Trigger call the opportunityTriggerHandler for insertion and updation on automobiles
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  08/12/2022
*
*  Revision Logs   :  V1.0 - Created - jay Chand Yadav
**/
trigger Trigger_Opportunity on Opportunity (after insert, after update) {
		
    if(Trigger.isInsert || Trigger.isUpdate){
        
        if(Trigger.isAfter){
			OpportunityTriggerHandler.fillRecordOnAutomobilesObjects(Trigger.new);
        }
    } 
}