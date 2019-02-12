import * as _ from 'lodash';

import { Injectable } from '@angular/core';
import { AjaxService } from './ajax.service';
import * as Consts from '../constants';

type TgetFunction = (params: {[key: string]: any}, successFunc: (data: any) => void, errFunc: (err: any) => void) => void;
type TpostFunction = (params: any, successFunc: (data: any) => void, errFunc: (err: any) => void) => void;

@Injectable()
export class DataService {
	private static intsance: DataService;

	/* API declarations */
	getUsers: TgetFunction;

	updateUsers: TpostFunction;

	constructor(private ajaxService: AjaxService) {

        //get example
		this.getUsers = this.ajaxGet('getUsers', '/users');
        //post example
		this.updateUsers = this.ajaxPost('updateUsers', '/users/update');
	}

///////////////////////////// private methods /////////////////////////

	/*
	 * Return a function that will call the given API if result is not already in cache
	 * Cache key is created from the name of the calling function and a concatenation
	 * of all of the parameters.
	 */
	private ajaxGet(callName: string, url: string) {
		// return this.mockAjax(callName, url);
		return (params: {[key: string]: any}, successFunc: (data: any) => void, errFunc: (err: any) => void) => {
			this.ajaxService.get(url, params,
				(res: any) => {
					const ret = JSON.parse(res['_body']);
					successFunc(ret);
				}, (err) => {
					errFunc(err);
				});
		};
	}

	private ajaxPost(callName: string, url: string) {
		return (params: any, successFunc: (data: any) => void, errFunc: (err: any) => void) => {
			this.ajaxService.post(url, params,
				(res: any) => {
					const ret = JSON.parse(res['_body']);
					successFunc(ret);
				}, (err) => {
					errFunc(err);
				});
		};
	}

	private mockAjax(callName: string, url: string) {
		return (params: {[key: string]: any}, successFunc: (data: any) => void) => {
			successFunc('This is a mock response');
		};
	}
}