patterns-openSUSE-xfce:
  pkg.installed

autostart-applications:
  file.recurse:
    - name: /home/user/.config/autostart
    - source: salt://graphical-system/autostart
    - user: user
    - group: users
    - unless: ls -l /home/user/.config/autostart
    - require:
      - pkg: patterns-openSUSE-xfce      
