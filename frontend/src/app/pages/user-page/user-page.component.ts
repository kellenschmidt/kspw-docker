import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

import { ProfileService } from '../../_services/profile.service';

import { User } from '../../_models/user';
import { Comment } from '../../_models/comment';

import { UserPublicComponent } from '../../components/user-public/user-public.component';
import { UserPrivateComponent } from '../../components/user-private/user-private.component'

@Component({
  selector: 'app-user-page',
  templateUrl: './user-page.component.html',
  styleUrls: ['./user-page.component.css']
})

export class UserPageComponent implements OnInit {

	isPublic: boolean;
  userFound: boolean = false;
  user: User;
  comments: Comment[];

	constructor(
    private route: ActivatedRoute,
    private profileService: ProfileService
  ) {
		this.isPublic = true;
	}

	ngOnInit() {
    this.getUser();
    this.getComments();
	}

  getUser() {
    const username = this.route.snapshot.paramMap.get('username');
    this.profileService.getUser(username).subscribe(
      user => {
        this.user = user;
        var currentUser = this.profileService.getCurrentUser();
        this.isPublic = (username === currentUser) ? false : true;
        this.userFound = true;
      },
      err => {
        this.user = new User();
      }
    );
  }

  getComments() {
    const username = this.route.snapshot.paramMap.get('username');
    this.profileService.getComments("user", username).subscribe(
      comments => {
        this.comments = comments;
      },
      err => {
        this.comments = [];
      }
    );
  }

}
