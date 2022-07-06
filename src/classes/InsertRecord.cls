/**
*  Description     :  Insert and update records on Account object using insert and update keyword
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  07/04/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public with sharing class insertAccountRecord {

    public insertAccountRecord() {

        Account acc = new Account();
        acc.Name = 'Smith';
        acc.AccountNumber = '65435454';
        acc.Site = 'https://www.gsorklalrtgjhj';
        acc.AnnualRevenue = 345;

        insert acc;

        Account acc_1 = new Account(Name='Aaron', AccountNumber='123345', AnnualRevenue=550, NumberOfEmployees=1000, Phone='539759');

        insert acc_1;

        sObject acc_2 = new Account();
        acc_2.put('Name','Sk');

        List<Account> acc_3 = [SELECT Id, Name, Owner.id,
        Owner.name, CreatedbyId, Createdby.name FROM Account LIMIT 5];

        List<Account> acc_4 = [SELECT Name FROM Account Where Name = 'Aaron'];
        for(Account accName : acc_4) {
            if(accName.Name.equals('Aaron')) {
                accName.Name = 'Aron';
            }
        }
 
        update acc_4;
    }
}
