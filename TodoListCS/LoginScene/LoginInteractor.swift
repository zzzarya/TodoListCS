//
//  LoginInteractor.swift
//  TodoListCS
//
//  Created by Антон Заричный on 21.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ILoginInteractor {
	func login(request: LoginModels.Request)
}

protocol LoginDataStore {
	var login: String? { get set }
	var password: String? { get set }
}

class LoginInteractor: ILoginInteractor {
	var worker: ILoginWorker
	var presenter: ILoginPresenter?
	
	init(presenter: ILoginPresenter, worker: ILoginWorker) {
		self.presenter = presenter
		self.worker = worker
	}
	
	func login(request: LoginModels.Request) {
		let result = worker.login(login: request.login, password: request.password)
		
		let response = LoginModels.Response(
			succes: result.success == 1,
			login: result.login,
			lastLoginDate: result.lastLoginDate
		)
		presenter?.present(response: response)
	}
}