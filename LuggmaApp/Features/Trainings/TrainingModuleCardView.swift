
import SwiftUI

struct TrainingModuleCardView: View {
    let module: TrainingModule

    var body: some View {
        VStack(alignment: .leading) {
            Image(module.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .clipped()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.0), .black.opacity(0.6)]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(module.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .offset(y: -30)

                Text(module.subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal)
                    .offset(y: -30)
                    .lineLimit(2)

                Spacer()

                HStack {
                    ProgressView(value: module.progress)
                        .progressViewStyle(LinearProgressViewStyle(tint: .white))
                    Text("\(Int(module.progress * 100))%")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .frame(height: 100)
        }
        .background(Color.blue.gradient)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.2), radius: 8, y: 5)
    }
}
