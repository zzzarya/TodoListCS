//
//  ToDoListPresenter.swift
//  TodoListCS
//
//  Created by Антон Заричный on 22.02.2023.
//

import Foundation

protocol IToDoListPresenter {
	func present(response: ToDoListModels.Response)
}

class ToDoListPresenter: IToDoListPresenter {
	weak var viewController: IToDoListViewController?
	
	init(viewController: IToDoListViewController?) {
		self.viewController = viewController
	}
	
	func present(response: ToDoListModels.Response) {
		viewController?.render(viewModel: mapViewModel(response: response))
	}
	
	private func mapViewModel(response: ToDoListModels.Response) -> ToDoListModels.ViewModel {
		var sections = [ToDoListModels.ViewModel.Section]()
		let responceSections = response.responseTasksBySection
		for responceSection in responceSections {
				let sectionData = ToDoListModels.ViewModel.Section(
					title: responceSection.title,
					tasks: mapDataTask(tasks: responceSection.tasks))
				
				sections.append(sectionData)
			
		}
		
		return ToDoListModels.ViewModel(tasksBySections: sections)
	}
	
	private func mapDataTask(tasks: [ToDoListModels.Response.ResponseTask]) -> [ToDoListModels.ViewModel.Task] {
		tasks.map{ mapDataTask(task: $0) }
	}
	
	private func mapDataTask(task: ToDoListModels.Response.ResponseTask) -> ToDoListModels.ViewModel.Task {
			switch task {
			case .regularTask(let regularTask):
				let result = ToDoListModels.ViewModel.RegularTask(
					name: regularTask.name,
					isDone: regularTask.isDone)
				return .regularTask(result)
			case .importantTask(let importantTask):
				let result = ToDoListModels.ViewModel.ImportantTask(
					name: importantTask.name,
					isDone: importantTask.isDone,
					isOverdue: Date().isOverdue(importantTask.deadLine),
					deadLine: formatDeadline(with: importantTask.deadLine),
					priority: importantTask.priority)
				return .importantTask(result)
			}
	}
	
	private func formatDeadline(with deadline: Date?) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		dateFormatter.timeStyle = .none
		dateFormatter.locale = Locale(identifier: "ru_RU")
		
		return dateFormatter.string(from: deadline ?? Date())
	}
}
