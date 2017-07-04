include:
  - base-system

docker:
  pkg.latest: []
  service.running:
    - enable: True
    - require:
      - pkg: docker

add-user-to-docker-group:
  user.present:
    - name: user
    - groups:
      - docker

docker-master:
  cmd.run:
    - name: "docker run -d --hostname saltmaster --name saltmaster -v `pwd`/srv/salt:/srv/salt -p 8000:8000 -ti mbologna/saltstack-master"
    - runas: user
    - cwd: /home/user
    - unless: docker ps | grep saltmaster
    - require:
      - service: docker
      - sls: base-system
      - user: add-user-to-docker-group

docker-minions:
  cmd.run:
    - name: "for i in {1..2}; do docker run -d --hostname saltminion$i --name saltminion$i --link saltmaster:salt mbologna/saltstack-minion ; done"
    - runas: user
    - cwd: /home/user
    - unless: docker ps | grep saltminion1
    - require:
      - cmd: docker-master
