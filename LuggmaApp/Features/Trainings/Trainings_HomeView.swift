
import SwiftUI

struct Trainings_HomeView: View {
    let trainings: [Training] = [
        Training(title: "Mindfulness Temelleri", subtitle: "Stres yönetimi ve odaklanma", imageName: "mindfulness", progress: 0.6),
        Training(title: "Nefes Teknikleri", subtitle: "Daha sakin ve enerjik hisset", imageName: "breathing", progress: 0.25),
        Training(title: "Arzuyla Başa Çıkma", subtitle: "Sigara isteğini yönet", imageName: "coping", progress: 0.0)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(trainings) { training in
                        TrainingCardView(training: training)
                    }
                }
                .padding()
            }
            .navigationTitle("Eğitimler")
        }
    }
}
