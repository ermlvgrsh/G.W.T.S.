
import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOUtlets
    var slider: UISlider?
    var label: UILabel?
    var button: UIButton?
    var infoButton: UIButton?
    
    //MARK: Varibles
    var game: Game?
    
    override func loadView() {
         super.loadView()
        gameBuild()
        let versionLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 100, height: 100))
        versionLabel.text = "Version 1.1"
        self.view.addSubview(versionLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //создаем экземпляр сущности
        game = Game(startValue: 1, endValue: 50, rounds: 5)
 
    }

    
    
    private func createSlider() {
        let slider = UISlider()
        
        self.slider = slider
        
        slider.maximumValue = 50
        slider.minimumValue = 1
        slider.value = 1
        let index = slider.value + 1
        
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        
        UIView.animate(withDuration: 1) {
            slider.setValue(index, animated: false)
        }
        
        slider.minimumValueImage?.withTintColor(.purple)
        slider.maximumValueImage?.withTintColor(.yellow)
        
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.widthAnchor.constraint(equalToConstant: 500).isActive = true
        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        slider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        
        print("Slider value changed")
        
        // Use this code below only if you want UISlider to snap to values step by step
        guard let slider = slider else { return }
        print("Slider step value \(Int(slider.value)) ")
    }
    
    private func createLabel() {
        let label = UILabel()
        self.label = label
        //label.text = "\(textOnLabel[round])"
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 27, weight: .bold)
        
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        
    }
    
    private func createInfoButton() {
        var infoButton = UIButton(type: .system)
        self.infoButton = infoButton
        infoButton.tintColor = .white
        infoButton.backgroundColor = .black
        infoButton.layer.masksToBounds = true
        infoButton.layer.cornerRadius = 20
        
        let attributeTitle: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17)
        ]
        let attributedTitleString = NSAttributedString(string: "About Creators", attributes: attributeTitle)
        infoButton.setAttributedTitle(attributedTitleString, for: .normal)
        
        infoButton.addTarget(self, action: #selector(showInfoView), for: .touchUpInside)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoButton)
        NSLayoutConstraint.activate([
        infoButton.widthAnchor.constraint(equalToConstant: 150),
        infoButton.heightAnchor.constraint(equalToConstant: 40),
        infoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
        infoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    @objc func showInfoView() {
        
    }
    
    private func createButton() {

        let button = UIButton()
        self.button = button
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        let titleAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17) ]
        

        let titleAttributedString = NSAttributedString(string: "Push to guess", attributes: titleAttribute)
        button.setAttributedTitle(titleAttributedString, for: .normal)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 369).isActive = true
        
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -369).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
      
    }
    
    private func updateLabelWithSecretNumber(newText: String) {
        label?.text = newText
    }
    
    @objc func didTapButton() {
        guard let game = game else { return }
        guard let score = slider?.value else { return }
        game.calculateScore(with: Int(score))
        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        updateLabelWithSecretNumber(newText: String(game.currentSecretValue))
    }
    
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Game Over", message: "You've earned \(score) points", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Numbers
 
    
    func bindingSlider(slider:UISlider?) -> UISlider {
        guard let slider = slider else { preconditionFailure("Unable to bind slider")}
        return slider
    }
    
    func gameBuild() {
        createSlider()
        createButton()
        createLabel()
        createInfoButton()
        
    }
}

    
    
    
    
    


