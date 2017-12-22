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
        self.temperatureLabel.text = "? ºC"
        self.descriotionLabel.text = "Searching..."
        ServiceAPI.getWheather(cityName: cityName) { [weak self] (detail, error) in
            if let error = error {
                self?.showAlertError(error)
            } else if let detail = detail {
                self?.updateValues(detail)
            }
        }
    }

    private func showAlertError(_ error: Error) {
        let alert = UIAlertController(title: "Ops!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    private func updateValues(_ weather: WeatherDetail) {
        temperatureLabel.text = "\(weather.temperature)ºC"
        descriotionLabel.text = weather.description
    }
}
