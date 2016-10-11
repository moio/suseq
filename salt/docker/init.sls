docker:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: docker  

che:
  cmd.run:
    - name: docker run --rm -t -v /var/run/docker.sock:/var/run/docker.sock -e CHE_HOST_IP={{grains['hostname']}} eclipse/che start
    - unless: docker ps | grep che-server
