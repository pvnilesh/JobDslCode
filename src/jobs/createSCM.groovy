import java.util.ArrayList

String sourceFile1 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Scm.groovy")
Class Scm = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile1)

String sourceFile2 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Steps.groovy")
Class Steps = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile2)

String sourceFile3 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Param.groovy")
Class Param = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile3)

def myList = new ArrayList<String[]>()
def myParam1 = new String[3]
def myParam2 = new String[3]
def myParam3 = new String[3]
def myParam4 = new String[3]

myParam1[0] = "RepositoryName"
myParam1[1] = ""
myParam1[2] = ""
myList.add(myParam1)

myParam2[0] = "BranchName"
myParam2[1] = "master"
myParam2[2] = ""
myList.add(myParam2)

myParam3[0] = "CompileScript"
myParam3[1] = "compile.sh"
myParam3[2] = ""
myList.add(myParam3)

myParam4[0] = "PackageScript"
myParam4[1] = "package.sh"
myParam4[2] = ""
myList.add(myParam4)

job("Test/built-with-utils") {
    logRotator(2, 10, -1, -1)
    scm {
        Scm.git(delegate)
    }
    parameters {
        Param.paramConfig(delegate,myList)
    }
    steps {
		Steps.shell(delegate, 'CompileScript')
        Steps.shell(delegate, 'PackageScript')
    }
}
