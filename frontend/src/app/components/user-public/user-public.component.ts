import { Component, OnInit, Input } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { MatSnackBar } from '@angular/material';

import { User } from '../../_models/user'
import { Comment } from '../../_models/comment';

import { ProfileService } from '../../_services/profile.service';

@Component({
  	selector: 'app-user-public',
  	templateUrl: './user-public.component.html',
  	styleUrls: ['./user-public.component.css']
})

export class UserPublicComponent{

	displayComments: boolean = true;
	currentUser: string;
	hasCommented: boolean = false;
	hasRated: boolean = false;
	newComment: Comment = new Comment();

	@Input() public user: User;
  @Input() comments: Comment[];

	constructor(
    private route: ActivatedRoute,
    private router: Router,
    private profileService: ProfileService,
    private snackBar: MatSnackBar
  ){ }

  ngOnInit() {
    this.currentUser = this.profileService.getCurrentUser();
  }

	addComment() {
    const user = this.route.snapshot.paramMap.get('username');
    this.profileService.createComment(this.currentUser, this.newComment.Comment, 'user', user, this.newComment.rating).subscribe(
      res => {
        this.router.navigate(['/dashboard/user/' + user])
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
