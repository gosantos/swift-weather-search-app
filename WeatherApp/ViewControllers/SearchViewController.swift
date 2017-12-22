import UIKit

enum Segue: String {
    case showDetail = "showDetail"
}


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
        if segue.identifier == Segue.showDetail.rawValue {
            if let detail = segue.destination as? WeatherDetailViewController {
                detail.cityName = self.cityNameTextField.text
            }
        }
        self.cityNameTextField.resignFirstResponder()
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        if identifier == Segue.showDetail.rawValue {
            return canSearchForCity
        }
        return true
    }

    private var canSearchForCity: Bool {
        if let text = self.cityNameTextField.text, text.count > 3 {
            return true
        } else {
            return false
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if canSearchForCity {
            self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
            return true
        } else {
            return false
        }
    }    
}

