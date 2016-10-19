include:
  - base-system
  - devel-packages

clone-netapi:
  cmd.run:
    - name: git clone https://github.com/SUSE/salt-netapi-client
    - user: user
    - cwd: /home/user
    - unless: ls /home/user/salt-netapi-client
    - require:
      - sls: base-system

configure-maven-dependencies:
  cmd.run:
    - name: "/opt/apache-maven-3.3.9/bin/mvn eclipse:eclipse"
    - user: user
    - cwd: /home/user/salt-netapi-client
    - require:
      - sls: devel-packages
      - cmd: clone-netapi

preconfigure-eclipse-dotfiles:
  file.recurse:
    - name: /home/user/.eclipse
    - source: salt://devel-netapi/eclipse-dotfiles
    - user: user
    - group: users
    - unless: ls -l /home/user/.eclipse
    - require:
      - cmd: configure-maven-dependencies

preconfigure-eclipse-workspace:
  file.recurse:
    - name: /home/user/workspace
    - source: salt://devel-netapi/workspace
    - user: user
    - group: users
    - unless: ls -l /home/user/workspace
    - require:
      - cmd: configure-maven-dependencies
