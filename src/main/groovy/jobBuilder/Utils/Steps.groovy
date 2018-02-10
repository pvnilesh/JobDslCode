package jobBuilder.Utils

class Steps {

    static void gradle(context, String gradleTasks,String gradleSwitches = "") {
        context.with {
            gradle {
                useWrapper true
                tasks gradleTasks
                switches gradleSwitches.stripIndent().trim()
            }
        }
    }
	
	static void shell(context, String fileName) {
        context.with {
            shell("./\$$fileName")
        }
    }
}
