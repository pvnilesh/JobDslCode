package jobBuilder.Utils

import java.util.ArrayList

public class Param {
	static void paramConfig(context, ArrayList<String[]> list){
		for(item in list){
		   	context.with {
				StringParam(item[0],item[1],item[2])
			}
		} 
	}
}