package jobBuilder.Utils

public class Logrotator {

    static void logrotate(context, String repository,String gitBranch) {
        context.with {
            git {
                remote {
                    url repository
                    branch gitBranch
                }
            }
        }
    }
}