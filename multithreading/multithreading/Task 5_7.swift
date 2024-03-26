
//
//  ViewController.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit
    
class Task_5_7: UIViewController {
    
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
        label.text = "Разберитесь как работает. ОТМените задачу fetchTask"
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
        
        Task {
            await getAverageTemperature()
        }
    }
    
    func getAverageTemperature() async {
                let fetchTask = Task { () -> Double in
                    let url = URL(string: "https://hws.dev/readings.json")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let readings = try JSONDecoder().decode([Double].self, from: data)
                    let sum = readings.reduce(0, +)
                    return sum / Double(readings.count)
                }
                
               // Тут отменить задачу
                fetchTask.cancel()

                do {
                    let result = try await fetchTask.value
                    print("Average temperature: \(result)")
                } catch {
                    print("Failed to get data.")
                }
            }
    

    @objc func buttonPressed() {
        let nextViewController = Task_5_8()
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
