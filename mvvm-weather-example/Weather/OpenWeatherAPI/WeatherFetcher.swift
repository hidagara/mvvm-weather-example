import Foundation
import Combine

class WeatherFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

private extension WeatherFetcher {
    struct OpenWeatherAPI {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5/weather"
        static let key = "0eea25e6c323d9bccc349d4bc2f59ef5"
    }
    
    func makeWeeklyForecastComponents(with city: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
        ]
        
        return components
    }
    
    func makeCurrentForecastComponents(with city: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
        ]
        
        return components
    }
}



protocol WeatherFetchable {
    func weeklyWeatherForecast(for city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError>
    func currentWeatherForecast(for city: String) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError>
}


extension WeatherFetcher: WeatherFetchable {
    
    private func forecast<T>(with urlComponents: URLComponents) -> AnyPublisher<T, WeatherError> where T: Decodable {
        guard let url = urlComponents.url else {
            let error = WeatherError.network(description: "Could not create url")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    func currentWeatherForecast(for city: String) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError> {
        return forecast(with: makeCurrentForecastComponents(with: city))
    }
    
    func weeklyWeatherForecast(for city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
       return forecast(with: makeWeeklyForecastComponents(with: city))
    }
}
