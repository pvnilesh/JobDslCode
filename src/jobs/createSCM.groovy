import java.util.ArrayList

String sourceFile1 = readFileFromWorkspace("${workspace}/src/main/groovy/jobBuilder/Utils/Scm.groovy")
Class Scm = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile1)
String sourceFile2 = readFileFromWorkspace("${workspace}/src/main/groovy/jobBuilder/Utils/Steps.groovy")
Class Steps = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile2)
String sourceFile3 = readFileFromWorkspace("${workspace}/src/main/groovy/jobBuilder/Utils/MyParameter.groovy")
Class MyParameter = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile3)

def myList = new ArrayList()
def param1 = new MyParameter()
def param2 = new MyParameter()
def param3 = new MyParameter()
def param4 = new MyParameter()

param1.name = "RepositoryName"
param1.defaultValue = ""
param1.description = ""

param2.name = "BranchName"
param2.defaultValue = ""
param2.description = "master"

param3.name = "CompileScript"
param3.defaultValue = "compile.sh"
param3.description = ""

param4.name = "PackageScript"
param4.defaultValue = "package.sh"
param4.description = ""

myList.add(param1)
myList.add(param2)
myList.add(param3)
myList.add(param4)

job("Test/built-with-utils") {
    logRotator(2, 10, -1, -1)
    scm {
        Scm.git(delegate)
    }
    parameters {
        paramConfig(myList)
    }
    steps {
		Steps.shell(delegate, 'CompileScript')
        Steps.shell(delegate, 'PackageScript')
    }
}
