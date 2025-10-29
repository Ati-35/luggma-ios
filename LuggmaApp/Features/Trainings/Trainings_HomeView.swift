
import SwiftUI

struct Trainings_HomeView: View {
    // Veriyi @State olarak tanımlayarak, içeriğinin değiştirilebilir olmasını sağlıyoruz.
    @State private var categories = TrainingContentProvider.allCategories

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // $categories ile her bir kategoriye bir binding iletiyoruz.
                    ForEach($categories) { $category in
                        VStack(alignment: .leading) {
                            Text(category.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    // $category.modules ile her bir modüle bir binding iletiyoruz.
                                    ForEach($category.modules) { $module in
                                        NavigationLink(destination: TrainingModuleDetailView(module: $module)) {
                                            TrainingModuleCardView(module: module)
                                                .frame(width: 250)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 10)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Eğitim Merkezi")
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
}
