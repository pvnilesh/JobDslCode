package jobBuilder.Utils

import java.util.ArrayList

public class Param {
	static void paramConfig(context, ArrayList<String[]> list){
		def abc = "a"
		def qwe = "b"
		def asd = "c"
		def i = 1
		for(item in list){
		   	context.with {
				StringParam(abc+i,qwe+i,asd+i)
			}
			i++
		} 
	}
}