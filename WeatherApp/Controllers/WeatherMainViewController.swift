import  UIKit

class WeatherMainViewController: UIViewController, WeatherAppViewModelProtocol, WeatherManagerProtocol {
    
    //MARK: - Constants
    
    private let weatherViewModel = WeatherAppViewModel()
    private var weatherManager = WeatherManager()
    private var mainWeatherView = UIView()
    private let backgroundImageView = UIImageView()
    
    //MARK: - Lifecycles
    
    override func loadView() {
        super.loadView()
        weatherManager.delegate = self
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
    //ViewModel delegate
    
    func userIsTyping(_ weatcherViewModel: WeatherAppViewModel, text: String) {
        weatherManager.fetchWeather(cityName: text)
    }
    
    //WeatherManager delegate
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel) {
        weatherViewModel.updateUI(temp: weatherModel.tempatureString, cityName: weatherModel.cityName, conditionImageName: weatherModel.conditionName)
    }
    
    func didFailWithError(error: Error) {
        print(error)
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

