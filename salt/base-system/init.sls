include:
  - base-system.repos

upgrade-all-packages:
  pkg.uptodate:
    - refresh: True
    - require:
      - sls: base-system.repos

user:
  user.present:
    - fullname: Candidate for SUSE
    - shell: /bin/bash
    - home: /home/user
    - password: interview
