import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpResponse, HttpErrorResponse } from '@angular/common/http';

import { Observable } from 'rxjs/Observable';
import { of } from 'rxjs/observable/of';
import { catchError, map, tap } from 'rxjs/operators';
import { KJUR } from 'jsrsasign';

import { environment } from '../../environments/environment';

import { Location } from '../_models/location';
import { Comment } from '../_models/comment';

const headers =  new HttpHeaders({ 'Content-Type': 'application/json' });

@Injectable()
export class LocationService {

  private apiUrl = environment.url;

  constructor(
    private http: HttpClient
  ) { }

  /** POST: request a new location */
  requestLoc (username: string, address: string, description: string, pic?: string): Observable<HttpResponse<any>> {
    const url = `${this.apiUrl}/new-location`;
    const body = pic ? {
      creator_username: username,
      address: address,
      descriptions: description,
      picture_url: pic
    } :
    {
      creator_username: username,
      address: address,
      descriptions: description
    };
    return this.http.post<Response>(url,
      body,
      {observe: 'response'}).pipe(
      tap(res => console.log(`added location w/ description=${description}`))
    );
  }

  /** GET: return array of all approved locations */
  getApprovedLocations (): Observable<Location[]> {
    const url = `${this.apiUrl}/approved-location`;
    return this.http.get<Location[]>(url).pipe(
      tap(res => console.log(`found games`))
    );
  }

  /** GET: return array of all approved locations */
  getUnapprovedLocations (): Observable<Location[]> {
    const url = `${this.apiUrl}/non-approved-location`;
    return this.http.get<Location[]>(url).pipe(
      tap(res => console.log(`found games`))
    );
  }

  /** GET: return specific location */
  getLocation (id: number): Observable<Location> {
    const url = `${this.apiUrl}/location/${id}`;
    return this.http.get<Location>(url).pipe(
      tap(res => console.log(`found location with id=${id}`))
    );
  }

  approveLocation(admin: string, loc: number): Observable<Location> {
    const url = `${this.apiUrl}/locapprove/${admin}/${loc}`;
    return this.http.get<Location>(url).pipe(
      tap(res => console.log(`found games`))
    );
  }

  denyLocation(loc: number): Observable<Location> {
    const url = `${this.apiUrl}/location-delete/${loc}`;
    return this.http.delete<Location>(url).pipe(
      tap(res => console.log(`found games`))
    );
  }
}
