/**
*  Description     :  Apex data types
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/24/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public class Datatypes {

	/**
     *   @description    :  Using Different Data types
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 24/06/2022 - Developer Name - Jay Chand Yadav
     **/
    public static void allDataTypes() {

        Boolean flag = true;
        Double d = 5.43254;
        ID id='00300000003T2PGAA0';
        Integer num = 2;
        Long l = 256565659599L;
        system.debug(id);
        Object obj = 10;
		// Cast the object to an integer.
		Integer i = (Integer)obj;
		System.assertEquals(10, i);
        String s = 'The quick brown fox jumped over the lazy dog.';   
    }
    
	/**
     *   @description    :  Using Different Date types
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 24/06/2022 - Developer Name - Jay Chand Yadav
     **/
	public static void allDateTypes() {
    
        //addDays(additionalDays)
        Date myDate = Date.newInstance(1960, 2, 17);
		Date newDate = mydate.addDays(2);
        system.debug(newDate);
        
        //addMonths(additionalMonths)
        date myDate_1 = date.newInstance(1990, 11, 21);
		date newDate_1 = myDate_1.addMonths(3);
		date expectedDate = date.newInstance(1991, 2, 21);
		system.assertEquals(expectedDate, newDate_1);
        
        //addYears(additionalYears)
        date myDate_2 = date.newInstance(1983, 7, 15);
		date newDate_2 = myDate_2.addYears(2);
		date expectedDate_2 = date.newInstance(1985, 7, 15);
		system.assertEquals(expectedDate_2, newDate_2);
        
        //day()
        date myDate_3 = date.newInstance(1989, 4, 21);
		Integer day = myDate_3.day();
		system.assertEquals(21, day);
        
        //dayOfYear()
        date myDate_4 = date.newInstance(1998, 10, 21);
		Integer day_4 = myDate_4.dayOfYear();
		system.assertEquals(294, day_4);
        
        //daysBetween(secondDate)
        Date startDate = Date.newInstance(2008, 1, 1);
		Date dueDate = Date.newInstance(2008, 1, 30);
		Integer numberDaysDue = startDate.daysBetween(dueDate);
        System.debug(numberDaysDue);
        
        //daysInMonth(year, month)
        Integer numberDays = date.daysInMonth(1960, 2);
        System.debug(numberDays);
        
        //format()
        // In American-English locale
		date myDate_5 = date.newInstance(2001, 3, 21);
		String dayString = myDate_5.format();
		system.assertEquals('3/21/2001', dayString);
        
        //isLeapYear(year)
        system.assert(Date.isLeapYear(2004));  
        
        //isSameDay(dateToCompare)
        date myDate_6 = date.today();
        System.debug(myDate_6);
		date dueDate_6 = date.newInstance(2008, 1, 30);
		boolean dueNow = myDate_6.isSameDay(dueDate_6);
        System.debug(dueNow);
        
        //month()
        date myDate_7 = date.newInstance(2004, 11, 21);
		Integer month = myDate_7.month();
		system.assertEquals(11, month);
        
        //monthsBetween(secondDate)
        Date firstDate = Date.newInstance(2006, 12, 2);
		Date secondDate = Date.newInstance(2012, 12, 8);
		Integer monthsBetween = firstDate.monthsBetween(secondDate);
		System.assertEquals(72, monthsBetween); 
        
        //newInstance(year, month, day)
        Date myDate_8 = date.newInstance(1960, 2, 17);
        System.debug(myDate_8);
        
        //parse(stringDate)
        date mydate_9 = date.parse('12/27/2009');
        system.debug(mydate_9);
        
        //toStartOfMonth()
        date myDate_10 = date.newInstance(1987, 12, 17);
		date firstDate_10 = myDate_10.toStartOfMonth();
        system.debug(firstDate_10);
		date expectedDate_10 = date.newInstance(1987, 12, 1);
		system.assertEquals(expectedDate_10, firstDate_10);
        
        //toStartOfWeek()
        Date myDate_11 = Date.today();
		Date weekStart_11 = myDate_11.toStartofWeek();
        System.debug(myDate_11);
        System.debug(weekStart_11);
        
        //valueOf(stringDate)
        string year = '2008';
		string month_12 = '10';
		string day_12 = '5';
		string hour = '12';
		string minute = '20';
		string second = '20';
		string stringDate = year + '-' + month_12
 		+ '-' + day_12 + ' ' + hour + ':' + 
		minute + ':' + second;
		Date myDate_12 = date.valueOf(stringDate);
        system.debug(myDate_12);
        
        //year()
		date myDate_13 = date.newInstance(1988, 12, 17);
		system.assertEquals(1988, myDate_13.year());
    }
    
	/**
	 *   @description    :   Using different types of time methods
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 24/06/2022 - Developer Name - Jay Chand Yadav
     **/
    public static void timeMethods() {
        
        //addDays(additionalDays)
        Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
		Datetime newDateTime = myDateTime.addDays(2);
		Datetime expected = Datetime.newInstance(1960, 2, 19);
		System.assertEquals(expected, newDateTime);
        
        //addHours(additionalHours)
        DateTime myDateTime_2 = DateTime.newInstance(1997, 1, 31, 7, 8, 16);
		DateTime newDateTime_2 = myDateTime_2.addHours(3);
		DateTime expected_2 = DateTime.newInstance(1997, 1, 31, 10, 8, 16);
		System.assertEquals(expected_2, newDateTime_2);
        
        //addMinutes(additionalMinutes)
        DateTime myDateTime_3 = DateTime.newInstance(1999, 2, 11, 8, 6, 16);
		DateTime newDateTime_3 = myDateTime_3.addMinutes(7);
		DateTime expected_3 = DateTime.newInstance(1999, 2, 11, 8, 13, 16);
		System.assertEquals(expected_3, newDateTime_3);
        
        //addMonths(additionalMonths)
        DateTime myDateTime_4 = DateTime.newInstance(2000, 7, 7, 7, 8, 12);
		DateTime newDateTime_4 = myDateTime_4.addMonths(1);
		DateTime expected_4 = DateTime.newInstance(2000, 8, 7, 7, 8, 12);
		System.assertEquals(expected_4, newDateTime_4);
        
        //addSeconds(additionalSeconds)
        DateTime myDateTime_5 = DateTime.newInstance(2001, 7, 19, 10, 7, 12);
		DateTime newDateTime_5 = myDateTime_5.addSeconds(4);
		DateTime expected_5 = DateTime.newInstance(2001, 7, 19, 10, 7, 16);
		System.assertEquals(expected_5, newDateTime_5);
        
        //dayOfYear()
        Datetime myDate = Datetime.newInstance(2008, 2, 5, 8, 30, 12);
		system.assertEquals(myDate.dayOfYear(), 36);
        
        //format(dateFormatString)
        Datetime myDT = DateTime.newInstance(2022, 5, 4, 19, 37, 55);
		String myDate_6 = myDT.format('yyyy-MM-dd h:mm a');
		String expected_6 = '2022-05-04 7:37 PM';
		System.assertEquals(expected_6, myDate_6);
    }
    
	/**
     *   @description    :   Using different types of string methods
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 24/06/2022 - Developer Name - Jay Chand Yadav
     **/
    public static void stringTypes() {
        
        //abbreviate(maxWidth)
        String s = 'Hello Maximillian';
		String s2 = s.abbreviate(8);
		System.assertEquals('Hello...', s2);
		System.assertEquals(8, s2.length());
        
        //abbreviate(maxWidth, offset)
        String s3 = 'Hello Maximillian';
		// Start at M
		String s4 = s3.abbreviate(9,6);
		System.assertEquals('...Max...', s4);
		System.assertEquals(9, s4.length());
        
        //capitalize()
		//Returns the current String with the first letter changed to title case.
		String s5 = 'hello maximillian';
		String s6 = s5.capitalize();
		System.assertEquals('Hello maximillian', s6);
        
        /*center(size)
		Returns a version of the current String of the specified size padded with spaces on the left and right,
   		so that it appears in the center. If the specified size is smaller than the current String size, 
   	 	the entire String is returned without added spaces.*/
        String s7 = 'hello';
		String s8 = s7.center(9);
		System.assertEquals(
 	 	 '  hello  ',
   		s8);
        
        //charAt(index)
            String str = 'Ω is Omega.';
		System.assertEquals(937, str.charAt(0));
        
        //compareTo(secondString)
        //Note that this method returns 0 whenever the equals method returns true.
        String myString1 = 'abcde';
		String myString2 = 'abcd';
		Integer result = 
  	 	myString1.compareTo(myString2);
		System.assertEquals(result, 1);
        
        //contains(substring)
        String myString3 = 'abcde';
		String myString4 = 'abcd';
		Boolean result1 = 
   		myString3.contains(myString4);
		System.assertEquals(result1, true);
        
        //containsWhitespace()
        String s9 = 'Hello Jane';
		System.assert(s9.containsWhitespace()); //true
		s9 = 'HelloJane ';
		System.assert(s9.containsWhitespace()); //true
		s9 = ' HelloJane';
		System.assert(s9.containsWhitespace()); //true
		s9 = 'HelloJane';
		System.assert(!s9.containsWhitespace()); //false
        
        //countMatches(substring)
        String s10 = 'Hello Jane';
		System.assertEquals(1, s10.countMatches('Hello'));
		s10 = 'Hello Hello';
		System.assertEquals(2, s10.countMatches('Hello'));
		s10 = 'Hello hello';
		System.assertEquals(1, s10.countMatches('Hello'));
        
        //deleteWhitespace()
        String s11 = ' Hello Jane ';
		String s12 = 'HelloJane';
		System.assertEquals(s12, s11.deleteWhitespace());
        
        //equals(secondString)
        String myString11 = 'abcde';
		String myString12 = 'abcd';
		Boolean result3 = myString11.equals(myString12);
		System.assertEquals(result3, false);
    }
   
	/**
      *   @description    :   List, how to define and add , retrieve and remove elements
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 24/06/2022 - Developer Name - Jay Chand Yadav
     **/
    public static void listType() {

        List<Integer> myList = new List<Integer>(); // Define a new list
		myList.add(47);                                      
		Integer i = myList.get(0);                   // Retrieves the element at index 0
		myList.set(0, 1);                           // Adds the integer 1 to the list at index 0
		myList.clear();                             // Removes all elements from the list
        
        String[] colors = new List<String>();
        colors.add('hi');
        colors.add('hey');
        colors.add('hello');
        system.debug(colors.get(2));
        
		List<String> colors_1 = new String[1];
        colors_1.add('Hello');
        system.debug(colors_1.get(1));
        
        List<Integer> ints = new Integer[6];
        ints[0] = 1;
        ints[1] = 2;
        ints[2] = 3;
        ints[3] = 4;
        ints[4] = 5;
        ints[5] = 6;
        system.debug(ints[5]);
    }
    
	/**
      *   @description    :   List Sorting
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 24/06/2022 - Developer Name - Jay Chand Yadav
     **/
    public static void listSorting() {

        List<String> colors = new List<String>{'Yellow','Red','Green'};
  		colors.sort();
		System.assertEquals('Green', colors.get(0));
		System.assertEquals('Red', colors.get(1));
		System.assertEquals('Yellow', colors.get(2));
        
        //Default Sort Order for SelectOption
        List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('A','United States'));
		options.add(new SelectOption('C','Canada'));
		options.add(new SelectOption('A','Mexico'));
		System.debug('Before sorting: ' + options);
		options.sort();
		System.debug('After sorting: ' + options);
    }
    
	/**
     *   @description    :   Set in apex
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 24/06/2022 - Developer Name - Jay Chand Yadav
     **/
    public static void setType() {
        
        Set<String> set1 = new Set<String>{'New York', 'Paris'};
            
        // Define a new set
		Set<Integer> mySet = new Set<Integer>();
		// Add two elements to the set
		mySet.add(1);
		mySet.add(3);
		// Assert that the set contains the integer value we added
		System.assert(mySet.contains(1)); 
		// Remove the integer value from the set
		mySet.remove(1);
        
        // Define a new set that contains the
		// elements of the set created in the previous example
		Set<Integer> mySet2 = new Set<Integer>(mySet);
		// Assert that the set size equals 1
		// Note: The set from the previous example contains only one value
		System.assert(mySet2.size() == 1);
        
        List<Integer> ls = new List<Integer>();
		ls.add(1);
		ls.add(2);
		// Create a set based on a list
		Set<Integer> s1 = new Set<Integer>(ls);
		// Elements are copied from the list to this set
		System.debug(s1);// DEBUG|{1, 2}
    }
    
	/**
     *   @description    :   Map in apex
     *
     *   @return         :   void
     *
     *   @revision Log   :   V1.1 - Created  - 24/06/2022 - Developer Name - Jay Chand Yadav
     **/
    public static void mapType() {
        
        Map<String, String> MyStrings = new Map<String, String>{'a' => 'b', 'c' => 'd'.toUpperCase()};
            
        Map<Integer, String> m = new Map<Integer, String>(); // Define a new map
		m.put(1, 'First entry');                  // Insert a new key-value pair in the map
		m.put(2, 'Second entry');                  // Insert a new key-value pair in the map
		System.assert(m.containsKey(1));  // Assert that the map contains a key
		String value = m.get(2);               // Retrieve a value, given a particular key
		System.assertEquals('Second entry', value);
		Set<Integer> s = m.keySet();       // Return a set that contains all of the keys in the map
    }
}