
import SwiftUI

struct TrainingModuleDetailView: View {
    // Modül verisini @Binding olarak alıyoruz.
    @Binding var module: TrainingModule

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(module.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 8) {
                    Text(module.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(module.subtitle)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                Divider().padding(.vertical)

                VStack(alignment: .leading, spacing: 15) {
                    Text("Dersler")
                        .font(.title2)
                        .fontWeight(.bold)

                    // $module.lessons ile her bir derse bir binding iletiyoruz.
                    ForEach($module.lessons) { $lesson in
                        NavigationLink(destination: TrainingLessonView(lesson: $lesson)) {
                            HStack {
                                Image(systemName: lesson.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(lesson.isCompleted ? .green : .gray)
                                    .font(.title2)

                                Text(lesson.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .transition(.slide)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.top)
    }
}
