
import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOUtlets
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    //MARK: Varibles
    var number: Int = 0
    var round: Int = 0
    var points: Int = 0
    var gamesCount: Int = 0
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: Numbers
    var textOnLabel = ["50 - 10", "20 + 10", "10 + 5", "30 - 20", "15 + 10", "22 + 22"]
    var numbersFromLabel = [40, 30, 15, 10, 25, 44]
    @IBAction func checkNumber() {
        //если игра начинается
        if self.round == 0 {
            //берем 1 раунд массива цифр
            self.number = numbersFromLabel[round]
            //берем 1 раунд массива лэйбла
            self.label.text = textOnLabel[round]
            self.round = 1
        } else {
            //получаем значение на слайдере
            let numSlider = Int(self.slider.value.rounded())
            //сравниваем значение с загаданным и подсчитываем очки
            if numSlider > self.number {
                self.points += 50 - numSlider + self.number
            } else if numSlider < self.number {
                self.points += 50 - self.number
            } else {
                self.points += 50
            }
            if self.round == 5 {
                let alert = UIAlertController(title: "Game Over",
                                              message: "You've earned \(points) points",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Start Again", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.round = 0
                self.points = 0
            } else {
                self.round += 1
            }
            self.number = numbersFromLabel[round]
            //берем 1 раунд массива лэйбла
            self.label.text = textOnLabel[round]
            
        }
      
    }
}
