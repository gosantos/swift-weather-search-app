import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.cityNameTextField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showDetail" {
            let cityName = self.cityNameTextField.text
            if let detail = segue.destination as? WeatherDetailViewController {
                detail.cityName = cityName
            }
        }
        
        self.cityNameTextField.resignFirstResponder()
    
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        
        guard let text = textField.text else {
            return false
        }
        
        if text.count > 3 {
            self.performSegue(withIdentifier: "showDetail", sender: self)
            return true
        } else {
            return false
        }
        
    }
    
}

