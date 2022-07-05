/**
*  Description     :  This Keyword And Instanceof Keyword
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/29/2022
*
*  Revision Logs   :    V1.0 - Created - Jay Chand Yadav
**/
public virtual class ThisKeywordAndInstanceofKeyword {

    // Using this keyword
    public class MyTestThis {

        string s;
        {
            this.s = 'TestString';           // Store the value in s string using this keyword
        }
        public String display() {

            System.debug(s);
            return s;
        }
    }

    // Call the parameterized constructor using this keyword with pararmeter
    public class TestThis {

        // First constructor for the class. It requires a string parameter.
        public TestThis(string s2) {

            System.debug(s2);
        }

        // Second constructor for the class. It does not require a parameter.
        // This constructor calls the first constructor using the this keyword.
        public TestThis() {
        
            this('None');
        }
    }

    // Call the default constructor to parameterized constructor using this keyword
    public class ThisClass {

        // Default Constructor
        public ThisClass() {

            System.debug('Default Constructor');
        }

        // Parameterized constuctor
        public ThisClass(Integer num) {

            this();
            System.debug('Parameterized Constructor');
        }
    }

    /**
    *  Description     :  Using instanceOf keyword to verify the object
    *
    *  Created By      :  Jay Chand Yadav
    *
    *  Created Date    :  06/29/2022
    *
    *  Revision Logs   :    V1.0 - Created - Jay Chand Yadav
    **/
    public class InstanceofKeyword {

        public InstanceofKeyword() {

            sObject s = new Account();
            //This one is correct typecasting
            Account a = (Account)s;

            // It is wrong, Run Time Error
            // Contact c = (Contact)s;

            if(s instanceOf Account)
                Account account_1 = (Account)s;
            
            else if(s instanceOf Contact)
                Contact contect_1 = (Contact)s;    
        }
    }
}