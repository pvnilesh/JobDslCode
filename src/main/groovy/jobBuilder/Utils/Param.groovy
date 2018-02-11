package jobBuilder.Utils

import java.util.ArrayList

public class Param {
	static void paramConfig(context, ArrayList<String[]> list){
		for (item in list) {
		    context.with {
			    requiredString(item)
			}
		}

	}
	
    static String requiredString(String[] myparam) {
            return "stringParam $myparam[0], $myparam[1], $myparam[2]"
    }

}