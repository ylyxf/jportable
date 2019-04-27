# basic image
FROM centos:7.6.1810

MAINTAINER ylyxf "304189773@qq.com" 

WORKDIR /root
 
ADD src.tar.gz /root/

RUN	mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup  && \ 
	curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo  && \ 
	curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo  && \ 
#build tools
	yum install make -y  && \ 
	yum install gcc -y  && \ 
	yum install gcc-c++ -y  && \  
	yum install zlib-devel -y  && \ 
#java
	yum install java-1.8.0-openjdk -y  && \
	yum install java-1.8.0-openjdk-devel -y	 && \
#mingw64
	yum install mingw64-gcc -y  && \ 
	yum install mingw64-gcc-c++ -y  && \ 
	yum install mingw64-zlib -y  && \ 
	yum install mingw64-zlib-static  -y  && \ 
	yum install mingw64-winpthreads  -y  && \ 
	yum install mingw64-winpthreads-static  -y && \ 
#mingw32	
	yum install mingw32-gcc -y  && \ 
	yum install mingw32-gcc-c++ -y  && \ 
	yum install mingw32-zlib -y  && \ 
	yum install mingw32-zlib-static  -y  && \  
	yum install mingw32-winpthreads  -y  && \ 
	yum install mingw32-winpthreads-static  -y && \ 
	cd avian && \ 
	export JAVA_HOME=/usr/lib/jvm/java-1.8.0 && \ 
	make platform=windows arch=i386 && \ 
	make platform=windows arch=x86_64
	
COPY win32.sh /root/
COPY win64.sh /root/
COPY jre.sh /root/	

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0


ENTRYPOINT ["/bin/bash"]
 