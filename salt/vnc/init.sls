tigervnc:
  pkg.installed: []
  cmd.run:
    - name: vncserver -AlwaysShared -geometry 1680x1050 -geometry 1280x1024 -geometry 1280x800 -geometry 1024x768
    - unless: ps auxw | grep vncserver
    - user: user
    - require:
      - pkg: tigervnc
      - sls: base-system
      
vnc-password:
  file.managed:
    - name: /home/user/.vnc/passwd
    - source: salt://vnc/passwd
    - makedirs: True
    - source_hash: sha512=3d15c95d0b47e6686ef76d161e7bc738d60a9486d51d9329ca63dcea2b24dc7319bb0c7d8af37ae59f2ca7faf8cf714e89a36eadce9a5ece6b60d391f0c23169
    - user: user
    - group: users
    - mode: 600
    - unless: ls -l /home/user/.vnc/passwd
    - require:
      - cmd: tigervnc

novnc-install:
  file.managed:
    - name: /opt/noVNC.zip
    - source: https://github.com/kanaka/noVNC/archive/v0.6.1.zip
    - source_hash: sha512=9c6686a072ad9e16e98c0a0d3842b852f987c507d1537d8d5b47d5dc852af5cedb907feb88d4dc5465e83703e8172c6d610df90ae27a4c040dc94a7bf5b8bf7a
  cmd.run:
    - name: unzip /opt/noVNC.zip
    - cwd: /opt
    - unless: ls /opt/noVNC-0.6.1
    - require:
<<<<<<< 5448a0d4080109441400854a2d39e6d649acb454
      - file: novnc

launch-novnc:
  cmd.run:
    - name: /opt/noVNC/utils/launch.sh --vnc localhost:5901 --listen 80
    - unless: ps auxw | grep -i novnc
=======
      - file: novnc-install
  
novnc:
  file.managed:
    - name: /etc/systemd/system/novnc.service
    - source: salt://vnc/novnc.service
    - source_hash: sha512=84e569f2cbb112aa7eee6bb1c73c079db5609a45f43898941b55ec6902c654351dad7ef3184f7a52748b6adf18047332735f1b6156a3b67accea266fad5113fb
    - unless: /etc/systemd/system/novnc.service
    - require:
      - sls: base-system
  service.running:
    - enable: True
    - require:
      - cmd: novnc-install
      
>>>>>>> Start noVNC as a service via systemd
