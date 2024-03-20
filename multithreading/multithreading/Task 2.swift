//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit

class InfinityLoop: Thread {
    var counter = 0
    
    override func main() {
        while counter < 30 && !isCancelled {
            counter += 1
            print(counter)
            InfinityLoop.sleep(forTimeInterval: 1)
        }
    }
}

final class Task_2: UIViewController {
    
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
        label.text = "Отменяем задачу, когда цикл While досчитает до 5"
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
        
       // Создаем и запускаем поток
        let infinityThread = InfinityLoop()
        infinityThread.start()
        
        // Подождем некоторое время, а затем отменяем выполнение потока
        sleep(2)
        print(infinityThread.isExecuting)
        // Отменяем тут
        while infinityThread.counter < 5 && infinityThread.isExecuting {
            sleep(1)
        }
        
        if infinityThread.counter >= 5 && infinityThread.isExecuting {
            infinityThread.cancel()
        }
        print(infinityThread.isFinished)
    }
    
    @objc func buttonPressed() {
        let nextViewController = Task_2_2()
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


