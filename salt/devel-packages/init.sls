include:
  - base-system
  - docker

git:
  pkg.installed

java-1_8_0-openjdk-1.8.0:
  pkg.installed

eclipse:
  file.managed:
    - name: /opt/eclipse.tar.gz
    - source: http://ftp.halifax.rwth-aachen.de/eclipse//technology/epp/downloads/release/neon/1a/eclipse-jee-neon-1a-linux-gtk-x86_64.tar.gz
    - source_hash: http://ftp.halifax.rwth-aachen.de/eclipse//technology/epp/downloads/release/neon/1a/eclipse-jee-neon-1a-linux-gtk-x86_64.tar.gz.sha512
  cmd.run:
    - name: tar zxvf /opt/eclipse.tar.gz
    - cwd: /opt
    - unless: ls /opt/eclipse
    - require:
      - file: eclipse

patch-eclipse-config:
  file.replace:
    - name: /opt/eclipse/eclipse.ini
    - pattern: "openfile\n--launcher.appendVmargs"
    - repl: "openfile\n--launcher.GTK_version\n2\n--launcher.appendVmargs"
    - require:
      - cmd: eclipse

maven:
  file.managed:
    - name: /opt/maven.zip
    - source: http://mirror.nohup.it/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip
    - source_hash: https://www.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip.md5
  cmd.run:
    - name: unzip /opt/maven.zip
    - cwd: /opt
    - unless: ls /opt/apache-maven-3.3.9/
    - require:
      - file: maven

clone-netapi:    
  cmd.run:
    - name: git clone https://github.com/SUSE/salt-netapi-client
    - runas: user
    - cwd: /home/user
    - unless: ls /home/user/salt-netapi-client
    - require:
      - sls: base-system

clone-docker-demo:    
  cmd.run:
    - name: git clone https://github.com/mbologna/salt-docker-demo
    - runas: user
    - cwd: /home/user
    - unless: ls /home/user/salt-docker-demo
    - require:
      - sls: base-system

configure-eclipse-project:
  cmd.run:
    - name: "/opt/apache-maven-3.3.9/bin/mvn eclipse:eclipse"
    - runas: user
    - cwd: /home/user/salt-netapi-client
    - require:
      - sls: base-system
      - cmd: clone-netapi

docker-master:
  cmd.run:
    - name: "docker run -d --name saltmaster 
      -v `pwd`/etc_master/salt:/etc/salt 
      -p 8000:8000
      -ti mbologna/saltstack-master"
    - runas: user
    - cwd: /home/user/salt-docker-demo
    - unless: docker ps | grep saltmaster
    - require:
      - sls: docker
      - sls: base-system

docker-minion1:
  cmd.run:
    - name: "docker run -d --name saltminion1
      --link saltmaster
      -v `pwd`/etc_minion1/salt:/etc/salt mbologna/saltstack-minion"
    - runas: user
    - cwd: /home/user/salt-docker-demo
    - unless: docker ps | grep saltminion1
    - require:
      - cmd: docker-master

docker-minion2:
  cmd.run:
    - name: "docker run -d --name saltminion2
      --link saltmaster
      -v `pwd`/etc_minion2/salt:/etc/salt mbologna/saltstack-minion"
    - runas: user
    - cwd: /home/user/salt-docker-demo
    - unless: docker ps | grep saltminion2
    - require:
      - cmd: docker-master
  
# import eclipse project
