# docker-schd-rclone
A schd docker image can execute rclone command job.

conf/schd.yaml
``` yaml
jobs:
  download:
    class: CommandJob
    cron: * * * * *
    cmd: rclone copy xxx:yyy /app/data/zzz
```

docker-compose.yaml

```yaml
version: "3.1"
services:
  schd:
    image: schd-rclone
    volumes:
      - ./conf:/app/conf
      - ./data:/app/data
      - ./rclone/rclone.conf:/config/rclone/rclone.conf
    command: schd daemon
```

