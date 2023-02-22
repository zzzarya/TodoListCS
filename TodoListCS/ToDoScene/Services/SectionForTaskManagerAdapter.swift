//
//  SectionForTaskManagerAdapter.swift
//  ToDoListMVC
//
//  Created by Антон Заричный on 17.02.2023.
//

/// Протокол ISectionForTaskManagerAdapter для класса SectionForTaskManagerAdapter
protocol ISectionForTaskManagerAdapter {
	func getSectionTitles() -> [String]
	func getTasksForSection(section: Section) -> [Task]
	func getSections() -> [Section]
	func getSection(forIndex index: Int) -> Section
}

enum Section: CaseIterable {
	case completed
	case uncompleted
	
	var title: String {
		switch self {
		case .completed:
			return "Completed"
		case .uncompleted:
			return "Uncompleted"
		}
	}
}
/// Класс SectionForTaskManagerAdapter
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	private let sections: [Section] = [.uncompleted, .completed]
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	/// Метод получения названий для секций
	func getSectionTitles() -> [String] {
		["Completed", "Uncompleted"]
	}
	
	func getSections() -> [Section] {
		sections
	}
	
	func getSection(forIndex index: Int) -> Section {
		let i = min(index, sections.count - 1)
		return sections[i]
	}
	/// Метод получения Tasks для секции
	func getTasksForSection(section: Section) -> [Task] {
		switch section {
		case .completed:
			return taskManager.doneTasks()
		case .uncompleted:
			return taskManager.undoneTasks()
		}
	}
}
