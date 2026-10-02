@REM Maven Wrapper Script
@SET MAVEN_WRAPPER_JAR=.mvn/wrapper/maven-wrapper.jar
@IF EXIST "%MAVEN_WRAPPER_JAR%" (
    @java -jar "%MAVEN_WRAPPER_JAR%" %*
) ELSE (
    @echo ERROR: Maven Wrapper JAR not found.
    @exit /B 1
)