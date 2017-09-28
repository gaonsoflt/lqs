# 축산방역시스템
# Livestock quarantine system

# Docker for service(was)
- ex) $ docker run -it --name lqs-was --link db -e BRANCH=dev -p 8080:8080 -d warluck/lqs:was1.0 
- name: container name
- link: db container name
- e BRANCH: git branch name(if not inclued, use master)
- p: port mapping

# Docker for db(postgres)
1. install program
 - apt-get install vi
 - apt-get install git
 - apt-get install wget
2. update file
 - docker-entrypoint.sh > gaonsoflt/lqs/docker/postgres/docker-entrypoint.sh
3 commit docker image(create image by changed_contatiner)
 - docker commit {changed_container} {tag}

