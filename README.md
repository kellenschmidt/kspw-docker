# Hooplife

Jenn's SMU Fall 2017 DB/GUI Project

## Dev Environment

Instructions for running the project locally

### Setup

Prepare for takeoff🚀

With old code
```
npm run setup
```

With my code
```
npm install
```

### Docker Scripts

These commands are to be run in the top level 'endlist' folder. Docker and docker-compose must be installed for this to work

`npm run docker-start`: Starts the docker containers. The frontend can be accessed from http://localhost:80. The backend can be accessed from http://localhost:80/backend/public.

`npm run docker-stop`: Stops the docker containers.

`npm run docker-prod`: Starts the docker containers in production mode. The frontend is configured to be accessed from http://endlist.fun and the backend from http://api.endlist.fun.

### Testing

`npm test`: Runs tests for both the fronend and backend.

`npm run test-frontend`: Runs tests for the frontend using jest.

`npm run test-backend`: Runs tests for the backend using phpunit.
