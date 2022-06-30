/**
*  Description     :  Method OverLoading
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/28/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public with sharing class MethodOverLoading {
    
    // Two parameters with Integer data type
    public static void sum(Integer num_1, Integer num_2) {

        System.debug('Sum of two Integer is : ' + (num_1 + num_2));
    }

    // Three parameters with Integer data type
    public static void sum(Integer num_1, Integer num_2, Integer num_3) {

        System.debug('Sum of three Integer is : ' + (num_1 + num_2 + num_3));
    }

    // Three parameters with Decimal data type
    public static void sum(Decimal num_1, Decimal num_2, Decimal num_3) {

        System.debug('Sum of three Decimal is : ' + (num_1 + num_2 + num_3));
    }   
}