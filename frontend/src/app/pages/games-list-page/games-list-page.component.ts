import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { GameService } from '../../_services/game.service';
import { ProfileService } from '../../_services/profile.service';

import { Game } from '../../_models/game';

@Component({
  selector: 'app-games-list-page',
  templateUrl: './games-list-page.component.html',
  styleUrls: ['./games-list-page.component.scss']
})

export class GamesListPageComponent implements OnInit {

  allGamesActive: boolean = true;
	allGames: Game[] = [];
	attendingGames: Game[] = [];

	constructor(
    private router: Router,
    private gameService: GameService,
    private profileService: ProfileService
  ) {
	}

	ngOnInit() {
    this.getAllGames();
    this.getAttendingGames();
	}

  getAllGames() {
    this.gameService.getAllGames().subscribe(
      games => {
        this.allGames = games;
      },
      err => {
        console.log("Error getting all games");
      }
    );
  }

  getAttendingGames() {
    var currentUser = this.profileService.getCurrentUser();
    this.gameService.getRSVPGames(currentUser).subscribe(
      games => {
        this.attendingGames = games;
      },
      err => {
        console.log("Error getting rsvp'd games");
      }
    );
  }

  openNewGamePage() {
    this.router.navigate(['/dashboard/gameSubmit']);
  }

	allGamesToggle(){
		this.allGamesActive = true;
	}

	attendingGamesToggle(){
		this.allGamesActive = false;
	}

}
