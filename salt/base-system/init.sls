# upgrade all packages:
#   pkg.uptodate:
#     - refresh: True
    
user:
  user.present:
    - fullname: Candidate User
    - shell: /usr/bin/zsh
    - home: /home/user
    - password: interview
    - groups:
      - docker
