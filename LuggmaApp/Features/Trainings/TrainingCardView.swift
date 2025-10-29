
import SwiftUI

struct TrainingCardView: View {
    let training: Training

    var body: some View {
        VStack(alignment: .leading) {
            Image(training.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text(training.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(training.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                ProgressView(value: training.progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .padding(.top, 4)
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
