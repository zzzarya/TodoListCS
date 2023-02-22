//
//  ToDoListModels.swift
//  TodoListCS
//
//  Created by Антон Заричный on 22.02.2023.
//

import Foundation

enum ToDoListModels {
	struct Request {
		struct RegularTask {
			let name: String
			let isDone: Bool
		}
		
		struct ImportantTask {
			let name: String
			let isDone: Bool
			let deadLine: Date?
			let priority: String
		}
		
		enum RequestTask {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		
		let requestTasks: [RequestTask]
	}
	
	struct Response {
		struct RegularTask {
			let name: String
			let isDone: Bool
		}
		
		struct ImportantTask {
			let name: String
			let isDone: Bool
			let deadLine: Date?
			let priority: String
		}
		
		enum ResponseTask {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		
		struct Section {
			let title: String
			let tasks: [ResponseTask]
		}
		
		let responseTasksBySection: [Section]
	}
	
	struct ViewModel {
		struct RegularTask {
			let name: String
			let isDone: Bool
		}
		
		struct ImportantTask {
			let name: String
			let isDone: Bool
			let isOverdue: Bool
			let deadLine: String
			let priority: String
		}
		
		enum Task {
			case regularTask(RegularTask)
			case importantTask(ImportantTask)
		}
		
		struct Section {
			let title: String
			let tasks: [Task]
		}
		
		let tasksBySections: [Section]
	}
}
