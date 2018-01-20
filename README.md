# KSPW-Docker

In progress Docker containerization of my personal website, kellenschmidt.com 

## Dev Environment

Instructions for running the project locally

### Setup

Prepare for takeoff🚀

```
npm install

More instructions to come...
```

Edit hosts file

```
sudo nano /etc/hosts

More instructions to come...
```

### Docker Scripts

These commands are to be run in the top level 'endlist' folder. Docker and docker-compose must be installed for this to work

`npm run docker-start`: Starts the docker containers. The frontend can be accessed from http://kspw. The backend can be accessed from http://api.kspw.

`npm run docker-stop`: Stops the docker containers.

`npm run docker-prod`: Starts the docker containers in production mode. The frontend is configured to be accessed from `TBD` and the backend from `TBD`

### Testing

Not yet implemented

`npm test`: Runs tests for both the fronend and backend.

`npm run test-frontend`: Runs tests for the frontend using jest.

`npm run test-backend`: Runs tests for the backend using phpunit.
