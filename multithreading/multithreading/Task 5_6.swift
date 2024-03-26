
//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit

struct Message1: Decodable, Identifiable {
    let id: Int
    let from: String
    let message: String
}


class NetworkService1 {
    
    func fetchMessages(completion: @escaping ([Message]) -> Void) {
        let url = URL(string: "https://hws.dev/user-messages.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                    completion(messages)
                    return
                }
            }

            completion([])
        }
        .resume()
    }
}
    
class Task_5_6: UIViewController {

    var networkService = NetworkService()
    let error = NSError(domain: "Error", code: 404)
    
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
        label.text = "А теперь этот же метод обработать через withCheckedThrowingContinuation на случай, если messages.isEmpty"
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
        
        Task.init {
            let messages =  try await fetchMessagesResult()
            print(messages)
        }
    }
    
    func fetchMessagesResult(completion: @escaping ([Message]) -> Void) {
            networkService.fetchMessages { message in
                completion(message)
            }
        }
        
        @available(*, renamed: "fetchMessagesResult()")
    func fetchMessagesResult() async throws -> [Message] {
        return try await withCheckedThrowingContinuation { continuation in
            fetchMessagesResult() { messages in
                if messages.isEmpty {
                    continuation.resume(throwing: self.error)
                } else {
                    continuation.resume(returning: messages)
                }
            }
        }
    }
    

    @objc func buttonPressed() {
        let nextViewController = Task_5_7()
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
