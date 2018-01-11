import { Injectable } from '@angular/core';
import { Router, CanActivate } from '@angular/router';

import { KJUR } from 'jsrsasign';

@Injectable()
export class AuthGuard implements CanActivate {

  constructor(private router: Router) { }

  canActivate() {
    var jwt = localStorage.getItem('auth');
    if (jwt) {
      var isValid = KJUR.jws.JWS.verify(jwt, {utf8: "secret"}, ["HS256"]);

      if(isValid) {
        return true;
      }
    }

    // Not logged in so redirect to login page
    this.router.navigate(['/login']);
    return false;
  }
}
