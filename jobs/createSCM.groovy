#!/bin/bash                                                                                                                                                                 
//usr/bin/env groovy  -cp src.main.groovy "$0" $@; exit $?


import jobBuilder.Utils.Scm
import jobBuilder.Utils.Steps
import static jobBuilder.Utils.Param.requiredString
import java.util.ArrayList
import jobBuilder.Utils.MyParameter

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

job("built-with-utils") {
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
