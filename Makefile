
info:
	[ -d /docker-data ] || sudo mkdir /docker-data
	humble utils fs-info

status:
	humble utils fs-status

mount-disk:
	humble stop neo4j
	humble rm -f neo4j
	humble utils fs-mount

unmount-disk:
	humble stop neo4j
	humble rm -f neo4j
	humble utils fs-unmount

resize-disk:
	sudo xfs_growfs -d /docker-data

stop-neo4j:
	humble stop neo4j
	humble rm -f neo4j

run-neo4j:
	humble stop neo4j
	humble rm -f neo4j
	humble up -d neo4j
	humble logs -f
