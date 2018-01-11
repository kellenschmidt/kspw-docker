/* The authentication service includes registration and login routes. This also
includes jwt operations for user authentication, working in conjunction with
the authentication guard. */

import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpResponse, HttpErrorResponse } from '@angular/common/http';

import { Observable } from 'rxjs/Observable';
import { of } from 'rxjs/observable/of';
import { catchError, map, tap } from 'rxjs/operators';
import { KJUR } from 'jsrsasign';

import { environment } from '../../environments/environment';

import { User } from '../_models/user';
import { Comment } from '../_models/comment';

const headers =  new HttpHeaders({ 'Content-Type': 'application/json' });

@Injectable()
export class ProfileService {

  private apiUrl = environment.url;

  constructor(
    private http: HttpClient
  ) { }

  /** POST: create a comment */
  createComment (username: string, comment: string, type: string, target: any, rating: number): Observable<HttpResponse<any>> {
    const url = `${this.apiUrl}/newcomment`;
    return this.http.post<Response>(url,
      {
        username: username,
        Comment: comment,
        type: type,
        id: target,
        rating: rating
      },
      {observe: 'response'}).pipe(
      tap(res => console.log(`added comment from user=${username}`))
    );
  }

  /** GET: find a user */
  getUser (username: string): Observable<User> {
    const url = `${this.apiUrl}/profile/${username}`;
    console.log(url);
    return this.http.get<User>(url).pipe(
      tap(res => console.log(`found user w/ username=${username}`))
    );
  }

  // getUserComments (username: string): Observable<User> {
  //   const url = `${this.apiUrl}/profile/${username}`;
  //   console.log(url);
  //   return this.http.get<User>(url).pipe(
  //     tap(res => console.log(`found user w/ username=${username}`))
  //   );
  // }

  /** TODO POST: change username or email */
  updateUser (username: string): Observable<User> {
    const url = `${this.apiUrl}/profile/${username}`;
    console.log(url);
    return this.http.get<User>(url).pipe(
      tap(res => console.log(`found user w/ username=${username}`))
    );
  }

  getComments(type: string, target: any): Observable<Comment[]> {
    const url = `${this.apiUrl}/${type}/${target}/comments`;
    console.log(url);
    return this.http.get<Comment[]>(url).pipe(
      tap(res => console.log(`found comments`))
    );
  }

  getCurrentUser(): string {
    var currentUser = KJUR.jws.JWS.parse(localStorage.getItem('auth')).payloadObj.user;
    return currentUser;
  }
}
