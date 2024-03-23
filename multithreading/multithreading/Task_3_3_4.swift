//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit



final class ViewController7: UIViewController {
    
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
        label.text = "Написать как называется проблема №4 в коде и решить ее"
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
        
        DispatchQueue.global().async {
                    self.thread1()
                }

                DispatchQueue.global().async {
                    self.thread2()
                }
            }
    // "Livelock" потоки должны захватывать ресурсы в одном и том же порядке, чтобы избежать "livelock"
    func thread1() {
            print("Поток 1 пытается захватить Ресурс A")
            resourceASemaphore.wait() // Захват Ресурса A
            
            print("Поток 1 захватил Ресурс A и пытается захватить Ресурс B")
            
            resourceBSemaphore.wait() // Попытка захвата Ресурса B, который уже занят Потоком 2
            print("Поток 1 захватил Ресурс B")
        
            Thread.sleep(forTimeInterval: 1) // Имитация работы для демонстрации livelock

            
            resourceBSemaphore.signal()
            resourceASemaphore.signal()
        }

        func thread2() {
            print("Поток 2 пытается захватить Ресурс B")
            resourceASemaphore.wait() // Попытка захвата Ресурса A, который уже занят Потоком 1
            
            print("Поток 2 захватил Ресурс B и пытается захватить Ресурс A")
//            Thread.sleep(forTimeInterval: 1) // Имитация работы для демонстрации livelock
            
            resourceBSemaphore.wait() // Захват Ресурса B
            print("Поток 2 захватил Ресурс A")
            
            resourceASemaphore.signal()
            resourceBSemaphore.signal()
        }

    
    let resourceASemaphore = DispatchSemaphore(value: 1)
    let resourceBSemaphore = DispatchSemaphore(value: 1)
    
    @objc func buttonPressed() {
        let nextViewController = ViewController8()
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
