tigervnc:
  pkg.installed: []
  cmd.run:
    - name: vncserver -AlwaysShared &
    - unless: ps auxw | grep vncserver
    - require:
      - pkg: tigervnc

novnc:
  file.managed:
    - name: /opt/noVNC.zip
    - source: https://github.com/kanaka/noVNC/archive/v0.6.1.zip
    - source_hash: sha512=9c6686a072ad9e16e98c0a0d3842b852f987c507d1537d8d5b47d5dc852af5cedb907feb88d4dc5465e83703e8172c6d610df90ae27a4c040dc94a7bf5b8bf7a
  cmd.run:
    - name: unzip /opt/noVNC.zip
    - cwd: /opt
    - unless: ls /opt/noVNC
    - require:
      - file: novnc

launch-novnc:
  cmd.run:
    - name: /opt/noVNC/utils/launch.sh --vnc localhost:5901 --listen 80
    - unless: ps auxw | grep -i novnc
