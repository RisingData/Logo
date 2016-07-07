copy Logo.java logo.class
del *.class
javac -Xlint:unchecked *.java
jar -cmf manifest.mf ..\assembler.jar *.class
del *.class


