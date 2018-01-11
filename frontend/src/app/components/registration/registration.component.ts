import { Component, OnInit } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material';

import { AuthService } from '../../_services/auth.service';

import { User } from '../../_models/user';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.scss']
})
export class RegistrationComponent implements OnInit {

  tempUser: User = new User();
  pass: string;
  passConfirmation: string;

  constructor(
    private authService: AuthService,
    private router: Router,
    private snackBar: MatSnackBar
  ) { }

  ngOnInit() {
  }

  submit() {
    if(this.pass != this.passConfirmation) {
      this.snackBar.open('Passwords do not match, please try again', '', {
        duration: 5000
      });
      return;
    }

    this.authService.addUser(this.tempUser, this.pass).subscribe(
      res => {
        this.checkRegistration(res.status);
      },
      err => {
        this.snackBar.open('Registration failed, please try again', '', {
          duration: 5000
        });
      }
    );
  }

  checkRegistration(status) {
    if(status == 200) {
      localStorage.setItem('auth', this.authService.getJWT({user: this.tempUser.username}));
    } else {
      this.snackBar.open('Registration failed, please try again', '', {
        duration: 5000
      });
      return;
    }

    this.tempUser = new User();
    this.router.navigate(['/dashboard']);
  }
}
