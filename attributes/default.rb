
compose = default['docker']['compose']
compose['release'] = "1.23.2" # latest
compose['repo'] = 'docker/compose'
compose['bin'] = "/usr/local/bin/docker-compose"
compose['file'] = "docker-compose-Linux-x86_64"
compose['mode'] = "0755"
compose['host'] = "https://github.com"

