//
//  Task 2_2_4.swift
//  multithreading
//
//  Created by Vermut xxx on 20.03.2024.
//

import UIKit

final class Task_2_2_4: UIViewController {
    
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
        label.text = "Объяснить почему вывелся именно такой порядок в консоле"
        label.textAlignment = .center
        label.backgroundColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 20
        return label
    }()
    
    private var name = "Введите имя"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        updateName()
    }
    
    func updateName() {
            DispatchQueue.global().async {
                self.name = "I love RM" // Перезаписываем имя в другом потоке
                print(Thread.current)
                print(self.name)
            }
            
            print(self.name) // Считываем имя из main
        }
// 1 первой выполняется задача в главном потоке, поэтому мы видим вывод "введите имя", она не дожидается выполнения.
// После этого в глобальной очереди имя меняется и выводится в консоль.
// 2 Сначала name изменяется на "I love RM" внутри синхронно выполняемого блока на глобальной очереди. Выводится информация о текущем глобальном потоке. печатается "I love RM". Возвращаемся в главный поток и печатаем "I love RM"

    
    
    @objc func buttonPressed() {
        let nextViewController = Task_2_2_5()
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
