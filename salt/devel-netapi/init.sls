include:
  - base-system
  - devel-packages

salt-netapi-client-repo:
  git.latest:
    - name: https://github.com/SUSE/salt-netapi-client
    - rev: master
    - target: /home/user/salt-netapi-client
    - user: user
    - require:
      - sls: base-system

configure-maven-dependencies:
  cmd.run:
    - name: "/opt/apache-maven-3.3.9/bin/mvn eclipse:eclipse"
    - user: user
    - cwd: /home/user/salt-netapi-client
    - require:
      - sls: devel-packages
      - git: salt-netapi-client-repo

preconfigure-eclipse-dotfiles:
  file.recurse:
    - name: /home/user/.eclipse
    - source: salt://devel-netapi/eclipse-dotfiles
    - user: user
    - group: users
    - require:
      - cmd: configure-maven-dependencies

preconfigure-eclipse-workspace:
  file.recurse:
    - name: /home/user/workspace
    - source: salt://devel-netapi/workspace
    - user: user
    - group: users
    - require:
      - cmd: configure-maven-dependencies
