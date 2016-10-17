upgrade-all-packages:
  pkg.uptodate:
    - refresh: True
    
user:
  user.present:
    - fullname: Candidate for SUSE
    - shell: /usr/bin/zsh
    - home: /home/user
    - password: interview
    - groups:
      - docker

zsh-empty-config:
  file.touch:
    - name: /home/user/.zshrc
    - unless: ls -l /home/user/.zshrc
  require:
    - user: user
