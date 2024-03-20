//
//  Task 2_2_7.swift
//  multithreading
//
//  Created by Vermut xxx on 20.03.2024.
//

import UIKit

final class Task_2_2_7: UIViewController {
    
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
        label.text = "Написать какая тут проблема?"
        label.textAlignment = .center
        label.backgroundColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 20
        return label
    }()
    
    private var lock = NSLock()
    
    private lazy var name = "I love RM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateName()
    }
    
    func updateName() {
        DispatchQueue.global().async {
            self.lock.lock()
            defer { self.lock.unlock() }
            print(self.name) // Считываем имя из global
            print(Thread.current)
        }
        
        self.lock.lock()
        defer { self.lock.unlock() }
        print(self.name) // Считываем имя из main
    }
    
    // Доступ свойству name осуществляется из разных потоков без какой-либо синхронизации. Это может привести к состоянию гонки (race condition)
    //  Использование объекта NSLock позволяет создать критическую секцию, в которой только один поток может выполняться одновременно.
    
    @objc func buttonPressed() {
//        let nextViewController = Task_2_2_7()
//        navigationController?.pushViewController(nextViewController, animated: true)
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

