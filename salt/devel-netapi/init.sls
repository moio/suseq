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

salt-netapi-client-dependencies:
  cmd.run:
    - name: "/opt/apache-maven-3.3.9/bin/mvn eclipse:eclipse"
    - user: user
    - cwd: /home/user/salt-netapi-client
    - require:
      - sls: devel-packages
      - git: salt-netapi-client-repo

eclipse-dotfiles:
  file.recurse:
    - name: /home/user/.eclipse
    - source: salt://devel-netapi/eclipse-dotfiles
    - user: user
    - group: users
    - include_empty: true
    - require:
      - cmd: salt-netapi-client-dependencies

eclipse-workspace:
  file.recurse:
    - name: /home/user/workspace
    - source: salt://devel-netapi/workspace
    - user: user
    - group: users
    - include_empty: true
    - require:
      - cmd: salt-netapi-client-dependencies
