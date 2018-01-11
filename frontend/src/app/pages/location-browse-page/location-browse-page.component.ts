import { Component, Input, OnInit } from '@angular/core';

import { LocationService } from '../../_services/location.service';

import { Location } from '../../_models/location';

import { LocationBrowserComponent } from '../../components/location-browser/location-browser.component';

@Component({
  selector: 'app-location-browse-page',
  templateUrl: './location-browse-page.component.html',
  styleUrls: ['./location-browse-page.component.scss']
})

export class LocationBrowsePageComponent implements OnInit {

	loadPage: boolean = true;
  locations: Location[];

	constructor(
    private locationService: LocationService
  ) {
	}

	ngOnInit() {
    this.getApprovedLocations();
	}

  getApprovedLocations() {
    this.locationService.getApprovedLocations().subscribe(
      locations => {
        this.locations = locations;
      }
    );
  }

}
