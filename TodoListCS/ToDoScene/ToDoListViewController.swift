//
//  ToDoListViewController.swift
//  TodoListCS
//
//  Created by Антон Заричный on 22.02.2023.
//

import UIKit

protocol IToDoListViewController: AnyObject {
	func render(viewModel: ToDoListModels.ViewModel)
}

protocol IToDoListViewControllerDelegate: AnyObject {
	func buttonPressed(at indexPath: IndexPath)
}

class ToDoListViewController: UITableViewController {
	var router: (NSObjectProtocol & LoginRoutingLogic)?
	private var interactor: IToDoListInteractor?
	private var viewModel = ToDoListModels.ViewModel(tasksBySections: [])
	
	override func viewDidLoad() {
		super.viewDidLoad()
		assembly()
		interactor?.viewIsReady()
	}
	
	private func assembly() {
		let taskManager = SortedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = MockTasks()
		taskManager.addTasks(tasks: repository.getTasks())
		let presenter = ToDoListPresenter(viewController: self)
		let worker = ToDoListWorker(sectionForTaskManager: SectionForTaskManagerAdapter(taskManager: taskManager))
		interactor = ToDoListInteractor(presenter: presenter, worker: worker)
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.tasksBySections.count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewModel.tasksBySections[section].title
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.tasksBySections[section].tasks.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
		cell.delegate = self
		
		let tasks = viewModel.tasksBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		
		cell.configure(with: taskData, cellIndex: indexPath.row, indexPath: indexPath)
	
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		// interactor?.didTaskSelected(at: indexPath)
	}
}

extension ToDoListViewController: IToDoListViewController {
	func render(viewModel: ToDoListModels.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}

extension ToDoListViewController: IToDoListViewControllerDelegate {
	func buttonPressed(at indexPath: IndexPath) {
		interactor?.didTaskSelected(at: indexPath)
	}
}

