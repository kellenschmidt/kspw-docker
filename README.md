# KSPW-Docker

Docker containerization of [kellenschmidt.com](https://kellenschmidt.com)

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
* `Node.js`: [Node.js Download](https://nodejs.org/en/download/)
* `PHP`: [PHP Download](http://php.net/downloads.php)
* `Angular CLI`: `npm i -g @angular/cli`

Download project and install dependencies

```Shell
git clone https://github.com/kellenschmidt/kspw-docker.git
cd kspw-docker
npm install
```

Edit hosts file

* `sudo nano /etc/hosts`
* Add `127.0.0.1 kspw api.kspw test.kspw testapi.kspw urlshortenerphp.kspw` on a new line at the end of the file

Create environment variables file

* `touch .env` in project root
* Populate with the required variables listed under "General Notes"

Start Docker containers

```Shell
npm run docker-start
```

Preload database

* Latest backup (from matching environment) will automatically be restored if one exists
* If not restoring from backup, add SQL files to `config/kspw-db/database/schema-with-data`
* Otherwise, the empty schema will be loaded from `config/kspw-db/database/schema-only`

## Other Docker Scripts

`npm run docker-stop`: Stops and removes the docker containers. Backs up database to `/database/backups`.

`npm run docker-deploy-prod`: Starts the Docker containers and installs code for production. The frontend can be accessed from http://kellenschmidt.com. The backend can be accessed from http://api.kellenschmidt.com.

`npm run docker-deploy-test`: Starts the Docker containers and installs code for testing. The frontend can be accessed from http://test.kellenschmidt.com. The backend can be accessed from http://testapi.kellenschmidt.com.

## General Notes

Environment variables file, `.env`, is required. Required variables:

`MYSQL_ROOT_PASSWORD`: Required (but ignored). Overwritten by Docker. Find new MySQL root password with `docker logs kspw-db 2>&1 | grep GENERATED`

`MYSQL_USER`: Required. Username of non-root MySQL user. Note: Must also edit `config/kspw-db/database/grant_permissions.sql`

`MYSQL_PASSWORD`: Required. Password of non-root MySQL user.

`JWT_SECRET`: Required. Secret for JSON Web Token signatures.

`RECAPTCHA_SECRET`: Unnecessary. For future use when ReCaptcha is implemented in login/signup forms.

`OAUTH_ACCESS_TOKEN`: Optional. Dropbox access token for uploading database backups to cloud storage.

`ENV`: Unnecessary. Set automatically by installation scripts. Options:

| `ENV`     | Code branch   | URLs                    | Other            |
| --------- | ------------- | ----------------------- | ---------------- |
| `prod`    | master        | production (*.com)      | Runs Certbot     |
| `test`    | development   | production (test*.com)  | Runs Certbot     |
| `docker`  | development   | development (*.kspw)    |                  |

## AWS Deployment

1. Launch Linux EC2 instance
2. Create keypair for SSH
3. Create and associate elastic IP address
4. Configure security group to allow HTTP(80), HTTPS(443), and SSH(22), PhpMyAdmin(8080)
5. Optionally add custom password-protected keypair

After starting an Amazon Linux AWS EC2 instance, the following commands will update server settings and install the prerequisite dependencies to prepare for Docker

```Shell
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo service docker restart
sudo yum install git
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
sudo yum -y install nodejs
sudo chmod 777 /usr/lib/node_modules/
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
touch ~/.profile
source ~/.profile
npm i -g @angular/cli
sudo yum remove httpd* php*
sudo yum install php70
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
