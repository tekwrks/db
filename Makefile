projectID=tekwrks
repo=quackup
name=database
version=1.0.0

.PHONY:build
build:
	docker image build \
		-t ${repo}/${name}:${version} .

.PHONY:run
run:
	docker container run \
		--name ${repo}-${name}-dev \
		--env-file .env \
		-p 27017:27017 \
		--mount type=bind,source=$$(pwd)/DATA/db,target=/data/db \
		--mount type=bind,source=$$(pwd)/DATA/configdb,target=/data/configdb \
		-t ${repo}/${name}:${version}

.PHONY:kill
kill:
	docker rm $$( \
	docker kill $$( \
	docker ps -aq \
	--filter="name=${repo}-${name}-dev" ))

.PHONY: push
push:
	set -ex;
	docker tag \
		${repo}/${name}:${version} \
		gcr.io/${projectID}/${name}:${version}
	docker push \
		gcr.io/${projectID}/${name}:${version}

