public class Patternprinting {
    public static void leftTrianglePascals() {
        Integer n = 5;
        Integer space = n*2-2;
        for(Integer i=1;i<=n;i++) {

            for(Integer j=1;j<=space;j++) {
                system.debug(' ');
            }

            for(Integer k=1;k<=i;k++) {
                system.debug('* ');
            }
            
            system.debug('\n');
            space = space - 2;
        }

        space = space + 4;
        for(Integer i=n-1;i>0;i--) {

            for(Integer j=1;j<=space;j++) {
                system.debug(' ');
            }

            for(Integer k=1;k<=i;k++) {
                system.debug('* ');
            }
            
            system.debug('\n');
            space = space + 2;
        }
    }

    public static void downTriangle() {
        Integer length = 5;
        Integer space = 0;
        Integer midspace = length*2-5;
        for(Integer i=0;i<length;i++) {

            for(Integer j=0;j<space;j++) {
                system.debug(' ');
            }

            if(i==0) {
                for(Integer k=0;k<length*2-1;k++) {
                system.debug('*');
            }
            }
            
            else if(i!=length-1) {
                system.debug('*');
                for(Integer l=0;l<midspace;l++) {
                    system.debug(' ');
                }
                system.debug('*');
                midspace -= 2;
            }
            
            else {
                system.debug('*');
            }
            
            system.debug('\n');
            space++;
        }
    }
}