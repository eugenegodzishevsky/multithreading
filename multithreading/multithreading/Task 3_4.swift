//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit

final class ViewController8: UIViewController {
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("next", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let taskLabel: UILabel = {
        let label = UILabel()
        label.text = "Сервис добавляет 10 элементов в массив сервиса. задача удалять последний workItem чтобы в массив попадали все элементы с 1...9 кроме 10го"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 20
        return label
    }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
        setupUI()
        
        let service = ArrayAdditionService()
        for i in 1...10 {
            service.addElement(i)
        }
        service.cancelAddition()
    }
    
    // Класс, представляющий сервис операций добавления в массив
    class ArrayAdditionService {
        private var array = [Int]()
        private var pendingWorkItems = [DispatchWorkItem]()
        
        // Метод для добавления элемента в массив
        func addElement(_ element: Int) {
            // Создаем новую операцию для добавления элемента в массив
            let newWorkItem = DispatchWorkItem { [weak self] in
                self?.array.append(element)
                print("Элемент \(element) успешно добавлен в массив")
            }
            
            DispatchQueue.main.async(execute: newWorkItem)
            
            // Сохраняем новую операцию
            pendingWorkItems.append(newWorkItem)
            
            // Даем пользователю время для отмены операции
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                
                // Логика тут eсли операция не была отменена, выполняем ее
                self.pendingWorkItems.removeLast()
            }
        }
        
        // Метод для отмены операции добавления элемента в массив
        func cancelAddition() {
            guard let lastWorkItem = pendingWorkItems.last else {
                print("Нет операций для отмены.")
                return
            }
            
            // Тут отменяем последнюю операцию
            lastWorkItem.cancel()
        }
    }
    
    @objc func buttonPressed() {
        let nextViewController = ViewController9()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    private func setupUI() {
        nextButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        view.addSubview(nextButton)
        view.addSubview(taskLabel)
        
        taskLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        taskLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        taskLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        taskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        nextButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
