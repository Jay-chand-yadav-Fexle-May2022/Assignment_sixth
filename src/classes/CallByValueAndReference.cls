/**
*  Description     :  Call By Value And Reference
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/28/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public with sharing class CallByValueAndReference {
    
    // Swapping between two values
    public static void swapWithValue(Integer value_1, Integer value_2) {

        Integer value_3;
        value_3 = value_1;
        value_1 = value_2;
        value_2 = value_3;
        System.debug('Swapped values are ' +  value_1 + ' ' + value_2);
    }

    // Call By Value
    public static void  callByValue() {

        Integer value_1 = 7, value_2 = 4;
        System.debug('Original values are '  + value_1 + ' ' + value_2);
        swapWithValue(value_1, value_2);
        System.debug('The values after swap ' + value_1 + ' ' + value_2);
    }

    // Swapping between two references 
    public static void swapWithReference(List<Student__c> stData) {

        for(Student__c str : stData) {
            str.Name = str.Name + '1';
        }
    }

    // Call By Reference
    public static void callByReference() {

        Student__c student = new Student__c();
        List<Student__c> studentName = new List<Student__c>();
        studentName = [SELECT Name FROM Student__c ];
        swapWithReference(studentName);

        for(Student__c str : studentName)
            System.debug(str);
    }
}