include:
  - base-system.repos

minimal_package_update:
  pkg.latest:
    - pkgs:
      - salt
      - salt-minion
      - zypper
      - libzypp
    - order: last
    - require:
      - sls: base-system.repos
