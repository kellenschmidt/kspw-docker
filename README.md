# KSPW-Docker

Docker containerization of [kellenschmidt.com](http://kellenschmidt.com)

## Features

* Deploy the entire application with a single command
* Deploy to local and remote environments
* All environment variables encapsulated into single .env file
* HTTPS encryption throughout website and API
* Automatic renewal of HTTPS certificates
* Automatic hourly, daily, weekly, and monthly complete database backups
* Automatic removal of old backups
* Database automatically populated (from backup or file)
* Automatic daily uploading of backups to cloud storage

## Local Development

Instructions for running the project locally. These commands are to be run in the top level 'kspw-docker' folder

Install prerequisites

* `Docker`: [Docker Download](https://store.docker.com/search?type=edition&offering=community)
* `Git`: [Git Download](https://git-scm.com/downloads)

Download project and install dependencies

```Shell
git clone https://github.com/kellenschmidt/kspw-docker.git
cd kspw-docker
```

Create environment variables file

* `touch .env` in project root
* Populate with the required variables listed under "Environment Variables"

Preload database

* Latest backup (from matching environment) will automatically be restored if one exists
* If not restoring from backup, add SQL files to `config/kspw-db/database/schema-with-data`
* Otherwise, the empty schema will be loaded from `config/kspw-db/database/schema-only`

Edit hosts file

* `sudo nano /etc/hosts`
* Add `127.0.0.1 kspw api.kspw urlshortenerphp.kspw test.kspw testapi.kspw` on a new line at the end of the file

### Docker Scripts

`npm run start-dev`: Starts the Docker containers locally and installs code for development. The frontend can be accessed from http://kspw. The backend can be accessed from http://api.kspw.

`npm run stop`: Stops and removes the docker containers.

`npm run start-prod`: Starts the Docker containers and installs code for production. The frontend can be accessed from http://kellenschmidt.com. The backend can be accessed from http://api.kellenschmidt.com.

`npm run start-test`: Starts the Docker containers and installs code for testing. The frontend can be accessed from http://test.kellenschmidt.com. The backend can be accessed from http://testapi.kellenschmidt.com.

### Environment Variables

Environment variables file, `.env`, is required. Required variables:

`MYSQL_ROOT_PASSWORD`: Required (but ignored). Overwritten by Docker. Find new MySQL root password with `docker logs kspw-db 2>&1 | grep GENERATED`

`MYSQL_USER`: Required. Username of non-root MySQL user. Note: Must also edit `config/kspw-db/database/permissions/grant_permissions.sql`

`MYSQL_PASSWORD`: Required. Password of non-root MySQL user.

`JWT_SECRET`: Required. Secret for JSON Web Token signatures.

`RECAPTCHA_SECRET`: Unnecessary. For future use when ReCaptcha is implemented in login/signup forms.

`OAUTH_ACCESS_TOKEN`: Optional. Dropbox access token for uploading database backups to cloud storage.

`ENV`: Unnecessary. Set automatically by installation scripts. Options:

| `ENV`     | Code branch   | URLs                                  | Other          |
| --------- | ------------- | ------------------------------------- | -------------- |
| `prod`    | master        | production (*.kellenschmidt.com)      | Runs Certbot   |
| `test`    | staging       | production (test*.kellenschmidt.com)  | Runs Certbot   |
| `docker`  | dev           | development (*.kspw)                  |                |

## AWS Deployment

1. Launch Linux EC2 instance
2. Create keypair for SSH
3. Create and associate elastic IP address
4. Configure security group to allow HTTP(80), HTTPS(443), and SSH(22), PhpMyAdmin(8080)
5. Optionally add custom password-protected keypair
6. Install Git and Docker

```Shell
sudo yum update -y
sudo yum install -y git docker
sudo usermod -a -G docker ec2-user
sudo service docker start
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

7. Log out and log back in to SSH
8. Start it up! `npm run start-prod`
