//
//  ToDoListWorker.swift
//  TodoListCS
//
//  Created by Антон Заричный on 22.02.2023.
//

import Foundation

protocol IToDoListWorker {
	func getTasks() -> ToDoListModels.Response
	func toggleTask(at indexPath: IndexPath)
}

class ToDoListWorker: IToDoListWorker {
	private var sectionForTaskManager: ISectionForTaskManagerAdapter!
	
	init(sectionForTaskManager: ISectionForTaskManagerAdapter!) {
		self.sectionForTaskManager = sectionForTaskManager
	}
	
	func getTasks() -> ToDoListModels.Response {
		var sections = [ToDoListModels.Response.Section]()
		for section in sectionForTaskManager.getSections() {
			let sectionData = ToDoListModels.Response.Section(
				title: section.title,
				tasks: mapTaskData(tasks: sectionForTaskManager.getTasksForSection(section: section)))
			
			sections.append(sectionData)
		}
		return ToDoListModels.Response(responseTasksBySection: sections)
	}
	
	func toggleTask(at indexPath: IndexPath) {
		let section = sectionForTaskManager.getSection(forIndex: indexPath.section)
		let task = sectionForTaskManager.getTasksForSection(section: section)[indexPath.row]
		task.isCompleted.toggle()
	}
	
	private func mapTaskData(tasks: [Task]) -> [ToDoListModels.Response.ResponseTask] {
		tasks.map{ mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> ToDoListModels.Response.ResponseTask {
		if let task = task as? ImportantTask {
			let result = ToDoListModels.Response.ImportantTask(
				name: task.title,
				isDone: task.isCompleted,
				deadLine: task.deadline,
				priority: "\(task.priority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(ToDoListModels.Response.RegularTask(
				name: task.title,
				isDone: task.isCompleted)
			)
		}
	}
	
}
