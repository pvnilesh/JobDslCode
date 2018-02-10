package jobBuilder.Utils

class Scm {
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