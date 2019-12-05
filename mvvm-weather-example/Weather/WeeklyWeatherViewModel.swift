import Combine
import SwiftUI


class WeeklyWeatherViewModel: ObservableObject, Identifiable {
    @Published var city: String = ""
    @Published var dataSource: [DailyWeatherRowViewModel] = []
    
    private let weatherFetcher: WeatherFetchable
    
    private var disposables = Set<AnyCancellable>()
    
    init(weatherFetcher: WeatherFetchable, scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")) {
        self.weatherFetcher = weatherFetcher
        
        _ = $city
        .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: fetchWeather(for:))
    }
    
    func fetchWeather(for city: String) {
        weatherFetcher.weeklyWeatherForecast(for: city)
            .map { response in
                response.list.map(DailyWeatherRowViewModel.init)
            }
        .map(Array.removeDuplicates)
        .receive(on: DispatchQueue.main)
    .sink(
        receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
                self.dataSource = []
            case .finished:
                break
            }
        }, receiveValue: { [weak self] forecast in
            guard let self = self else { return }
            self.dataSource = forecast
    })
        .store(in: &disposables)
    }
    
}
