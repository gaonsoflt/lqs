축산방역시스템(Livestock quarantine system)
=======================================
## DB Dump
- postgresql
> $ pg_dump -U lqs lqs > db.pgsql

## Docker for db(postgres)
> $ docker run -it --name lqs-db -e POSTGRES_DB=lqs -e POSTGRES_USER=lqs -e POSTGRES_PASSWORD=lqs123qwe --volume=~/docker/lqs/db:/var/lib/postgresql/data -p 5432:5432 -d warluck/lqs:db-postgres1.0
- name: container name
- e POSTGRES_DB: db name
- e POSTGRES_USER: db username
- e POSTGRES_PASSWORD: db user password
- volume={local_path}:{container_path}: save data to local(optional)
- p: port mapping

## Docker for service(app)
> $ docker run -it --name lqs-was --link db -e BRANCH=dev -p 8080:8080 -d warluck/lqs:app1.0 
- name: container name(optional)
- link: db container name
- e BRANCH: git branch name(if not inclued, use master)(optional)
- p: port mapping

## Docker-compose
- ex) $ docker up -d
