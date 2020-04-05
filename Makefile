default:	build

PROJECT=project_name
SERVER=trac.local
HOSTPORT=8080
REALM=trac-$(PROJECT)
ADMIN=admin
PASSWORD=PLEASE_CHANGE_BEFORE_INIT

DATADIR=$(CURDIR)/data
CONTAINER=trac-$(PROJECT)

build:
	docker build container -t trac-on-docker

shell:
	docker exec -it $(CONTAINER) /bin/ash

run:
	docker run -d -p $(HOSTPORT):8080 -v $(DATADIR):/trac --name $(CONTAINER) trac-on-docker

init:
	mkdir $(DATADIR)
	docker run -d -p $(HOSTPORT):8080 \
		-e SERVER_NAME=$(SERVER) \
		-e REALM_NAME=$(REALM) \
		-e ADMIN_NAME=$(ADMIN) \
		-e ADMIN_PASSWD=$(PASSWORD) \
		-e PROJECT_NAME=$(PROJECT) \
		-v $(DATADIR):/trac \
		--name $(CONTAINER) trac-on-docker init

