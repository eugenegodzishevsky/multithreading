
//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit

// Объявляем класс для для синхронизации потоков
class ThreadSafeArray1 {
    private var array: [String] = []

    private let lock = NSLock()

    func append(_ item: String) {
            lock.lock()
            defer { lock.unlock() }
            array.append(item)
        }

        func getAll() -> [String] {
            lock.lock()
            defer { lock.unlock() }
            return array
        }
    }

// Определяем первую операцию для добавления строки в массив
class FirstOperation1: Operation {
    let threadSafeArray: ThreadSafeArray

    init(threadSafeArray: ThreadSafeArray) {
        self.threadSafeArray = threadSafeArray
    }

    override func main() {
        if isCancelled { return }
        threadSafeArray.append("Первая операция")
    }
}

// Определяем вторую операцию для добавления строки в массив
class SecondOperation1: Operation {
    let threadSafeArray: ThreadSafeArray

        init(threadSafeArray: ThreadSafeArray) {
            self.threadSafeArray = threadSafeArray
        }

        override func main() {
            if isCancelled { return }
            threadSafeArray.append("Вторая операция")
        }
}
    
class ViewController15: UIViewController {


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
        label.text = "Находим проблему пишем как называется такая проблема. Фиксик сначала одним способом который вы уже знаете, потом вторым на ваше усмотрение"
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
        // Использование
        let threadSafeArray = ThreadSafeArray()
        let operationQueue = OperationQueue()
        
        let firstOperation = FirstOperation(threadSafeArray: threadSafeArray)
        let secondOperation = SecondOperation(threadSafeArray: threadSafeArray)
        
        operationQueue.addOperation(firstOperation)
        operationQueue.addOperation(secondOperation)
        
        // Дождитесь завершения операций перед выводом содержимого массива
        operationQueue.waitUntilAllOperationsAreFinished()
        
        print(threadSafeArray.getAll())
    }
    
    @objc func buttonPressed() {
//        let nextViewController = ViewController12()
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
