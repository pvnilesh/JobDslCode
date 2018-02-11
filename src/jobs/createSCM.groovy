import java.util.ArrayList

String sourceFile1 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Scm.groovy")
Class Scm = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile1)

String sourceFile2 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Steps.groovy")
Class Steps = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile2)

String sourceFile3 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Param.groovy")
Class Param = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile3)

def myList = new ArrayList<String[]>()
def myParam = new String[3]

myParam[0] = "RepositoryName"
myParam[1] = ""
myParam[2] = ""
myList.add(myParam)

myParam[0] = "BranchName"
myParam[1] = "master"
myParam[2] = "
myList.add(myParam)

myParam[0] = "CompileScript""
myParam[1] = "compile.sh"
myParam[2] = "
myList.add(myParam)

myParam[0] = "PackageScript"
myParam[1] = "package.sh"
myParam[2] = "
myList.add(myParam)

job("Test/built-with-utils") {
    logRotator(2, 10, -1, -1)
    scm {
        Scm.git(delegate)
    }
    parameters {
        Param.paramConfig(myList)
    }
    steps {
		Steps.shell(delegate, 'CompileScript')
        Steps.shell(delegate, 'PackageScript')
    }
}
