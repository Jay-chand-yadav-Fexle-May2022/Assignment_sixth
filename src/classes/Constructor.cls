/**
*  Description     :  Constructor
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/28/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public with sharing class Constructor {

    private static final Integer DEFAULT_SIZE = 10;

    // First a no-argument constructor 
    public Constructor() {

        System.debug(DEFAULT_SIZE);
    }

    // A constructor with one argument
    public Constructor(Boolean call) {

        System.debug('call -> ' + call);
    }

    // A constructor with two arguments
    public Constructor(String email, Boolean call) {

        System.debug('Email -> ' + email + ' call -> ' + call);
    }

    // Though this constructor has the same arguments as the 
    // one above, they are in a different order, so this is legal
    public Constructor(Boolean call, String email) {

        System.debug('call -> ' + call + ' email -> ' + email);
    }  
}