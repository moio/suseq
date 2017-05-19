git:
  pkg.latest

java-1_8_0-openjdk-devel:
  pkg.latest

eclipse:
  archive.extracted:
    - name: /opt/
    - source: http://eclipsemirror.itemis.de/eclipse/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-linux-gtk-x86_64.tar.gz
    - source_hash: http://eclipsemirror.itemis.de/eclipse/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-linux-gtk-x86_64.tar.gz.sha512
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
    - source: http://apache.panu.it/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.zip
    - source_hash: https://www.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.zip.md5
    - archive_format: zip
    - if_missing: /opt/apache-maven-3.5.0
