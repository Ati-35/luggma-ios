
import SwiftUI

struct TrainingLessonView: View {
    // Dersi @Binding olarak alarak, yapılan değişikliklerin üst görünümlere yansımasını sağlıyoruz.
    @Binding var lesson: TrainingLesson

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(lesson.title)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(lesson.content)
                .font(.body)

            Spacer()

            Button(action: {
                // Animasyon ile değişikliği daha pürüzsüz hale getiriyoruz.
                withAnimation {
                    lesson.isCompleted.toggle()
                }
            }) {
                HStack {
                    Image(systemName: lesson.isCompleted ? "checkmark.circle.fill" : "circle")
                    Text(lesson.isCompleted ? "Tamamlandı" : "Dersi Tamamla")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(lesson.isCompleted ? Color.green.gradient : Color.blue.gradient)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.2), radius: 5, y: 3)
            }
        }
        .padding()
        .navigationTitle(lesson.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
