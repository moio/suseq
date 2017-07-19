include:
  - base-system

patterns-openSUSE-xfce:
  pkg.latest

autostart-applications:
  file.recurse:
    - name: /home/user/.config/autostart
    - source: salt://graphical-system/autostart
    - user: user
    - group: users
    - unless: ls -l /home/user/.config/autostart
    - require:
      - pkg: patterns-openSUSE-xfce
      - sls: base-system

configure-resolution:
  file.recurse:
    - name: /home/user/.config/xfce4
    - source: salt://graphical-system/xfce4
    - user: user
    - group: users
    - unless: ls -l /home/user/.config/xfce4
    - require:
      - pkg: patterns-openSUSE-xfce
      - sls: base-system
