public with sharing class StudentRecord {

    public static void yogaClass() {
        
        //Student__c student = new Student__c();
        // Hierarchical Collection example using Map and List
        Map<String, Map<String, List<Student__c>>> yogaClassMap = new Map<String, Map<String, List<Student__c>>>();

        // 1st Year List of Student
        List<Student__c> firststYearListComputer = new List<Student__c>();
        firststYearListComputer = [SELECT ID, Name, Roll_Number__c, ClassName__c, Stream__c from Student__c where ClassName__c = '1stYear' and Stream__c = 'Computer'];
        Map<String, List<Student__c>> mapOfStudentwithStream1stYear = new Map<String, List<Student__c>>();
        mapOfStudentwithStream1stYear.put('Computer Science', firststYearListComputer);

        // 1st Year List of Student
        List<Student__c> firststYearListComputer_1 = new List<Student__c>();
        firststYearListComputer_1 = [SELECT ID , Name, Roll_Number__c, ClassName__c, Stream__c from Student__c where ClassName__c = '1stYear' and Stream__c = 'Electronic'];
        mapOfStudentwithStream1stYear.put('Electronic',firststYearListComputer_1);

        // 2st Year List of Student
        List<Student__c> secondYearListElectronic = new List<Student__c>();
        secondYearListElectronic = [SELECT ID, Name, Roll_Number__c, ClassName__c, Stream__c from Student__c where ClassName__c = '2nd Year' and Stream__c = 'Electronic'];
        Map<String, List<Student__c>> mapOfStudentwithStream2ndYear = new Map<String, List<Student__c>>();
        mapOfStudentwithStream2ndYear.put('Electronic', secondYearListElectronic);

        yogaClassMap.put('1stYear', mapOfStudentwithStream1stYear);
        yogaClassMap.put('2ndYear', mapOfStudentwithStream2ndYear);
    }

    public static void englishClass() {
        
        // Hierarchical Collection example using Map and List
        Map<String, Map<String, List<Student__c>>> englishClassMap = new Map<String, Map<String, List<Student__c>>>();

        // 1st Year List of Student
        List<Student__c> firststYearListComputer = new List<Student__c>();
        firststYearListComputer = [SELECT ID, Name, Roll_Number__c, ClassName__c, Stream__c from Student__c where ClassName__c = '1stYear' and Stream__c = 'Computer'];
        Map<String, List<Student__c>> mapOfStudentwithStream1stYear = new Map<String, List<Student__c>>();
        mapOfStudentwithStream1stYear.put('Computer Science', firststYearListComputer);

        // 1st Year List of Student
        List<Student__c> firststYearListComputer_1 = new List<Student__c>();
        firststYearListComputer_1 = [SELECT ID , Name, Roll_Number__c, ClassName__c, Stream__c from Student__c where ClassName__c = '1stYear' and Stream__c = 'Electronic'];
        mapOfStudentwithStream1stYear.put('Electronic', firststYearListComputer_1);

        // 2st Year List of Student
        List<Student__c> secondYearListElectronic = new List<Student__c>();
        secondYearListElectronic = [SELECT ID, Name, Roll_Number__c, ClassName__c, Stream__c from Student__c where ClassName__c = '2nd Year' and Stream__c = 'Electronic'];
        Map<String, List<Student__c>> mapOfStudentwithStream2ndYear = new Map<String, List<Student__c>>();
        mapOfStudentwithStream2ndYear.put('Electronic', secondYearListElectronic);

        englishClassMap.put('1stYear', mapOfStudentwithStream1stYear);
        englishClassMap.put('2ndYear', mapOfStudentwithStream2ndYear);
    }
}