/**
*  Description     :  Method OverRiding
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/28/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public virtual class MethodOverRiding {

    /**
    *  Description     :  Parent Class 
    *
    *  Created By      :  Jay Chand Yadav
    *
    *  Created Date    :  06/28/2022
    *
    *  Revision Logs   :    V1.0 - Created - jay Chand Yadav
    **/
    public virtual class ParentClass {

        public  Integer globalNum = 10;
        public Integer classNum = 20;
        private Integer classNum_1 = 30;
        protected Integer abc = 40;

        // Display the data
        public virtual void display() {

            System.debug('globalNum -> ' + globalNum);
            System.debug('classNum -> ' + classNum);
            System.debug('classNum_1 -> ' + classNum_1);
            System.debug('abc -> ' + abc);
        }
    }

    /**
    *  Description     :  Child Class 
    *
    *  Created By      :  Jay Chand Yadav
    *
    *  Created Date    :  06/28/2022
    *
    *  Revision Logs   :    V1.0 - Created - jay Chand Yadav
    **/
    public virtual class ChildClass extends ParentClass {

        // Override the method
        public override void display() {

            super.display();                 // call the parent class method
            System.debug('OverRiding');
        }
    }
}