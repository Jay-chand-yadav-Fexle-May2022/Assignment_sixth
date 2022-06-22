public class Patternprinting {
    public static void leftTrianglePascals() {
        String str = '';
        Integer n = 5;
        for(Integer i=1;i<=n;i++) {

            for(Integer j=1;j<=n-i;j++) {
                str += '_';
            }

            for(Integer k=1;k<=i;k++) {
                str += '*';
            }
            
            system.debug(str);
            str = '';
        }
		str = '';
        Integer space = 1;
        for(Integer i=n-1;i>0;i--) {

            for(Integer j=1;j<=space;j++) {
                str += '_';
            }

            for(Integer k=1;k<=i;k++) {
                str += '*';
            }
            
            system.debug(str);
            space++;
            str = '';
        }
    }

    public static void downTriangle() {
        Integer length = 5;
        Integer space = 0;
        Integer midspace = length*2-5;
        String str = '';
        for(Integer i=0;i<length;i++) {

            for(Integer j=0;j<space;j++) {
                str += '_';
            }

            if(i==0) {
                for(Integer k=0;k<length*2-1;k++) {
                	str += '*';
            	}
            }
            
            else if(i!=length-1) {
                str += '*';
                for(Integer l=0;l<midspace;l++) {
                    str += '_';
                }
                str += '*';
                midspace -= 2;
            }
            
            else {
                str += '*';
            }
            
            system.debug(str);
            space++;
            str = '';
        }
    }
}
