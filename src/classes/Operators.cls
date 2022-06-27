/**
*  Description     :  Operators
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/26/2022
*
*  Revision Logs   :    V1.0 - Created - Jay Chand Yadav
**/
public with sharing class Operators {
    
    // Assignment Operator
    public static void assignmentOperator() {

        Integer num_1 = 1;
        Integer num_2 = 2;
        num_1 = num_2;
        System.debug(num_1);          // 2
    }

    // Addition Assignment Operator
    public static void additionAssignmentOperator() {

        Integer num_1 = 1;
        Integer num_2 = 2;
        num_1 += num_2;
        System.debug(num_1);         // 3
    }

    // Multiplication Assignment Operator
    public static void multiplicationAssignmentOperator() {

        Integer num_1 = 3;
        Integer num_2 = 2;
        num_1 *= num_2;
        System.debug(num_1);        // 6
    }

    // Subtraction Assignment Operator
    public static void subtractionAssignmentOperator() {

        Integer num_1 = 3;
        Integer num_2 = 2;
        num_1 -= num_2;
        System.debug(num_1);       // 1
    }

    // Division Assignment Operator
    public static void divisionAssignmentOperator() {

        Double num_1 = 20;
        Integer num_2 = 4;
        System.debug(num_1 /= num_2); // 5
    }

    // OR Assignment Operator
    public static void  orAssignmentOperator() {

        Boolean x = false;
        Boolean y = false;
        x |= y;
        System.debug(x);         // false

        x = true;
        y = false;
        x |= y;
        System.debug(x);        // true
    }

    // AND Assignment Operator
    public static void andAssignmentOperator() {

        Boolean x = true;
        Boolean y = true;
        x &= y;
        System.debug(x);       // true

        x = true;
        y = false;
        x &= y;
        System.debug(x);       // false
    }

    // Bitwise Shift Left Assignment Operator
    public static void bitwiseShiftLeftAssignmentOperator() {

        Integer value_1 = 8;    // binary value is 0001000
        Integer value_2 = 2;    // two times shift value_1 digits in left side ant it will be put 0 value
        value_1 <<= value_2;
        System.debug(value_1);  // 00100000
    }

    // Bitwise Shift Right Signed Assignment Operator
    public static void bitwiseShiftRightSignedAssignmentOperator() {

        Integer value_1 = 8;    // binary value is 0001000
        Integer value_2 = 2;    // two times shift value_1 digits in right side and will put 0 value
        value_1 >>= value_2;
        System.debug(value_1);  // 00000010
    }

    // Ternary Operator
    public static void ternaryOperator() {

        Integer x,y;
        x = 20;
        y = (x==1)?61:90;
        System.debug(y);        // 90
    }

    // AND Logical Operator
    public static void andLogicalOperator() {

        Boolean val_1 = true;
        Boolean val_2 = false;
        System.debug(val_1 && val_2);
        val_1 = true;
        val_2 = true;
        System.debug(val_1 && val_2);
        val_1 = false;
        val_2 = false;
        System.debug(val_1 && val_2);
    }

    // OR Logical Operator
    public static void orLogicalOperator() {

        Boolean value_1 = true;
        Boolean value_2 = false;
        System.debug(value_1 || value_2);
        value_1 = false;
        value_2 = true;
        System.debug(value_1 || value_2);
        value_1 = false;
        value_2 = false;
        System.debug(value_1 || value_2);
    }

    // Equality Operator
    public static void equalityOperator() {

        Integer num_1 = 33;
        Integer num_2 = 44;
        System.debug(num_1 == num_2);
    }

    // Less Than Operator
    public static void lessThanOperator() {

        Integer value_1 = 2;
        Integer value_2 = 4;
        System.debug(value_1 < value_2);
    }

    // Greater Than Operator
    public static void greaterThanOperator() {

        Integer value_1 = 5;
        Integer value_2 = 6;
        System.debug(value_1 > value_2);
    }

    // Less Than Or Equal To Operator
    public static void lessThanOrEqualToOperator() {

        Integer val_1 = 6;
        Integer val_2 = 6;
        System.debug(val_1 <= val_2);
    }

    // greater Than Or EqualTo Operator
    public static void greaterThanOrEqualToOperator() {

        Integer val_1 = 6;
        Integer val_2 = 5;
        System.debug(val_1 >= val_2);
    }

    // inequality Operator
    public static void inequalityOperator() {

        Integer val_1 = 6;
        Integer val_2 = 6;
        System.debug(val_1 != val_2);
    }

    // additionOperator
    public static void additionOperator() {

        Integer val_1 = 3;
        Integer val_2 = 4;
        System.debug(val_1 + val_2);
    }

    // subtractionOperator
    public static void subtractionOperator() {

        Integer num_1 = 10;
        Integer num_2 = 3;
        System.debug(num_1 - num_2);
    }

    // multiplicationOperator
    public static void multiplicationOperator() {

        Integer num_1 = 10;
        Integer num_2 = 3;
        System.debug(num_1 * num_2);
    }

    // divisionOperator
    public static void divisionOperator() {

        Integer num_1 = 10;
        Integer num_2 = 2;
        System.debug(num_1 / num_2);
    }

    // incrementOperator
    public static void incrementOperator() {

        Integer a = 3;
        System.debug(++a);
        System.debug(a++);
    }

    // decrementOperator
    public static void decrementOperator() {

        Integer val = 10;
        System.debug(--val);
        System.debug(val--);
    }

    // bitwiseANDoperator
    public static void bitwiseANDoperator() {

        Integer val_1  = 2;
        Integer val_2 = 4;
        System.debug(val_1 & val_2);
    }

    // bitwiseORoperator
    public static void bitwiseORoperator() {

        Integer val_1  = 2;
        Integer val_2 = 4;
        System.debug(val_1 | val_2);
    }

    // bitwiseExclusiveORoperator
    public static void bitwiseExclusiveORoperator() {

        Integer val_1  = 2;
        Integer val_2 = 4;
        System.debug(val_1 ^ val_2);
    }

    /**
    *  Description     :  Safe Navigator
    *
    *  Created By      :  Jay Chand Yadav
    *
    *  Created Date    :  06/26/2022
    *
    *  Revision Logs   :    V1.0 - Created - Jay Chand Yadav
    **/
    public class SafeNavigator {

        public void SafeNavigator_1() {

            Account acc = new Account();
            acc.Name = 'test';
            insert acc;
            System.debug([Select Id, Name From Account Where Id=:acc.Id]?.Name);
        }
    } 

    /**
    *  Description     :  Operators Precedence
    *
    *  Created By      :  Jay Chand Yadav
    *
    *  Created Date    :  06/26/2022
    *
    *  Revision Logs   :    V1.0 - Created - Jay Chand Yadav
    **/
    public class OperatorPrecedence {

        // iterationPrecedence
        public void iterationPrecedence() {      

            Integer a = 10, b = 5, c = 1, result;
    	    result = a-++c-++b;
    	    System.debug(result);       // 2

            Integer num_1 = 10, num_2 = 5, num_3 = 1, result1;
    	    result1 = num_1 - --num_3 - ++num_2;
    	    System.debug(result1);       // 4
        }

        // multiplicationAndDivision
        public void multiplicationAndDivision() {

            Integer value_1 = 50;
            Integer value_2 = 5;
            Integer value_3 = 7;
            System.debug(value_1 * value_2 / value_3); // 35
        }

        // additionAndSubtraction
        public void additionAndSubtraction() {

            Integer item_1 = 2;
            Integer item_2 = 4;
            Integer item_3 = 2;
            System.debug(item_1 + item_2 - item_3);  // 4
        }
        
        // shiftOperators
        public void shiftOperators() {

            System.debug(23 >> 7 << 2);   // 0
        }
    }

    /**
    *  Description     :  Type Casting
    *
    *  Created By      :  Jay Chand Yadav
    *
    *  Created Date    :  06/26/2022
    *
    *  Revision Logs   :    V1.0 - Created - Jay Chand Yadav
    **/
    public class TypeCasting {

        public void convertions() {
            
            // Convertion Double To Integer
            Double item_1 = 2.355;
            //Integer num_1 = item_1;      It will not work compile time error
            Integer num_1 = (Integer) item_1;  
            System.debug(num_1);

            //Convertion Integer To Double
            Integer item_2 = 23432;
            Double num_2 = item_2;
            System.debug(num_2);

            // Convertion Long to Integer
            Long item_3 = 346565L;
            Integer num_3 = (Integer) item_3;
            System.debug(num_3);

            // Convertion Integer To Long
            Integer item_4 = 436545;
            Long num_4 = item_4;
            System.debug(num_4);
        }
    }
}