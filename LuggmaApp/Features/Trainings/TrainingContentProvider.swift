
import Foundation

// Bu dosya, Eğitimler bölümü için tüm sahte verileri sağlar.
struct TrainingContentProvider {
    static let allCategories: [TrainingCategory] = [
        TrainingCategory(
            title: "Zihinsel ve Duygusal Hazırlık",
            modules: [
                TrainingModule(
                    title: "Stres Yönetimi",
                    subtitle: "Sigara içme isteğini tetikleyen stresi yönetmeyi öğrenin.",
                    imageName: "mindfulness", // Resim adları temsili, projenize uygun resimleri eklemeniz gerekecek.
                    lessons: [
                        TrainingLesson(title: "Giriş: Stres ve Sigara", content: "Stresin sigara içme alışkanlığı üzerindeki etkilerini anlama."),
                        TrainingLesson(title: "5 Dakikalık Nefes Egzersizi", content: "Anlık stres anlarında sakinleşmek için derin nefes teknikleri."),
                        TrainingLesson(title: "Mindfulness Pratiği", content: "Anda kalarak sigara arzusunu gözlemleme ve yönetme.")
                    ]
                ),
                TrainingModule(
                    title: "Tetikleyicilerle Başa Çıkma",
                    subtitle: "Hangi durumların sigara içme isteğinizi tetiklediğini keşfedin.",
                    imageName: "coping",
                    lessons: [
                        TrainingLesson(title: "Tetikleyici Nedir?", content: "Yaygın tetikleyicileri tanıma ve kişisel tetikleyicilerinizi belirleme."),
                        TrainingLesson(title: "Sabah Kahvesi Rutini", content: "Kahve içerken sigara içme alışkanlığını kırma stratejileri."),
                        TrainingLesson(title: "Sosyal Ortamlar", content: "Arkadaşlarınızla dışarıdayken sigarasız kalma yöntemleri.")
                    ]
                )
            ]
        ),
        TrainingCategory(
            title: "Fiziksel Süreç ve Sağlık",
            modules: [
                TrainingModule(
                    title: "Nikotin Yoksunluğu",
                    subtitle: "Vücudunuzun nikotinsizliğe adaptasyon sürecini anlayın.",
                    imageName: "breathing",
                    lessons: [
                        TrainingLesson(title: "İlk 72 Saat", content: "Bırakmanın ilk üç gününde sizi nelerin beklediğini öğrenin."),
                        TrainingLesson(title: "Yaygın Belirtiler ve Çözümleri", content: "Sinirlilik, uykusuzluk gibi belirtilerle başa çıkma yolları."),
                        TrainingLesson(title: "Fiziksel Aktivitenin Gücü", content: "Egzersizin yoksunluk belirtilerini azaltmadaki rolü.")
                    ]
                ),
                TrainingModule(
                    title: "Sağlıklı Yaşam Alışkanlıkları",
                    subtitle: "Sigarayı bıraktıktan sonra vücudunuzu destekleyin.",
                    imageName: "healthy-habits",
                    lessons: [
                        TrainingLesson(title: "Beslenme ve Hidrasyon", content: "Sigara isteğini azaltan yiyecekler ve bol su içmenin önemi."),
                        TrainingLesson(title: "Uyku Düzeni", content: "Kaliteli uykunun iyileşme sürecindeki kritik rolü.")
                    ]
                )
            ]
        )
    ]
}
