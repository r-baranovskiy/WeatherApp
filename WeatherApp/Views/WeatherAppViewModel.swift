
import UIKit

class WeatherAppViewModel: UIView {
    
    //MARK: - Constants
    
    var mainWeatherAppView = UIView()
    
    private let createView = CreateViewElements()
    
    //MARK: - Override
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
