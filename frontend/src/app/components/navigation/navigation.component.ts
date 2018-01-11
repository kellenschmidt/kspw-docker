import { Component, OnInit } from '@angular/core';
import { Router, RouterLink, NavigationEnd } from '@angular/router';
import { Page } from '../../_models/page';

import { AuthService } from '../../_services/auth.service';
import { ProfileService } from '../../_services/profile.service';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.scss']
})
export class NavigationComponent implements OnInit {
  pages: Page[];

  constructor(
    private authService: AuthService,
    private profileService: ProfileService,
    private router: Router
  ) {
    this.router.routeReuseStrategy.shouldReuseRoute = function(){
        return false;
     }

     this.router.events.subscribe((evt) => {
        if (evt instanceof NavigationEnd) {
           // trick the Router into believing it's last link wasn't previously loaded
           this.router.navigated = false;
           // if you need to scroll back to top, here is the right place
           window.scrollTo(0, 0);
        }
    });
  }

  ngOnInit() {
    var currentUser = this.profileService.getCurrentUser();
    this.pages = [
      {
        "name": "profile",
        "url": `user/${currentUser}`
      },
      {
        "name": "games",
        "url": "games"
      },
      {
        "name": "locations",
        "url": "locations"
      }
    ]
  }

  logout() {
    this.authService.logout();
  }

}
