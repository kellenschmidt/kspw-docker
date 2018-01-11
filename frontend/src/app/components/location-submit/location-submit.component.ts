import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material';

import { LocationService } from '../../_services/location.service';
import { ProfileService } from '../../_services/profile.service';

@Component({
  	selector: 'app-location-submit',
  	templateUrl: './location-submit.component.html',
  	styleUrls: ['./location-submit.component.scss']
})

export class LocationSubmitComponent {

  currUser: string;
  address: string;
  description: string;
  pic: string;

  constructor(
    private router: Router,
    private profileService: ProfileService,
    private locationService: LocationService,
    private snackBar: MatSnackBar
  ) {}

  cancel() {
    this.router.navigate(['/dashboard/locations']);
  }

  submit() {
    this.currUser = this.profileService.getCurrentUser();
    this.locationService.requestLoc(this.currUser, this.address, this.description, this.pic).subscribe(
      res => {
        this.snackBar.open('Location request suceeded, it will show up in the list once approved', '', {
          duration: 5000
        });
      },
      err => {
        this.snackBar.open('Request failed, please try again. Descriptions and addresses must be unique', '', {
          duration: 5000
        });
      }
    );
  }
}
