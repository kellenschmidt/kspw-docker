import { InMemoryDbService } from 'angular-in-memory-web-api';

export class InMemoryDataService implements InMemoryDbService {
  createDb() {
    const users = [
      {
        firstName: 'Jenn',
        lastName: 'Le',
        username: 'Thakugan',
        email: 'jennl@smu.edu',
        password: 'pass',
        dateCreated: new Date(),
        comments: [],
        rating: 5,
        year: 'Junior',
        gamesPlayed: 0,
        wins: 0,
        losses: 0
      }
    ];

    const login = [
    ]

    const locations = [
      {
        name: 'Dedman R666',
        photoName: 'temp.jpg',
        address: 'SMU',
        description: 'Only midly disgusting',
        comments: [],
        rating: 3
      }
    ]

    return {users, login, locations};
  }
}
