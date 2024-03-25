import UIKit

class ViewController: UIViewController {
     override func viewDidLoad() {
              super.viewDidLoad()
              print(2)
              DispatchQueue.main.async {
                      print(3)
                      DispatchQueue.main.async {
                            print(5)
                      }
               print(4)
             }
           print(6)
     }
}

let vc = ViewController()
print(1)
let view = vc.view
print(7)

// сначала выводится 1
// вызывается view поэтому вызывается viewDidLoad

// чтобы распечатались все принты меняем sync на async
