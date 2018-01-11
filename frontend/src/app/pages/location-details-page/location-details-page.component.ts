import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { MatSnackBar } from '@angular/material';

import { LocationService } from '../../_services/location.service';
import { ProfileService } from '../../_services/profile.service';

import { Location } from '../../_models/location';
import { Comment } from '../../_models/comment';

@Component({
  selector: 'app-location-details-page',
  templateUrl: './location-details-page.component.html',
  styleUrls: ['./location-details-page.component.scss']
})
export class LocationDetailsPageComponent implements OnInit {

  place: Location;
  comments: Comment[];
  displayComments: boolean = true;
  hasRated: boolean;
  hasCommented: boolean;

  newComment: Comment = new Comment();

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private locationService: LocationService,
    private profileService: ProfileService,
    private snackBar: MatSnackBar
  ) { }

  ngOnInit() {
    this.getLocation();
    this.getComments();
  }

  getLocation() {
    const loc = +this.route.snapshot.paramMap.get('locID');
    this.locationService.getLocation(loc).subscribe(
      location => {
        this.place = location[0];
      },
      err => {
        alert("something went wrong");
      }
    );
  }

  getComments() {
    const loc = +this.route.snapshot.paramMap.get('locID');
    this.profileService.getComments("location", loc).subscribe(
      comments => {
        this.comments = comments;
      },
      err => {
        this.comments = [];
      }
    );
  }

  addComment(){
    const loc = this.route.snapshot.paramMap.get('locID');
    const currentUser = this.profileService.getCurrentUser();
    this.profileService.createComment(currentUser, this.newComment.Comment, 'location', loc, this.newComment.rating).subscribe(
      res => {
        this.router.navigate(['/dashboard/location/' + loc])
      },
      err => {
        this.snackBar.open('Comment submition failed, please try again.', '', { duration: 5000 });
      }
    );
	}

  onRated(num: number){
    this.newComment.rating = num;
    this.hasRated = true;
  }
}
