import  UIKit

class WeatherMainViewController: UIViewController, WeatherAppViewModelProtocol {
    
    
    //MARK: - Constants
    
    private let weatherViewModel = WeatherAppViewModel()
    private let weatherManager = WeatherManager()
    private var mainWeatherView = UIView()
    private let backgroundImageView = UIImageView()
    
    //MARK: - Lifecycles
    
    override func loadView() {
        super.loadView()
        mainWeatherView = weatherViewModel.mainWeatherAppView
        backgroundImageView.image = UIImage(named: "background")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.clipsToBounds = false
        backgroundImageView.contentMode = .scaleAspectFill
        
        view.addView(backgroundImageView)
        view.addView(mainWeatherView)
        
        weatherViewModel.delegate = self
        
        setupConstraints()
    }
    
    private func searchButtonTapped(text: String) {
        weatherManager.fetchWeather(cityName: text)
    }
    
    func userIsTyping(text: String) {
        searchButtonTapped(text: text)
    }
    
    
    //MARK: - Setup Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            mainWeatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainWeatherView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

}

