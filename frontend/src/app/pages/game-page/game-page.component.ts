import { Component, Input, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { MatSnackBar } from '@angular/material';

import { GameService } from '../../_services/game.service';
import { ProfileService } from '../../_services/profile.service';
import { LocationService } from '../../_services/location.service';

import { User } from '../../_models/user';
import { Game } from '../../_models/game';
import { Comment } from '../../_models/comment';
import { Location } from '../../_models/location';

@Component({
  selector: 'app-game-page',
  templateUrl: './game-page.component.html',
  styleUrls: ['./game-page.component.scss']
})

export class GamePageComponent implements OnInit {

  user: User;
  game: Game;
  player: boolean;
  players: User[];
  comments: Comment[];
  location: Location;

  newComment: Comment = new Comment();

	constructor(
    private route: ActivatedRoute,
    private router: Router,
    private gameService: GameService,
    private profileService: ProfileService,
    private locationService: LocationService,
    private snackBar: MatSnackBar
  ) {
	}

	ngOnInit() {
    this.getUser();
    this.getGame();
    this.isPlayer();
    this.getPlayers();
    this.getComments();
	}

  getUser() {
    var currentUser = this.profileService.getCurrentUser();
    this.profileService.getUser(currentUser).subscribe(
      user => {
        this.user = user;
      },
      err => {
        this.user = new User();
      }
    );
  }

  getGame() {
    const gameid = +this.route.snapshot.paramMap.get('gameid');
    this.gameService.getGame(gameid).subscribe(
      game => {
        this.game = game[0];
        console.log(JSON.stringify(this.game));
        console.log(this.game.locationID);
        this.getLocation(this.game.locationID);
      },
      err => {
        this.game = new Game();
      }
    );
  }

  isPlayer() {
    const gameid = +this.route.snapshot.paramMap.get('gameid');
    const currentUser = this.profileService.getCurrentUser();
    this.gameService.getRSVPGames(currentUser).subscribe(
      games => {
        for(var game of games) {
          if(game.GameID == gameid) {
            this.player = true;
            return;
          }
        }

        this.player = false;
      },
      err => {
        this.player = false;
        console.log('User does not have any rsvps');
      }
    );
  }

  getPlayers() {
    const gameid = +this.route.snapshot.paramMap.get('gameid');
    this.gameService.getGameRSVPs(gameid).subscribe(
      players => {
        this.players = players;
      },
      err => {
        this.players = [];
      }
    );
  }

  getComments() {
    const gameid = +this.route.snapshot.paramMap.get('gameid');
    this.profileService.getComments("game", gameid).subscribe(
      comments => {
        this.comments = comments;
      },
      err => {
        this.comments = [];
      }
    );
  }

  getLocation(id: number) {
    this.locationService.getLocation(id).subscribe(
      res => {
        this.location = res;
      },
      err => {
        this.location = new Location();
        console.log("could not find location");
      }
    )
  }

  addComment(){
    const gameid = this.route.snapshot.paramMap.get('gameid');
    this.profileService.createComment(this.user.username, this.newComment.Comment, 'game', gameid, 0).subscribe(
      res => {
        this.router.navigate(['/dashboard/game/' + gameid])
      },
      err => {
        this.snackBar.open('Comment submition failed, please try again.', '', { duration: 5000 });
      }
    );
	}

  handlePlayer(){
    if(this.player){
      this.gameService.deleteRSVP(this.user.username, this.game.GameID).subscribe(
        res => {
          this.player = false;
          const gameid = +this.route.snapshot.paramMap.get('gameid');
          this.router.navigate([`/dashboard/game/${gameid}`]);
          this.snackBar.open("You have canceled your rsvp to this game", '', {
            duration: 5000
          });
        },
        err => {
          this.snackBar.open('Could not delete rsvp, please try again', '', {
            duration: 5000
          });
        }
      );
    }
    else{
      this.gameService.rsvp(this.user.username, this.game.GameID).subscribe(
        res => {
          this.player = true;
          const gameid = +this.route.snapshot.paramMap.get('gameid');
          this.router.navigate([`/dashboard/game/${gameid}`]);
          this.snackBar.open("You have rsvp'd to this game", '', {
            duration: 5000
          });
        },
        err => {
          this.snackBar.open('Could not rsvp, please try again', '', {
            duration: 5000
          });
        }
      );
    }
  }
}
