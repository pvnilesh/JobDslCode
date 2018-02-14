package jobBuilder.Utils

public class Scm {
    static void myscm(context, String scmType,ArrayList<String> list) {
		if(scmType.equalsIgnoreCase("GIT")){
		    context.with {
				git {
					remote {
						url list[0]
						branch list[1]
					}
				}
			}
		}
    }
}
