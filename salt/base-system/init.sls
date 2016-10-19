upgrade-all-packages:
  pkg.uptodate:
    - refresh: True
    
user:
  user.present:
    - fullname: Candidate for SUSE
    - shell: /bin/bash
    - home: /home/user
    - password: interview
    - groups:
      - docker
