import { Injectable } from '@angular/core';
import { Http, Headers, Response, RequestOptions } from '@angular/http';
import { Router } from '@angular/router';

import * as Consts from '../constants';
import * as _ from 'lodash';

@Injectable()
export class AjaxService {

	private static remoteUrlInited = false;
	private static cachedRemoteUrl = '';

	private static intsance: AjaxService;

	static Instance(): AjaxService {
		return AjaxService.intsance;
	}

	static formatParams = (p: {[key: string]: any}): {[key: string]: any} => {
		const ret = {};
		_.forIn(p, (v: any, k: string) => {
			if (v instanceof Array) {
				ret[k] = _.reduce(v, (str: string, e: any) => str === '' ? `${e}` : `${str},${e}`, '');
			} else {
				ret[k] = v;
			}
		});
		return ret;
	}

	static getServerUrl() {
		return Consts.REMOTE_URL;
	}

	constructor(private http: Http, private router: Router) {
		if (!AjaxService.intsance) AjaxService.intsance = this;
	}

	private defaultOnError = (err: any) => {
		console.log(err);
		if (err.status === 401) {
			console.log('Got status 401, redirect to login page');
			this.router.navigate(['login']);
		} else if (err.status === 404) {
			console.log('Got status 404 - No route');
		} else if (err.status === 500) {
			console.log('Got status 500 - Server error');
		} else {
			alert('Server is not responding');
			console.error('HTTP request failed with error: ', err);
		}
	}

	/////////////////////// Public /////////////////////////////////////////
	get(partialUrl: string,
			params: {[key: string]: any} = {},
			onSuccess: (res: Response) => any,
			onError?: (err: any) => any ): void {

		const completeUrl = AjaxService.getServerUrl() + partialUrl;

		if (onSuccess === undefined || onSuccess === undefined) { throw new Error('Null onSuccess in get()'); }
		if (onError === undefined) { onError = this.defaultOnError; }

        const formattedParams = AjaxService.formatParams(params);
		this.http.get(completeUrl, {params: formattedParams})
			.subscribe(onSuccess, onError);
	}

	post(partialUrl: string,
			params: { [key: string]: any },
			onSuccess: (res: Response) => any,
			onError?: (err: any) => any): void {

		const completeUrl = AjaxService.getServerUrl() + partialUrl;

		if (onSuccess === undefined || onSuccess === undefined) { throw new Error('Null onSuccess in get()'); }
		if (onError === undefined) { onError = this.defaultOnError; }

		const headers = new Headers({ 'Content-Type': 'application/json' });
		const options = new RequestOptions({ headers: headers });

		this.http.post(completeUrl, params, options)
			.subscribe(onSuccess, onError);
	}
}
