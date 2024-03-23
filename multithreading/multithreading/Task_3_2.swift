//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit



final class ViewController3: UIViewController {
    
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
        label.text = "Исправить AsyncWorker так чтобы комплишн возвращал сразу 5 постов"
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
        
            let asyncWorker = AsyncWorker()
          
            asyncWorker.doJobs(postNumbers: 1, 2, 3, 4, 5) { posts in
                print(Thread.current)
                print(posts.map { $0.id })
            }
      }


    class AsyncWorker {
        func doJobs(postNumbers: Int..., completion: @escaping ([Post]) -> Void) {
            var posts = [Post]()
            let group = DispatchGroup()
            
            for i in postNumbers {
                group.enter()
                URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos/\(i)")!)) { data, response, error in
                    guard let data = data else {
                        return
                    }

                    
                    if let post = try? JSONDecoder().decode(Post.self, from: data) {
                        posts.append(post)
                        group.leave()
                    }
                }
                .resume()
            }
            
            group.notify(queue: .main) {
                completion(posts)
            }
        }
    }

    struct Post: Codable {
        var userId: Int
        var id: Int
        var title: String
        var completed: Bool
    }
    
    @objc func buttonPressed() {
        let nextViewController = ViewController4()
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


