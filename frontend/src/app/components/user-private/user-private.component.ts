import { Component, OnInit, Input } from '@angular/core';

import { User } from '../../_models/user';
import { Location } from '../../_models/location';
import { Comment } from '../../_models/comment';

@Component({
  	selector: 'app-user-private',
  	templateUrl: './user-private.component.html',
  	styleUrls: ['./user-private.component.css']
})

export class UserPrivateComponent {

	displayComments: boolean = false;
	@Input() user: User;
  @Input() locations: Location[];
  @Input() comments: Comment[];

	newUsername: string;
	newEmail: string;

	constructor(){ }

	updateUser(){
		this.user.username = this.newUsername;
		this.user.email = this.newEmail;
	}

}
