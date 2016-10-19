git:
  pkg.latest

java-1_8_0-openjdk-devel:
  pkg.latest

eclipse:
  archive.extracted:
    - name: /opt/
    - source: http://ftp.halifax.rwth-aachen.de/eclipse/technology/epp/downloads/release/neon/1a/eclipse-jee-neon-1a-linux-gtk-x86_64.tar.gz
    - source_hash: http://ftp.halifax.rwth-aachen.de/eclipse/technology/epp/downloads/release/neon/1a/eclipse-jee-neon-1a-linux-gtk-x86_64.tar.gz.sha512
    - archive_format: tar
    - if_missing: /opt/eclipse

eclipse-config:
  file.replace:
    - name: /opt/eclipse/eclipse.ini
    - pattern: "openfile\n--launcher.appendVmargs"
    - repl: "openfile\n--launcher.GTK_version\n2\n--launcher.appendVmargs"
    - require:
      - archive: eclipse

maven:
  archive.extracted:
    - name: /opt/
    - source: http://mirror.nohup.it/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip
    - source_hash: https://www.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip.md5
    - archive_format: zip
    - if_missing: /opt/apache-maven-3.3.9
