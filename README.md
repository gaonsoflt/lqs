축산방역시스템(Livestock quarantine system)
=======================================

## Docker for db(postgres)
- ex) $ docker run -it --name lqs-db -e POSTGRES_DB=lqs -e POSTGRES_USER=lqs -e POSTGRES_PASSWORD=lqs123qwe -p 5432:5432 -d warluck/lqs:db-postgres1.0
- name: container name
- link: db container name
- e POSTGRES_DB: db name
- e POSTGRES_USER: db username
- e POSTGRES_PASSWORD: db user password
- p: port mapping

## Docker for service(was)
- ex) $ docker run -it --name lqs-was --link db -e BRANCH=dev -p 8080:8080 -d warluck/lqs:was1.0 
- name: container name
- link: db container name
- e BRANCH: git branch name(if not inclued, use master)
- p: port mapping
