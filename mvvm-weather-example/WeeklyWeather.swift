import SwiftUI

struct WeeklyWeatherView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Weather app", destination: CurrentWeatherView())
            }
        }
    }
}
