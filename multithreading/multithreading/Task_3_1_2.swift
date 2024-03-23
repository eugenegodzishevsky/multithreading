//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit

actor PhrasesService {
    
    let semaphore = DispatchSemaphore(value: 1)
    
    var phrases: [String] = []
    
    func addPhrase(_ phrase: String) async {
        semaphore.wait()
        phrases.append(phrase)
        semaphore.signal()
    }
}

final class ViewController2: UIViewController {
    
    let semaphore = DispatchSemaphore(value: 0)

    
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
        label.text = "Дан сервис, через который записываем фразы в массив, используя цикл"
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
        
        let phrasesService = PhrasesService()
        
        for i in 0..<10 {
                    DispatchQueue.global().async {
                        Task {
                            await phrasesService.addPhrase("Phrase \(i)")
                        }
                    }
                }
                
                Thread.sleep(forTimeInterval: 1)
                Task {
                    let phases = await phrasesService.phrases
                    print(phases)
                }
            }
    
    @objc func buttonPressed() {
        let nextViewController = ViewController3()
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


