//
//  ToDoListInteractor.swift
//  TodoListCS
//
//  Created by Антон Заричный on 22.02.2023.
//

import Foundation

protocol IToDoListInteractor {
	func didTaskSelected(at indexPath: IndexPath)
	func viewIsReady() 
}

class ToDoListInteractor: IToDoListInteractor {
	var presenter: IToDoListPresenter?
	var worker: IToDoListWorker
	
	init(presenter: IToDoListPresenter, worker: IToDoListWorker) {
		self.presenter = presenter
		self.worker = worker
	}
	
	func viewIsReady() {
		presenter?.present(response: worker.getTasks())
	}
	
	func didTaskSelected(at indexPath: IndexPath) {
		worker.toggleTask(at: indexPath)
		presenter?.present(response: worker.getTasks())
	}
}
