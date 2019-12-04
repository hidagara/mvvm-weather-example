import SwiftUI

struct DailyWeatherRow: View {
    private let viewModel: DailyWeatherRowViewModel
    
    init(viewModel: DailyWeatherRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("\(viewModel.day)")
                Text("\(viewModel.month)")
            }
            VStack(alignment: .leading, spacing: nil) {
                Text("\(viewModel.title)")
                Text("\(viewModel.footnote)")
            }.padding(.leading, 8)
            
            Spacer()
            
            Text("\(viewModel.temperature)")
                .font(.title)
        }
    }
}