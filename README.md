# 축산방역시스템
- Livestock quarantine system

# Docker for postgres
1. install program
 - apt-get install vi
 - apt-get install git
 - apt-get install wget
2. update file
 - docker-entrypoint.sh > gaonsoflt/lqs/docker/postgres/docker-entrypoint.sh
3 commit docker image(create image by changed_contatiner)
 - docker commit {changed_container} {tag}
