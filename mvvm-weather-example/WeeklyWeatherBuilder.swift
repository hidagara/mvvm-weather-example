import SwiftUI

enum WeekltWeatherBuilder {
    static func makeCurrentWeatherView(with city: String, weatherFetcher: WeatherFetchable) -> some View {
        let viewModel = CurrentWeatherViewModel(city: city, weatherFetcher: weatherFetcher)
        return CurrentWeatherView(viewModel: viewModel)
    }
}
