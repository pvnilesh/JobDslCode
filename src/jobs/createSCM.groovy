import java.util.ArrayList

String sourceFile1 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Scm.groovy")
Class Scm = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile1)

String sourceFile2 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Steps.groovy")
Class Steps = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile2)

String sourceFile3 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Param.groovy")
Class Param = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile3)

def myParamList = new ArrayList<String[]>()
def myStepList = new ArrayList<String>()

if(ScmType.equalsIgnoreCase("GIT")) { 
	def myParam1 = new String[3]
	def myParam2 = new String[3]

	myParam1[0] = "RepositoryName"
	myParam1[1] = ""
	myParam1[2] = ""
	myParamList.add(myParam1)

	myParam2[0] = "BranchName"
	myParam2[1] = "master"
	myParam2[2] = ""
	myParamList.add(myParam2)
}

if(doCompile.equalsIgnoreCase("TRUE")){
	def myParam3 = new String[3]
	
	myParam3[0] = "CompileScript"
	myParam3[1] = "compile.sh"
	myParam3[2] = ""
	myParamList.add(myParam3)
	
	myStepList.add('CompileScript')
}

if(doPackage.equalsIgnoreCase("TRUE")){
	def myParam4 = new String[3]

	myParam4[0] = "PackageScript"
	myParam4[1] = "package.sh"
	myParam4[2] = ""
	myParamList.add(myParam4)
	
	myStepList.add('PackageScript')
}

job("Test/built-with-utils") {
    logRotator(2, 10, -1, -1)
    scm {
        Scm.myscm(delegate,ScmType)
    }
    parameters {
        Param.paramConfig(delegate,myParamList)
    }
    steps {
		Steps.myShell(delegate,myStepList)
    }
}
