//
//  LoginPresenter.swift
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

protocol ILoginPresenter {
  func present(response: LoginModels.Response)
}

class LoginPresenter: ILoginPresenter {
  weak var viewController: ILoginViewController?
	
	init(viewController: ILoginViewController?) {
		self.viewController = viewController
	}
  
	func present(response: LoginModels.Response) {
		let viewModel = LoginModels.ViewModel(
			succes: response.succes,
			login: response.login,
			lastLoginDate: "\(response.lastLoginDate)"
		)
		viewController?.render(viewModel: viewModel)
	}
}
