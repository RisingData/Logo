rm -f *.class
cp ../startup.logo startup.logo
javac -Xlint:unchecked *.java
jar -cmf manifest.mf ../tatext.jar *.class *.java startup.logo makepcjar.bat makepcjar.sh manifest.mf images
rm *.class

