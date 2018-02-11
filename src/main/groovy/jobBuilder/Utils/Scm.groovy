package jobBuilder.Utils

public class Scm {
    static void myscm(context, String scmType) {
		if(scmType.equalsIgnoreCase("GIT")){
		    context.with {
				git {
					remote {
						url '$RepositoryName'
						branch '*/$BranchName'
					}
				}
			}
		}
    }
}