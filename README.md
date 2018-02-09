# KSPW-Docker

In progress Docker containerization of my personal website, [kellenschmidt.com](https://kellenschmidt.com)

## Features

* Deploy the entire application with a single command
* Deploy to local and remote environments
* All environment variables encapsulated into single .env file
* HTTPS encryption throughout website and API
* Automatic hourly, daily, weekly, and monthly complete database backups
* Automatic removal of old backups
* Automatic daily uploading of backups to cloud storage

## Local Development

Instructions for running the project locally. These commands are to be run in the top level 'kspw-docker' folder. Docker and docker-compose must be installed for this to work

Install prerequisites

* `Docker`: [Docker Download](https://store.docker.com/search?type=edition&offering=community)
* `Git`: [Git Download](https://git-scm.com/downloads)
* `Node.js`: [Node.js Download](https://nodejs.org/en/download/)
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

Optional: Preload database

* Add SQL files to `/database/schema_with_data`
* Confirm volume is attached (uncommented) in `config/docker-compose.yml`
* Restart Docker containers

## Other Docker Scripts

`npm run docker-stop`: Stops and removes the docker containers. Backs up database to `/database/backups`.

`npm run docker-deploy-prod`: Starts the Docker containers and installs code for production. The frontend can be accessed from http://kellenschmidt.com. The backend can be accessed from http://api.kellenschmidt.com.

`npm run docker-deploy-test`: Starts the Docker containers and installs code for testing. The frontend can be accessed from http://test.kellenschmidt.com. The backend can be accessed from http://testapi.kellenschmidt.com.

## General Notes

Environment variables file, `.env`, is required. Required variables:

`MYSQL_ROOT_PASSWORD`: Required (but ignored). Overwritten by Docker. Find new MySQL root password with `docker logs kspw-db 2>&1 | grep GENERATED`

`MYSQL_USER`: Required. Username of non-root MySQL user.

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
