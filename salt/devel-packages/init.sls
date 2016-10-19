include:
  - base-system
  - docker

git:
  pkg.latest

java-1_8_0-openjdk-devel:
  pkg.latest

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
