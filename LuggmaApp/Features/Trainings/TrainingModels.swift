
import Foundation

// En küçük birim: Tek bir ders
struct TrainingLesson: Identifiable {
    let id = UUID()
    let title: String
    let content: String // Ders içeriği (metin, video URL'si vb. olabilir)
    var isCompleted: Bool = false
}

// Dersleri içeren bir modül
struct TrainingModule: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageName: String
    let lessons: [TrainingLesson]

    // Modülün tamamlanma oranını hesaplayan bir özellik
    var progress: Double {
        guard !lessons.isEmpty else { return 0 }
        let completedCount = lessons.filter { $0.isCompleted }.count
        return Double(completedCount) / Double(lessons.count)
    }
}

// Modülleri içeren bir kategori
struct TrainingCategory: Identifiable {
    let id = UUID()
    let title: String
    let modules: [TrainingModule]
}
