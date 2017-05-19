include:
  - base-system

vnc-password:
  file.managed:
    - name: /home/user/.vnc/passwd
    - source: salt://vnc/passwd
    - makedirs: True
    - source_hash: sha512=3d15c95d0b47e6686ef76d161e7bc738d60a9486d51d9329ca63dcea2b24dc7319bb0c7d8af37ae59f2ca7faf8cf714e89a36eadce9a5ece6b60d391f0c23169
    - user: user
    - group: users
    - mode: 600
    - require:
      - sls: base-system

tigervnc:
  pkg.latest

tigervnc-service:
  file.managed:
    - name: /etc/systemd/system/vncserver.service
    - source: salt://vnc/vncserver@:1.service
    - source_hash: sha512=68ddf7364c2ddb04666a3e04c10afa19e1606931b062772bd998cb58fadae4dcc2fad512c665c2110f5036800100d77388558d04033b55497e92f099acc32e55
    - require:
      - sls: base-system
      - pkg: tigervnc
  service.running:
    - name: vncserver.service
    - enable: True
    - require:
      - file: /etc/systemd/system/vncserver.service
      - file: vnc-password

novnc:
  archive.extracted:
    - name: /opt/
    - source: https://github.com/novnc/noVNC/archive/v0.6.2.zip
    - source_hash: sha512=bc7039a298dc732ef7e41897d43859ac140458142249ec6f4f49df9a4730014be1b11030f415125c16cdc9aa89469fedd45a37da30c25957161df2ccc54de51a
    - archive_format: zip
    - if_missing: /opt/noVNC-0.6.2

novnc-service:
  file.managed:
    - name: /etc/systemd/system/novnc.service
    - source: salt://vnc/novnc.service
    - source_hash: sha512=84e569f2cbb112aa7eee6bb1c73c079db5609a45f43898941b55ec6902c654351dad7ef3184f7a52748b6adf18047332735f1b6156a3b67accea266fad5113fb
  service.running:
    - name: novnc.service
    - enable: True
    - require:
      - file: /etc/systemd/system/novnc.service
      - archive: novnc
      - service: tigervnc-service
