repo=quackup
name=db
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
		-v /data/quackup/db:/data/db \
		-v /data/quackup/configdb:/data/configdb \
		-t ${repo}/${name}:${version}

.PHONY:kill
kill:
	docker rm $$( \
	docker kill $$( \
	docker ps -aq \
	--filter="name=${repo}-${name}-dev" ))
