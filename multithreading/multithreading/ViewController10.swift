//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit

protocol RMOperationProtocol {
    // Приоритеты
    var priority: DispatchQoS.QoSClass { get }
    // Выполняемый блок
    var completionBlock: (() -> Void)? { get }
    // Завершена ли операция
    var isFinished: Bool { get }
    // Метод для запуска операции
    func start()
}

final class RMOperation: RMOperationProtocol {
    
    var priority: DispatchQoS.QoSClass = .background
        var completionBlock: (() -> Void)?
        var isFinished: Bool = false
    
    func start() {
           DispatchQueue.global(qos: priority).async {
               self.completionBlock?()
               self.isFinished = true
           }
       }
   }

    
class ViewController10: UIViewController {


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
        label.text = "Давайте напишем свой аналог Operation чтобы лучше понять его реализуйте операцию по протоколу RMOperationProtocol. Реализуйте так чтобы код ViewDidLoad работал как положено. Как закончите для сравнения замените RMOperation на Operation из swift"
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
        
        let operationFirst = RMOperation()
        let operationSecond = RMOperation()
        
        operationFirst.priority = .userInitiated
               operationFirst.completionBlock = {
                   
                   for _ in 0..<50 {
                       print(2)
                   }
                   print(Thread.current)
                   print("Операция полностью завершена!")
               }
              
               operationFirst.start()
               

               
               operationSecond.priority = .background
               operationSecond.completionBlock = {
                 
                   for _ in 0..<50 {
                       print(1)
                   }
                   print(Thread.current)
                   print("Операция полностью завершена!")
               }
               operationSecond.start()
    }
    
    @objc func buttonPressed() {
        let nextViewController = ViewController11()
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
