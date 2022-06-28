/**
*  Description     :  Loops
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/28/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public with sharing class Loops {
    
    /**
    *   @description    :  Do-While Loop
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 28/06/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void doWhileLoop() {

        Integer count = 1;

        do {
            System.debug(count);
            count++;
        } while (count < 11);

        count = 0;
        String values = '';

        do {
            values += count + ' ';
            count += 2;
        } while(count <= 100);
        System.debug(values);

        String value_1 = 'Hello';
        Integer i = 1;

        do {
            if(value_1.equals('Hello')) {
                System.debug(value_1);
                value_1 = 'World';
            } else {
                System.debug(value_1);
                value_1 = 'Hello';
            } 
            i++;
        } while(i <= 20);
    }

    /**
    *   @description    :   While Loop
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 28/06/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void whileLoop() {

        Integer count = 1;

        while (count < 11) {
            System.debug(count);
            count++;
        }

        count = 1;
        
        while(count <= 100) {

            if(math.mod(count,2) == 0) {
                System.debug('Even ' + count);
            }
            else {
                System.debug('Odd ' + count);
            }
            count++;
        }
    }

    /**
    *   @description    :  For Loop
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 28/06/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void forLoop() {

        String value_1 = '';

        for (Integer i = 0; i < 10; i++) {
            value_1 += i + ' ';
        }
        System.debug(value_1);

        for(Integer j = 0; j<10; j++) {
            System.debug('Hello World');
        }

        for(Integer k = 1; k <= 100; k++) {
            if(Math.mod(k,2) == 0) {
                System.debug('Even');
            } else {
                System.debug('Odd');
            }
        }
    }

    /**
    *   @description    :  For Each Loop
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 28/06/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void listOrSetIterationforLoops() {

        Integer[] myInts = new Integer[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

        for (Integer i : myInts) {
            System.debug(i);
        }
        
        // Add Integer value in list
        List<Integer> myList = new List<Integer>();
        myList.add(1);
        myList.add(2);
        myList.add(3);
        myList.add(4);
        myList.add(5);

        for (Integer num : myList) {
            System.debug(num);
        }

        // Add String value in list
        List<String> myList_1  = new List<String>();
        myList_1.add('Hey');
        myList_1.add('Hi');
        myList_1.add('Hello');
        myList_1.add('World');

        for(String str : myList_1) {
            System.debug(str);
        }

        // Add Integer value in set
        Set<Integer> mySet = new Set<Integer>();
        mySet.add(1);
        mySet.add(2);
        mySet.add(3);
        mySet.add(4);
        mySet.add(5);

        for(Integer num : mySet) {
            System.debug(num);
        }
    }

    /**
    *   @description    :  Iterating Collections
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 28/06/2022 - Developer Name - Jay Chand Yadav
    **/
    public static void iteratingCollections() {

        List<Integer> myList = new List<Integer>();
        for(Integer i = 1; i <= 5; i++) {
            myList.add(i);
            System.debug(myList.get(i-1));
        }

        // Add value in the list during iteration
        for(Integer j = 0; j < 5; j++) {
            if(Math.mod(myList.get(j),2) == 0) {
                myList.add(myList.get(j)+4);
            }
        }

        for(Integer num : myList) {
            System.debug(num);
        }
        
        // Add value in list
        List<String> companyinfos = new List<String>();
        companyinfos.add('a1');
        companyinfos.add('a2');
        companyinfos.add('a3');
        companyinfos.add('b1');
        companyinfos.add('b2');

        // Remove value from list during iteration
        for (Integer i = (companyinfos.size()-1) ; i>= 0 ; i--){
            String s = companyInfos[i];

            if(s.contains('a')) {
                companyinfos.remove(i);
            }
        }

        // Printing list values
        for(String str : companyInfos) {
            System.debug(str);
        }

        // Add values in set
        Set<String> city = new Set<String>();
        city.add('Delhi');
        city.add('Noida');
        city.add('Lucknow');
        city.add('Pune');
        city.add('Mumbai');

        // Remove values to set during iteration
        for(String str : city) {
            if(str.equals('Delhi') || str.equals('Mumbai')) {
                city.remove(str);
            }
        }

        // Printing Set values
        for(String str : city) {
            System.debug(str);
        }

        // Add key and value in Map
        Map<String, String> stateWithCapital = new Map<String, String>();
        stateWithCapital.put('Mp', 'Bhopal');
        stateWithCapital.put('Up', 'Lucknow');
        stateWithCapital.put('Tamilnadu', 'Chennai');
        stateWithCapital.put('Bihar', 'Patna');
        stateWithCapital.put('Maharashtra', 'Mumbai');
        stateWithCapital.put('Punjab', 'Chandigarh');
        
        // Remove Key from Map which value equal to 'Patna' and 'Mumbai' during iteration
        for(String str : stateWithCapital.keySet()) {
            if(stateWithCapital.get(str).equals('Patna') || stateWithCapital.get(str).equals('Mumbai')) {
                stateWithCapital.remove(str);
            }
        }

        // Printing value of stateWithCapital map
        for(String str : stateWithCapital.keySet()) {
            System.debug(str + ' ' + stateWithCapital.get(str));
        }
    }
}