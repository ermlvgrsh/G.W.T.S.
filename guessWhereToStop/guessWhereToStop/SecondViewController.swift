import UIKit

class SecondViewController: UIViewController {
    
    var backButton: UIButton?
    
    
    private func createBackButton() {
        let backButton = UIButton(type: .system)
        self.backButton = backButton
        backButton.tintColor = .gray
        backButton.backgroundColor = .blue
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 35.0
        
        let titleAttributedText : [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17)
        ]
        
        let titleAttributedString = NSAttributedString(string: "Back", attributes: titleAttributedText)
        backButton.setAttributedTitle(titleAttributedString, for: .normal)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
        backButton.widthAnchor.constraint(equalToConstant: 60),
        backButton.heightAnchor.constraint(equalToConstant: 40),
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
        
        }
    
    
    @objc func backButtonTapped() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBackButton()
        
    }
    
}
