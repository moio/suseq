include:
  - base-system

docker:
  pkg.latest: []
  service.running:
    - enable: True
    - require:
      - pkg: docker  
      
salt-docker-demo-repo:
  git.latest:
    - name: https://github.com/mbologna/salt-docker-demo
    - rev: master
    - target: /home/user/salt-docker-demo
    - user: user
    - require:
      - sls: base-system

docker-master:
  cmd.run:
    - name: "docker run -d --hostname saltmaster --name saltmaster -v `pwd`/srv/salt:/srv/salt -p 8000:8000 -ti mbologna/saltstack-master"  
    - user: user
    - cwd: /home/user/salt-docker-demo
    - unless: docker ps | grep saltmaster
    - require:
      - service: docker
      - git: salt-docker-demo-repo
      - sls: base-system

docker-minions:
  cmd.run:
    - name: "for i in {1..2}; do docker run -d --hostname saltminion$i --name saltminion$i --link saltmaster:salt mbologna/saltstack-minion ; done"
    - user: user
    - cwd: /home/user/salt-docker-demo
    - unless: docker ps | grep saltminion1
    - require:
      - cmd: docker-master
