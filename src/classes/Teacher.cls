public class Teacher {
        public static void insertStudent {
        Teacher__c teacher = new Teacher__c();
        
        // Student Personal Info
 	teacher.Name = 'Michel';
        teacher.Roll_Number__c = 80;
        teacher.Father_Name__c = 'Finch';
        teacher.Mobile_Number__c = '894590340';
        teacher.Father_Mobile_Number__c = '989404300';
        teacher.HomePhone__c = '845839490';
        teacher.Email__c = 'michel39@gmail.com';
        teacher.Address__c = 'roland 153 street berlin, russia';
        teacher.Overall_Grade__c = 'B+';
        
        // Class Info
        teacher.Stream__c = 'Maths';
        teacher.Class__c = '12th';
        teacher.Section__c = 'B';
        
        // Fees Details
        teacher.Current_Year__c = 4;
        teacher.Fees_Submitted__c = 'Yes';
        teacher.Pending_Fees_Amount__c = 300;
        teacher.Pending_Exam_Fees__c = 20;
        teacher.Exam_Fees_Submitted__c = 'No';
        
        // Semester Details
        teacher.X1st_Sem_Percentage__c = 68;
        teacher.X1st_Sem_Back__c = 'No';
        teacher.X2nd_Sem_Percentage__c = 80;
        teacher.Subjects_in_which_Back__c = 'NA';
        teacher.X4th_Sem_Percentage__c = 81;
        teacher.X3rd_Sem_Back__c = 'No';
        teacher.Subjects_in_which_Back1__c = 'NA';
        teacher.X4th_Sem_Back__c = 'Yes';
        teacher.Subjects_in_which_Back2__c = 'Math';   
        
        insert teacher;         
        }
		
        // Fetch students records from UI
        public static void fetchRecords() {
 		List<Teacher__c> records = [ SELECT id, Name, Roll_Number__c, Father_Name__c, Mobile_Number__c, Father_Mobile_Number__c, HomePhone__c, Email__c, Address__c, Overall_Grade__c, Stream__c,  Class__c, Section__c, Current_Year__c, Fees_Submitted__c, Pending_Fees_Amount__c, Pending_Exam_Fees__c, Exam_Fees_Submitted__c from Teacher__c order by createdDate DESC LIMIT 8];
  	    	for(Teacher__c student : records) {
        	system.debug('Check Student Records : '+ student);
        	}
         }
}
