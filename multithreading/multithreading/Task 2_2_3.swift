//
//  Task 2_2_3.swift
//  multithreading
//
//  Created by Vermut xxx on 20.03.2024.
//

import UIKit

class ThreadPrintDemon3: Thread {
    override func main() {
        for _ in (0..<100) {
            print("1")
        }
    }
}

class ThreadPrintAngel3: Thread {
    override func main() {
        for _ in (0..<100) {
            print("2")
        }
    }
}

final class Task_2_2_3: UIViewController {
    
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
        label.text = "Выставить правильные приоритеты, чтобы печаталось вперемешку"
        label.textAlignment = .center
        label.backgroundColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 20
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //Создаем и запускаем поток
        let thread1 = ThreadPrintDemon()
        let thread2 = ThreadPrintAngel()
        
        //меняем приоритеты
        thread1.qualityOfService = .default
        thread2.qualityOfService = .default
        
        thread1.start()
        thread2.start()
     
    }
    
    @objc func buttonPressed() {
        let nextViewController = Task_2_2_4()
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

