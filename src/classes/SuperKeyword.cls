/**
*  Description     :  Use Super Keyword for calling parent class properties
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/29/2022
*
*  Revision Logs   :    V1.0 - Created - Jay Chand Yadav
**/
public virtual class SuperKeyword {
    
    // Parent class
    public virtual class Parent {

        public virtual void display() {

            System.debug('Parent class');
        }
    }

    // Child class inheriting parent class
    public virtual class  Child extends Parent {

        public override virtual void display() {

            super.display();                                      // call the parent class display method
            System.debug('Child Class');
        }
    }
}
