package jobBuilder.Utils

public class Steps {
	static void myShell(context, ArrayList<String[]> list) {
		for(item in list){
		   	context.with {
				shell('./$' + item[0] + ' `cat $' + item[1] + '`')
			}
		}
    }
}
