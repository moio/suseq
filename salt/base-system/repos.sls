{% if grains['os'] == 'SUSE' %}

{% if grains['osrelease'] == '42.2' %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/openSUSE-Leap-42.2-Pool.repo
    - source: salt://base-system/repos.d/openSUSE-Leap-42.2-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/openSUSE-Leap-42.2-Update.repo
    - source: salt://base-system/repos.d/openSUSE-Leap-42.2-Update.repo
    - template: jinja
{% endif %}
{% endif %}

default_repos:
  test.nop: []
