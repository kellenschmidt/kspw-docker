import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { Location } from '../../_models/location';

@Component({
  selector: 'location-browser',
  templateUrl: './location-browser.component.html',
  styleUrls: ['./location-browser.component.scss']
})

export class LocationBrowserComponent implements OnInit {

  @Input() locations: Location[];

	constructor(
    private router: Router
  ) {
	}

	ngOnInit() {
	}

  openSubmitLocationPage() {
    this.router.navigate(['/dashboard/locationSubmit']);
  }

  goToLocation(id: number) {
    this.router.navigate([`/dashboard/location/${id}`]);
  }

}
