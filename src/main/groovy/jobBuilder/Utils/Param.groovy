package jobBuilder.Utils

import java.util.ArrayList

public class Param {
	static void paramConfig(context, ArrayList<String[]> list){
		def str = ""
		for(item in list){
		   $str += "stringParam($item[0],$item[1],$item[2])\n" 
		}
		context.with {
		    $str 
		} 
	}
}