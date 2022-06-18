all: build run

build:
	docker build -t archi .

run:
	docker run -it archi

prune:
	docker system prune -a --volumes
