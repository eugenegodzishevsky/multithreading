//
//  Task2_2_5.swift
//  multithreading
//
//  Created by Vermut xxx on 20.03.2024.
//

import UIKit

final class Task_2_2_5: UIViewController {
    
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
        label.text = "Объяснить почему вывелся именно такой порядок в консоле"
        label.textAlignment = .center
        label.backgroundColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 20
        return label
    }()
    
    private var name = "Введите имя"
    private let lockQueue = DispatchQueue(label: "name.lock.queue") // Добавлена очередь для блокировки

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        updateName()
    }
    
    func updateName() {
        DispatchQueue.global().async {
            self.lockQueue.sync { // Блокировка для безопасного обновления `name`
                self.name = "I love RM" // Перезаписываем имя в другом потоке
            }
            DispatchQueue.main.async { // Гарантируем, что вывод в консоль происходит в главном потоке
                print(Thread.current)
                print(self.name)
            }
        }
        
        lockQueue.sync { // Блокировка для безопасного чтения `name`
            print(self.name) // Считываем имя из main
        }
    }
// 

    
    
    @objc func buttonPressed() {
        let nextViewController = Task_2_2_6()
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

