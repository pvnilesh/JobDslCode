package jobBuilder.Utils

public class Scm {
    static void git(context) {
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