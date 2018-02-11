package jobBuilder.Utils

import java.util.ArrayList

public class Param {
	static String paramConfig(ArrayList<String[]> list){
		def str = ""
		def clos = {
		   for (item in list) {
		      str += requiredString(item) + "\n"
		   }
		}
		
		clos()
		return str
	}
	
    static String requiredString(String[] myparam) {
            return "stringParam $myparam[0], $myparam[1], $myparam[2]"
    }

}