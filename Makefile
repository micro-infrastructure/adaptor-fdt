.PHONY: build

AUTHOR="recap"
IMAGE_NAME="process-fdt"
VERSION="v0.1"
FNAME="${AUTHOR}/${IMAGE_NAME}:${VERSION}"
SNAME="${AUTHOR}.${IMAGE_NAME}:${VERSION}"


setup:
	mkdir -p ./build

build: setup docker charliecloud singularity
	echo "build"

docker:
	docker build -t ${FNAME} .

charliecloud: docker
	mkdir -p ./build
	ch-builder2tar recap/process-fdt:v0.1 ./build/

singularity:
	mkdir -p ./build
	rm -f ./build/${SNAME}.simg
	sudo singularity build ./build/${SNAME}.simg Singularity

push: docker
	docker push recap/process-fdt

run-d: docker
	docker run -it  recap/process-fdt:v0.1 sh

run-s: singularity
	singularity run -W /app/ ./build/${SNAME}.simg

run-c: charliecloud
	mkdir -p ./build/.charliecloud
	ch-tar2dir ./build/${SNAME}.tar.gz ./build/.charliecloud/
	ch-run -c /app/ ./build/.charliecloud/${SNAME} -- sh



