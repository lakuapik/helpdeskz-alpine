# helpdeskz Alpine

![helpdeskz](https://img.shields.io/badge/helpdeskz%20version-2.0.2-blue)
![image](https://img.shields.io/docker/v/lakuapik/helpdeskz-alpine?label=docker%20image%20version&sort=semver)
![size](https://img.shields.io/docker/image-size/lakuapik/helpdeskz-alpine?sort=semver&label=docker%20image%20size)
![pulls](https://img.shields.io/docker/pulls/lakuapik/helpdeskz-alpine)

> HelpDeskZ is a free PHP based software which allows you to manage your site's support with a web-based support ticket system.

HelpdeskZ image built on Alpine Linux. Visit [HelpdeskZ Website](https://www.helpdeskz.com/) or [HeldeskZ Docs](https://docs.helpdeskz.com) or [HelpdeskZ Github](https://github.com/helpdesk-z/helpdeskz-dev) for more information.

## Usage

### Configuration

Refer to the docs here https://docs.helpdeskz.com/en/2.0.2/installation/#configuration-file. We need to specify configration file before installing HelpdeskZ.

Please see the example file [Helpdesk.php](./Helpdesk.php)

### Running the image

```sh
# run mysql container
$ docker run \
    --name helpdeskz-mysql \
    -p 3306:3306 \
    -e MYSQL_DATABASE=helpdeskz \
    -e MYSQL_ROOT_PASSWORD=password \
    -d \
    mysql:8.0

# run helpdeskz container
$ docker run \
    --name helpdeskz-app \
    -p 80:80 \
    -v $(pwd)/Helpdesk.php:/var/www/html/hdz/app/Config/Helpdesk.php \
    --link helpdeskz-mysql:mysql \
    -d \
    lakuapik/helpdeskz-alpine:latest

# visit http://localhost/install
```

### Using docker-compose

Please see the example file [docker-compose.yml](./docker-compose.yml)
