public class Student {
    public static void InserttRecord() {
       /* Student__c s2 = new Student__c();
		s2.name = 'Telusko';
        s2.Roll_Number__c = 2548552;
		s2.Salary__c = 12534;
		s2.Today_date__c = SYSTEM.today();
        s2.User_Email__c= 'telusko12@gmail.com';
        s2.Total_Percent__c = 88;
		s2.Father_name__c = 'jofff';
        s2.Linkdln__c = 'https://ben234linkldn';
        insert s2; */
        
        List<Student__c> studentList = [select id, name, Roll_Number__c, Salary__c from Student__c order by createdDate DESC LIMIT 9];
        for(Student__c student : studentList) {
            system.debug('Check Student Records : '+ student);
        }
    } 
}