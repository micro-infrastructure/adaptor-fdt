BootStrap: docker
From: mhart/alpine-node:10

%setup
   mkdir ${SINGULARITY_ROOTFS}/app/

%files
	fdt.jar /app/
	copy /app/
	server /app/
	verify /app/

%post
	apk  update && apk add openjdk8 bash
    
%runscript
    cd /app/
    exec bash "$@"
