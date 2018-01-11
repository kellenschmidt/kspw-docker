import { Component, Input, OnInit, ChangeDetectionStrategy } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { MatSnackBar } from '@angular/material';

import { LocationService } from '../../_services/location.service';
import { ProfileService } from '../../_services/profile.service';

import { Location } from '../../_models/location';

@Component({
  	selector: 'approve-locations',
  	templateUrl: './approve-locations.component.html',
  	styleUrls: ['./approve-locations.component.scss']
})

export class ApproveLocationsComponent implements OnInit{

	locations: Location[] = [];
	numOfLocations: number = 0;

	constructor(
    private locationService: LocationService,
    private profileService: ProfileService,
    private route: ActivatedRoute,
    private router: Router,
    private snackBar: MatSnackBar
  ){

	}

	ngOnInit(){
    this.getUnapprovedLocations();
	}

  getUnapprovedLocations() {
    this.locationService.getUnapprovedLocations().subscribe(
      res => {
        this.locations = res;
        this.numOfLocations = this.locations.length;
      }
    )
  }

	approveLocation(loc_id: number){
    var currUser = this.profileService.getCurrentUser();
    this.locationService.approveLocation(currUser, loc_id).subscribe(
      res => this.router.navigate(['/dashboard/user/' + currUser]), err => this.snackBar.open('Error occured, please try again', '', {
        duration: 5000
      })
    );
	}

	denyLocation(loc_id: number){
    var currUser = this.profileService.getCurrentUser();
    this.locationService.denyLocation(loc_id).subscribe(
      res => this.router.navigate(['/dashboard/user/' + currUser]), err => this.snackBar.open('Error occured, please try again', '', {
        duration: 5000
      })
    );
	}

}
