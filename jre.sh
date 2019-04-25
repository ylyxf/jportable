#!/bin/bash
export JAVA_HOME=/usr/lib/jvm/java-1.8.0
 

cd avian
make platform=windows arch=i386
rm -rf /root/share/jre_win32
mkdir -p /root/share/jre_win32/bin/
mkdir -p /root/share/jre_win32/lib/

cp ./build/windows-i386/avian.exe  /root/share/jre_win32/bin/java.exe
cp ./build/windows-i386/classpath.jar /root/share/jre_win32/lib/rt.jar

make platform=windows arch=x86_64
rm -rf /root/share/jre_win64

mkdir -p /root/share/jre_win64/bin/
mkdir -p /root/share/jre_win64/lib/

cp ./build/windows-x86_64/avian.exe  /root/share/jre_win64/bin/java.exe
cp ./build/windows-x86_64/classpath.jar /root/share/jre_win64/lib/rt.jar
 