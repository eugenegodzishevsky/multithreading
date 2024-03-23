
//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit
    
class ViewController13: UIViewController {
    
    // В предыдущем файле  операции выполняются последовательно, так как операции запускаются сразу после добавления в очередь.
    // В этом файле операции выполняются параллельно


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
        label.text = "Давайте теперь используя прошлую RMOperation еще и свою OperationQueue напишем для понимания. Теперь используйте в таком же примере Operation и OperationQueue от Swift и сравните"
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
        
        let operationQueue = OperationQueue()
               
               let operation1 = BlockOperation {
                   print(1)
               }
        operation1.queuePriority = .low
               
               let operation2 = BlockOperation {
                   print(2)
               }
               operation2.queuePriority = .high
               
               operationQueue.addOperations([operation1, operation2], waitUntilFinished: false)
    }
    
    @objc func buttonPressed() {
        let nextViewController = ViewController14()
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
