//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit



final class ViewController6: UIViewController {
    
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
        label.text = "Написать как называется проблема №3 в коде и решить ее"
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
        
        let queue = DispatchQueue(label: "queue", attributes: .concurrent)
        
        let people1 = People1()
        let people2 = People2()
        
        let dispatchWorkItem = DispatchWorkItem {
        let thread1 = Thread {
            people1.walkPast(with: people2)
        }
            
            people2.isDifferentDirections = true
            thread1.start()
        }
        
        dispatchWorkItem.notify(queue: .main, execute: {
            let thread2 = Thread {
                people2.walkPast(with: people1)
            }
            
            people1.isDifferentDirections = true
            thread2.start()
        })
        
        queue.sync(execute: dispatchWorkItem)
    }
    


class People1 {
    var isDifferentDirections = false;
    
    func walkPast(with people: People2) {
        while (!people.isDifferentDirections) {
            print("People1 не может обойти People2")
            sleep(1)
        }
        
        print("People1 смог пройти прямо")
        isDifferentDirections = true
    }
}

class People2 {
    var isDifferentDirections = false;
    
    func walkPast(with people: People1) {
        while (!people.isDifferentDirections) {
            print("People2 не может обойти People1")
            sleep(1)
        }
        
        print("People2 смог пройти прямо")
        isDifferentDirections = true
    }
}


@objc func buttonPressed() {
    let nextViewController = ViewController7()
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


