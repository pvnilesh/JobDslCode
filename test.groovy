String sourceFile = readFileFromWorkspace("utilities/MyUtilities.groovy")
Class MyUtilities = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile)
def myJob = job('example')
MyUtilities.addMyFeature(myJob)