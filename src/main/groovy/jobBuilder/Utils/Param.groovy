package jobBuilder.Utils

import java.util.ArrayList

public class Param {
	static void paramConfig(context, ArrayList<String[]> list){
		def myParam = new String[3]

		myParam[0] = "RepositoryName"
		myParam[1] = ""
		myParam[2] = ""
		context.with {
		    stringParam(requiredString(myParam))
		}

	}
	
    static String requiredString(String[] mypara) {
            return "mypara[0], mypara[1], mypara[2]"
    }

}