# Docker php54

- nginx with php fpm
- php version 5.4
- included php extension: imagick, gd, curl, apc, mysql, mcrypt

## Usage

### in Dockerfile
    FROM aooj/php54:latest

### build
    git clone https://github.com/AoJ/docker-php54.git
    make build
    
### and start it
    make run

### or build, start and attach
    make debug

## TODO
- set chroot
- logs to one folder
- default mysql creditals from docker link
- tuneup nginx config
    
## Changelog
- 1.0 first realese
