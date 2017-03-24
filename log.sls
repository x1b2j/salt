/srv/salt/logger.sh:
  cron.present:
    - user: root
    - minute: '*/30'
