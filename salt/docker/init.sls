include:
  - base-system

docker:
  pkg.latest: []
  service.running:
    - enable: True
    - require:
      - pkg: docker  
      
clone-docker-demo:    
  cmd.run:
    - name: git clone https://github.com/mbologna/salt-docker-demo
    - user: user
    - cwd: /home/user
    - unless: ls /home/user/salt-docker-demo
    - require:
      - sls: base-system

docker-master:
  cmd.run:
    - name: "docker run -d --name saltmaster 
      -v `pwd`/etc_master/salt:/etc/salt 
      -p 8000:8000
      -ti mbologna/saltstack-master"
    - user: user
    - cwd: /home/user/salt-docker-demo
    - unless: docker ps | grep saltmaster
    - require:
      - service: docker
      - sls: base-system

docker-minion1:
  cmd.run:
    - name: "docker run -d --name saltminion1
      --link saltmaster
      -v `pwd`/etc_minion1/salt:/etc/salt mbologna/saltstack-minion"
    - user: user
    - cwd: /home/user/salt-docker-demo
    - unless: docker ps | grep saltminion1
    - require:
      - cmd: docker-master

docker-minion2:
  cmd.run:
    - name: "docker run -d --name saltminion2
      --link saltmaster
      -v `pwd`/etc_minion2/salt:/etc/salt mbologna/saltstack-minion"
    - user: user
    - cwd: /home/user/salt-docker-demo
    - unless: docker ps | grep saltminion2
    - require:
      - cmd: docker-master
