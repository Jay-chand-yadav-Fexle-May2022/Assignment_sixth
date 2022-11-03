trigger Contact_Trigger on Contact (before delete) {

    if(Trigger.isBefore){
        if(Trigger.isDelete){
            ContactTriggerHandler.checkRecordsOnContactChild(Trigger.newMap);
        }
    }
}