//
//  ViewController.swift
//  TodoListCS
//
//  Created by Антон Заричный on 21.02.2023.
//

import UIKit

protocol ILoginViewController: AnyObject {
	func render(viewModel: LoginModels.ViewModel)
}

class LoginViewController: UIViewController {
	private var interactor: ILoginInteractor?
	var router: (NSObjectProtocol & LoginRoutingLogic)?
	
	@IBOutlet weak var loginTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBAction func loginButton(_ sender: Any) {
		if let login = loginTextField.text, let password = passwordTextField.text {
			let request = LoginModels.Request(login: login, password: password)
			interactor?.login(request: request)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		assembly()
	}
	
	private func assembly() {
		router = LoginRouter()
		let worker = LoginWorker()
		let presenter = LoginPresenter(viewController: self)
		interactor = LoginInteractor(presenter: presenter, worker: worker)
	}
	
	// MARK: Routing
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let scene = segue.identifier {
			let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
			if let router = router, router.responds(to: selector) {
				router.perform(selector, with: segue)
			}
		}
	}
}

extension LoginViewController: ILoginViewController {
	func render(viewModel: LoginModels.ViewModel) {
		let alert: UIAlertController
		
		if viewModel.succes {
			alert = UIAlertController(
				title: "Success",
				message: "Welcome, \(viewModel.login)",
				preferredStyle: UIAlertController.Style.alert
			)
		} else {
			alert = UIAlertController(
				title: "Failed",
				message: "Enter the correct login and password",
				preferredStyle: UIAlertController.Style.alert
			)
		}
		
		let action = UIAlertAction(title: "OK", style: .default)
		alert.addAction(action)
		
		if !viewModel.succes {
			present(alert, animated: true, completion: nil)
		}
	}
}

