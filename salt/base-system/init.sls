include:
  - base-system.repos

upgrade-all-packages:
  pkg.uptodate:
    - refresh: True
    - require:
      - sls: base-system.repos
