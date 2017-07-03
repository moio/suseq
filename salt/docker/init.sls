include:
  - base-system

docker:
  pkg.latest: []
  service.running:
    - enable: True
    - require:
      - pkg: docker

docker-master:
  cmd.run:
    - name: "docker run -d --hostname saltmaster --name saltmaster -v `pwd`/srv/salt:/srv/salt -p 8000:8000 -ti mbologna/saltstack-master"
    - runas: user
    - cwd: /home/user
    - unless: docker ps | grep saltmaster
    - require:
      - service: docker
      - sls: base-system

docker-minions:
  cmd.run:
    - name: "for i in {1..2}; do docker run -d --hostname saltminion$i --name saltminion$i --link saltmaster:salt mbologna/saltstack-minion ; done"
    - runas: user
    - cwd: /home/user
    - unless: docker ps | grep saltminion1
    - require:
      - cmd: docker-master

user:
  user.present:
    - fullname: Candidate for SUSE
    - shell: /bin/bash
    - home: /home/user
    - password: interview
    - groups:
      - docker
    - require:
      - pkg: docker
