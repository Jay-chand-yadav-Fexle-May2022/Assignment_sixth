trigger TransactionEntry_Trigger on Transaction_Entry__c (before insert, after insert, before update) {

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            TransactionEntryTiggerHandler.transaction(Trigger.new);
        }
    }
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            TransactionEntryTiggerHandler.updateEntries(Trigger.new);
        }
    }
}