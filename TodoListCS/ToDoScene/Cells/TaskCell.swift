//
//  taskCell.swift
//  TodoListCS
//
//  Created by Антон Заричный on 22.02.2023.
//

import UIKit

/// Класс TaskCell
final class TaskCell: UITableViewCell {
	/// Делегат ToDoListViewController
	weak var delegate: IToDoListViewControllerDelegate?
	/// Task
	var task: ToDoListModels.ViewModel.Task!
	
	var indexPath: IndexPath!
	/// Конфигурация ячейки
	func configure(with task: ToDoListModels.ViewModel.Task, cellIndex: Int, indexPath: IndexPath) {
		self.indexPath = indexPath
		self.task = task
		/// Контент для настройки ячейки
		var content = defaultContentConfiguration()
		
		switch task {
		case .regularTask(let cellTask):
			content.text = cellTask.name
		case .importantTask(let cellTask):
			let redText = [NSAttributedString.Key.foregroundColor:  UIColor.red]
			let taskText = NSMutableAttributedString(string: cellTask.priority + " ", attributes: redText)
			taskText.append(NSAttributedString(string: cellTask.name))
			content.attributedText = taskText
			
			content.secondaryText = cellTask.deadLine
			content.secondaryTextProperties.color = cellTask.isOverdue ? .red : .black
		}
		
		contentConfiguration = content
		/// Кнопка для ячейки
		let checkButton = UIButton(type: .custom)
		checkButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
		
		switch task {
		case .regularTask(let cellTask):
			checkButton.setImage(UIImage(systemName: cellTask.isDone ? "checkmark.square" : "square"), for: .normal)
		case .importantTask(let cellTask):
			checkButton.setImage(UIImage(systemName: cellTask.isDone ? "checkmark.square" : "square"), for: .normal)
		}
		checkButton.tag = cellIndex
		checkButton.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
		
		accessoryView = checkButton
	}
	
	@objc private func checkBoxPressed(_ sender: UIButton) {
		self.delegate?.buttonPressed(at: indexPath)
		switch task {
		case .regularTask(let cellTask):
			sender.setImage(UIImage(systemName: cellTask.isDone ? "checkmark.square" : "square"), for: .normal)
		case .importantTask(let cellTask):
			sender.setImage(UIImage(systemName: cellTask.isDone ? "checkmark.square" : "square"), for: .normal)
		case .none:
			break
		}
	}
}
