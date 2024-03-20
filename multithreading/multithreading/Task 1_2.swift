//
//  Task 1_2.swift
//  multithreading
//
//  Created by Vermut xxx on 19.03.2024.
//

import UIKit

final class Task_1_2: UIViewController {
    
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
        label.text = "Создать второй поток на базе Threads, создать таймер так, чтобы он заработал"
        label.textAlignment = .center
        label.backgroundColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 20
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Создаем и запускаем поток с таймером
        let timer = TimerThread(duration: 10)
        timer.start()
        
        
    }
    
    @objc func buttonPressed() {
        let nextViewController = Task_2()
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

    
    
    class TimerThread: Thread {
        private var timerDuration: Int
        private var timer: Timer!
        
        init(duration: Int) {
            self.timerDuration = duration
        }
        
        override func main() {
            // Создаем таймер, который будет выполняться каждую секунду
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            print(Thread.current)
            
            // Добавляем таймер в текущий run loop ниже
            RunLoop.current.add(timer, forMode: .default)
            
            // Запускаем текущий run loop ниже
            RunLoop.current.run()
            
        }
        
        @objc func updateTimer() {
            // Ваш код здесь будет выполняться каждую секунду
            if timerDuration > 0 {
                print("Осталось \(timerDuration) секунд...")
                timerDuration -= 1
            } else {
                print("Время истекло!")
                
                timer.invalidate()
                // Остановка текущего run loop после завершения таймера
                CFRunLoopStop(CFRunLoopGetCurrent())
            }
        }
    }
}
