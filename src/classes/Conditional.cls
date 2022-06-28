/**
*  Description     :  Conditional if / else - if / else
*
*  Created By      :  Jay Chand Yadav
*
*  Created Date    :  06/28/2022
*
*  Revision Logs   :    V1.0 - Created - jay Chand Yadav
**/
public with sharing class Conditional {
    
    public Conditional() {

        Integer x = 0, sign;

        if (x <= 0) {
            if (x == 0) {
                sign = 0; 
                System.debug(sign);
            } else  {
                 sign = -1;
                 System.debug(sign);
            }
        }

        // Above code in one line both are same
        if (x <= 0) if (x == 0) sign = 0; else sign = -1;

        Integer place = 3;
        String medal_color;
        if (place == 1) {
            medal_color = 'gold';
        } else if (place == 2) {
            medal_color = 'silver';
        } else if (place == 3) {
            medal_color = 'bronze';
        } else {
            medal_color = null;
        }
        System.debug(medal_color);

        String place_1 = 'delhi';
        String place_2 = 'chennai';
        if(place_1.equals(place_2)) {
            System.debug('Both are same');
        } else {
            System.debug('different');
        }

    }
}