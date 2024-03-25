
//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit

protocol RMOperationProtocol1 {
    var priority: DispatchQoS.QoSClass { get set }
    var completionBlock: (() -> Void)? { get set }
    var isExecuting: Bool { get }
    var isFinished: Bool { get }
    func start()
}

class RMOperation1: RMOperationProtocol1 {
    var priority: DispatchQoS.QoSClass = .background
    var completionBlock: (() -> Void)?
    private var _isExecuting: Bool = false
    private var _isFinished: Bool = false
    
    var isExecuting: Bool {
        return _isExecuting
    }
    
    var isFinished: Bool {
        return _isFinished
    }

    func start() {
            guard !isExecuting && !isFinished else { return }
            
            _isExecuting = true
        DispatchQueue.main.async {
                   self.completionBlock?()
                   self._isExecuting = false
                   self._isFinished = true
            }
        }
    }
    
protocol RMOperationQueueProtocol {
    var operations: [RMOperation1] { get set }
    func addOperation(_ operation: RMOperation1)
}

final class RMOperationQueue1: RMOperationQueueProtocol {
    var operations: [RMOperation1] = []
    
    func addOperation(_ operation: RMOperation1) {
            operations.append(operation)
            if !operation.isExecuting && !operation.isFinished {
                operation.start()
            }
        }
    }

class ViewController12: UIViewController {

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
        
        let rmOperationQueue = RMOperationQueue1()
        
        let rmOperation1 = RMOperation1()
        rmOperation1.priority = .background
        rmOperation1.completionBlock = {
            print(1)
        }
        
        let rmOperation2 = RMOperation1()
        rmOperation2.priority = .userInteractive
        rmOperation2.completionBlock = {
            print(2)
        }
        
        rmOperationQueue.addOperation(rmOperation1)
        rmOperationQueue.addOperation(rmOperation2)
    }
    
    @objc func buttonPressed() {
        let nextViewController = ViewController13()
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
