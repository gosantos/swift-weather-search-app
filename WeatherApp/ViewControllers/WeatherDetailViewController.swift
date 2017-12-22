import UIKit

class WeatherDetailViewController: UIViewController {
 
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriotionLabel: UILabel!
    
    var cityName: String! {
        didSet {
            self.title = cityName
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ServiceAPI.getWheather(cityName: cityName) { [weak self] (detail, error) in
            if let error = error {
                print("Error: \(error)")
                let alert = UIAlertController(title: "Ops!", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { __SRD in
                    self?.navigationController?.popViewController(animated: true)
                }))
                self?.present(alert, animated: true)
            } else if let detail = detail {
                self?.updateValues(detail)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateValues(_ weather: WeatherDetail) {
        temperatureLabel.text = String(describing: weather.temperature)
        descriotionLabel.text = weather.description
    }
}
