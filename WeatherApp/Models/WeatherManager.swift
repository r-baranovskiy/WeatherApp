
import Foundation

struct WeatherManager {
    
    private let apiKey = "ff68ae03099570aa5e32dfa96426ad4d"
    private let units = "metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&lang=ru&units=\(units)&appid=\(apiKey)"
        performRequest(urlString: urlString)
    }
    
    private func performRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error ?? "")
            } else {
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
    }

}
