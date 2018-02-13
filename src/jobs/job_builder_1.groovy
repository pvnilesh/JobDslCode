import java.util.ArrayList

String sourceFile1 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Scm.groovy")
Class Scm = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile1)

String sourceFile2 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Steps.groovy")
Class Steps = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile2)

String sourceFile3 = readFileFromWorkspace("src/main/groovy/jobBuilder/Utils/Param.groovy")
Class Param = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile3)

def myStepList = new ArrayList<String[]>()

if(DoCompile.equalsIgnoreCase("TRUE")){
	def myParam1 = new String[2]
	
	myParam1[0] = "CompileScript"
	myParam1[1] = "CompileScriptParamFile"
	myStepList.add(myParam1)
}

if(DoPackage.equalsIgnoreCase("TRUE")){
	def myParam2 = new String[2]
	
	myParam2[0] = "PackageScript"
	myParam2[1] = "PackageScriptParamFile"
	myStepList.add(myParam2)
}

job("${FolderName}/${AppName}") {
    logRotator(2, 10, -1, -1)
    scm {
        Scm.myscm(delegate,ScmType)
    }
    parameters {
        stringParam('NexusServer','35.201.168.32:8081','')
		stringParam('NexusRepository','LaserRaw','')
		stringParam('NexusUsername','admin','')
		stringParam('NexusPassword','admin123','')
    }
    steps {
		Steps.myShell(delegate,myStepList)
    }
	wrappers {
    envInjectBuildWrapper {
      info {
        propertiesFilePath(PropertiesFile)
        propertiesContent("")
        scriptFilePath("")
        scriptContent("")
        loadFilesFromMaster(false)
        secureGroovyScript {
          script("")
          sandbox(false)
        }  
      }  
    }  
}	
}
