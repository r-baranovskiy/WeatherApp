import SwiftUI
struct ListProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let listVC = WeatherMainViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListProvider.ContainerView>) -> WeatherMainViewController {
            return listVC
        }
        
        func updateUIViewController(_ uiViewController: ListProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListProvider.ContainerView>) {
        }
    }
}
protocol WeatherAppViewModelProtocol: AnyObject {
    
    func userIsTyping(text: String)
}

class WeatherAppViewModel: UIView, UITextFieldDelegate {
    
    //MARK: - Constants
    
    weak var delegate: WeatherAppViewModelProtocol?
    var mainWeatherAppView = UIView()
    
    private let createView = CreateViewElements()
    
    //MARK: - UI elements
    
    private var locationButton = UIButton()
    private var searchButton = UIButton()
    private var searchTextField = UITextField()
    private var cityLabel = UILabel()
    private var conditionImageView = UIImageView()
    private var temperatureLabel = UILabel()
    private var segmentedControl = UISegmentedControl()
    
    //MARK: - Containers
    
    private var topContainer = UIView()
    
    //MARK: - Override
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        createUIElements()
        setupTopContainer()
        setupMainWeatherAppView()
        setupMainConstraints()
        
        searchTextField.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup MainWeatherAppView
    
    private func setupMainWeatherAppView() {
        
        mainWeatherAppView.addView(locationButton)
        mainWeatherAppView.addView(searchButton)
        mainWeatherAppView.addView(searchTextField)
        mainWeatherAppView.addView(topContainer)
        mainWeatherAppView.addView(cityLabel)
        mainWeatherAppView.addView(segmentedControl)
    }
    
    private func setupTopContainer() {
        let celsiusLabel = createView.createLabel(text: "ºC", textColor: .label, alignment: .left, fontSize: 100)
        celsiusLabel.font = .boldSystemFont(ofSize: 100)
        
        topContainer.addView(conditionImageView)
        topContainer.addView(celsiusLabel)
        topContainer.addView(temperatureLabel)
        
        NSLayoutConstraint.activate([
            temperatureLabel.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            
            celsiusLabel.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            celsiusLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 5),
            
            conditionImageView.leadingAnchor.constraint(equalTo: celsiusLabel.trailingAnchor, constant: 5),
            conditionImageView.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor),
            conditionImageView.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 30),
            conditionImageView.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -30),
            conditionImageView.widthAnchor.constraint(equalTo: conditionImageView.heightAnchor, multiplier: 1.2)
        ])
    }
    
    //MARK: - Setup constraints
    
    private func setupMainConstraints() {
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: mainWeatherAppView.topAnchor, constant: 0),
            locationButton.leadingAnchor.constraint(equalTo: mainWeatherAppView.leadingAnchor, constant: 10),
            locationButton.heightAnchor.constraint(equalToConstant: 50),
            locationButton.widthAnchor.constraint(equalTo: locationButton.heightAnchor, multiplier: 1),
            
            searchButton.widthAnchor.constraint(equalTo: locationButton.widthAnchor, multiplier: 1),
            searchButton.heightAnchor.constraint(equalTo: searchButton.widthAnchor, multiplier: 1),
            searchButton.trailingAnchor.constraint(equalTo: mainWeatherAppView.trailingAnchor, constant: -10),
            searchButton.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            
            searchTextField.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            searchTextField.heightAnchor.constraint(equalTo: locationButton.heightAnchor, multiplier: 1),
            
            cityLabel.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 10),
            cityLabel.leadingAnchor.constraint(equalTo: mainWeatherAppView.leadingAnchor, constant: 40),
            cityLabel.trailingAnchor.constraint(equalTo: mainWeatherAppView.trailingAnchor, constant: -40),
            
            topContainer.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            topContainer.leadingAnchor.constraint(equalTo: locationButton.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor),
            topContainer.heightAnchor.constraint(equalTo: mainWeatherAppView.heightAnchor, multiplier: 0.2),
            
            segmentedControl.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: mainWeatherAppView.leadingAnchor, constant: 50),
            segmentedControl.trailingAnchor.constraint(equalTo: mainWeatherAppView.trailingAnchor, constant: -50),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    //MARK: - Delegate
    
    @objc private func searchButtonPressed() {
        if searchTextField.text == "" {
            searchTextField.alpha = 0.5
        } else {
            searchTextField.text = ""
            searchTextField.alpha = 0
        }
        
        print("Tapped")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.userIsTyping(text: searchTextField.text ?? "")
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = nil
    }
    
    //MARK: - Setup UI Elements
    
    private func createUIElements() {
        
        locationButton.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .label
        
        searchTextField = createView.createTextField(textAlignment: .justified, textColor: .label, fontSize: 25, placeholder: "  Enter any city", minFontSize: 12, tykeKeyboard: .default, tintColor: .systemGray)
        searchTextField.backgroundColor = .white
        searchTextField.alpha = 0.5
        searchTextField.textColor = .darkGray
        searchTextField.borderStyle = .none
        searchTextField.layer.cornerRadius = 15
        searchTextField.returnKeyType = .go
        searchTextField.autocapitalizationType = .words
        
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        
        cityLabel = createView.createLabel(text: "Molodechno", textColor: .label, alignment: .center, fontSize: 50)
        cityLabel.font = .italicSystemFont(ofSize: 50)
        cityLabel.numberOfLines = 1
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.minimumScaleFactor = 0.3
        
        conditionImageView.image = UIImage(systemName: "cloud.sun.fill")
        conditionImageView.tintColor = .label
        
        temperatureLabel = createView.createLabel(text: "21", textColor: .label, alignment: .right, fontSize: 80)
        temperatureLabel.font = .boldSystemFont(ofSize: 80)
        
        let itemsForSegmented = ["Today", "5 Days"]
        segmentedControl = UISegmentedControl(items: itemsForSegmented)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .red
    }
    
}
