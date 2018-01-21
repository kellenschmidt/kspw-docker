# KSPW-Docker

In progress Docker containerization of my personal website, kellenschmidt.com

## Local Development

Instructions for running the project locally. These commands are to be run in the top level 'kspw-docker' folder. Docker and docker-compose must be installed for this to work

Edit hosts file
*`sudo nano /etc/hosts`
*Add `127.0.0.1 kspw api.kspw test.kspw testapi.kspw urlshortenerphp.kspw` on a new line at the end of the file

Start Docker containers
```
npm install
npm run docker-start
```

## Other Docker Scripts

`npm run docker-stop`: Stops and removes the docker containers.

`npm run docker-deploy-prod`: Starts the Docker containers and installs code for production. The frontend can be accessed from http://kellenschmidt.com. The backend can be accessed from http://api.kellenschmidt.com.

`npm run docker-deploy-test`: Starts the Docker containers and installs code for testing. The frontend can be accessed from http://test.kellenschmidt.com. The backend can be accessed from http://testapi.kellenschmidt.com.

### Testing

Not yet implemented

`npm test`: Runs tests for both the fronend and backend.

`npm run test-frontend`: Runs tests for the frontend using jest.

`npm run test-backend`: Runs tests for the backend using phpunit.

### General Notes

To get MySQL root password `docker logs kspw-db 2>&1 | grep GENERATED`
