import { Injectable } from '@angular/core';
import { Router, CanActivate } from '@angular/router';

import { KJUR } from 'jsrsasign';

@Injectable()
export class LoginGuard implements CanActivate {

  constructor(private router: Router) { }

  canActivate() {
    var jwt = localStorage.getItem('auth');
    if (jwt) {
      var isValid = KJUR.jws.JWS.verify(jwt, {utf8: "secret"}, ["HS256"]);

      if(isValid) {
        this.router.navigate(['/dashboard']);
        return true;
      }
    }

    // Not logged in so it's fine to stay on the login/registration page
    return true;
  }
}
