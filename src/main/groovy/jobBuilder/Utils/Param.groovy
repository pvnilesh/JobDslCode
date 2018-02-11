package jobBuilder.Utils

import java.util.ArrayList
import jobBuilder.Utils.MyParameter

public class Param {
	static String paramConfig(ArrayList<MyParameter> list){
		def str = ""
		def clos = {
		   for (item in list) {
		      str += requiredString(item) + "\n"
		   }
		}
		
		clos()
		return str
	}
	
    static String requiredString(MyParameter myparam) {
            return "stringParam $myparam.name, $myparam.defaultValue, $myparam.description"
    }

}