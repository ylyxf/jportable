#!/bin/bash
export JAVA_HOME=/usr/lib/jvm/java-1.8.0

export platform=windows

export arch=i386

export extlib=win32

export ming32prefix=i686

cd avian
#make platform=${platform} arch=${arch}

rm -rf app
cp -r ../app app
cd app

cp -r /root/share/* ./

${ming32prefix}-w64-mingw32-windres icon.rc -O coff -o icon.res

${ming32prefix}-w64-mingw32-ar x ../build/${platform}-${arch}/libavian.a
../build/${platform}-${arch}/binaryToObject/binaryToObject boot.jar boot-jar.o _binary_boot_jar_start _binary_boot_jar_end ${platform} ${arch}

${ming32prefix}-w64-mingw32-g++ -fno-exceptions -fno-rtti -I"$JAVA_HOME/include" -I"../../${extlib}/include"   -D_JNI_IMPLEMENTATION_ -c embedded-jar-main.cpp -o main.o

${ming32prefix}-w64-mingw32-dlltool -z app.def *.o
${ming32prefix}-w64-mingw32-dlltool -d app.def -e app.exp
${ming32prefix}-w64-mingw32-gcc app.exp *.o -L../../${extlib}/lib -lmingwthrd -lm -lz -lws2_32   -liphlpapi -mwindows -mconsole  -o app.exe icon.res
${ming32prefix}-w64-mingw32-strip --strip-all app.exe
cp -f app.exe /root/share/app_${arch}.exe