# kellenschmidt.com Docker Containerization

Docker containerization of [kellenschmidt.com](http://kellenschmidt.com) to standardize development, testing, and deployment of the application and its components as a whole to local and production environments.

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

Instructions for running the project locally. These commands are to be run in the top level `kspw-docker` folder.

Install prerequisite dependencies depending on environment

| Development   | Production   | Download link                                                                                                                        |
| ------------- | ------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| Docker        | Docker       | [https://store.docker.com/search?type=edition&offering=community](https://store.docker.com/search?type=edition&offering=community)   |
| Git           |              | [https://git-scm.com/downloads](https://git-scm.com/downloads)                                                                       |
| Node.js       |              | [https://nodejs.org/en/download](https://nodejs.org/en/download)                                                                     |

Download project

```Shell
git clone https://github.com/kellenschmidt/kspw-docker.git
cd kspw-docker
```

Create environment variables file

* `touch .env` in project root
* Populate with the required variables listed under [Environment Variables](#environment-variables)

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
3. Configure security group to allow HTTP(80), HTTPS(443), and SSH(22), PhpMyAdmin(8080)
4. Create and associate elastic IP address
5. Optionally add custom password-protected keypair via SSH and authorized_keys
  * Add public key to `~/.ssh/authorized_keys` on server
  * Might need to remove current kellenschmidt.com entry from `~/.ssh/known_hosts` locally
6. Install Docker

```Shell
sudo yum update -y
sudo yum install -y docker
sudo usermod -a -G docker ec2-user
sudo service docker start
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

7. Log out and log back in to SSH
8. Download kspw-docker repository

```Shell
curl -L https://api.github.com/repos/kellenschmidt/kspw-docker/tarball/master > ~/kspw-docker.tar.gz
tar -xzf ~/kspw-docker.tar.gz
mv ~/kellenschmidt-kspw-docker-* ~/kspw-docker
rm ~/kspw-docker.tar.gz
```

9. Initialize container with proper environment variables and database files
  * Edit `~/init/.env`
  * Add database backup .sql.gz file or .sql file(s) to `~/init/`
  * `bash ~/init/init-from-delete.sh`

10. Start it up! `bash ~/kspw-docker/bin/start.sh prod`
