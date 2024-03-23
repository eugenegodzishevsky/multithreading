//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit

final class ViewController: UIViewController {
    
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
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 20
        return label
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let phrasesService = PhrasesService()
        let semaphore = DispatchSemaphore(value: 1)
        
        for i in 0..<10 {
            DispatchQueue.global(qos: .utility).async {
                semaphore.wait()
                phrasesService.addPhrase("Phrase \(i)")
                semaphore.signal()
            }
        }
        DispatchQueue.main.async {
            print(phrasesService.phrases)
        }
    }
    
    class PhrasesService {
        var phrases: [String] = []
        
        func addPhrase(_ phrase: String) {
            phrases.append(phrase)            
        }
    }
    
    @objc func buttonPressed() {
        let nextViewController = ViewController2()
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


