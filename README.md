# LUGGMA iOS SwiftUI Skeleton

- **Ekran sayısı (SwiftUI view dosyası)**: 72+
- **Proje oluşturma**: Bu depo XcodeGen ile `.xcodeproj` üretir.

## Başlangıç
1. `brew install xcodegen`
2. Klasöre gidin ve `xcodegen generate`
3. `Luggma.xcodeproj` dosyasını açın ve çalıştırın.

### Modüler Yapı
- `Features/` altında 50+ ekran iskeleti (Onboarding, Plan, Lessons, SOS, CoachCall, Community (Feed, Stories, Media, Location), Shop, Premium, Profile, Analytics, Settings)
- `DesignSystem/` modern bileşenler: **HeroHeader**, **GlassCard**, **PrimaryButton**, **ShimmerView**, **AnimatedCheckmark**, **BreathingCircle**
- `Core/` ortam, ağ protokolleri (gerçek servislerle değiştirilebilir)

### Notlar
- Görsel/animasyonlar SwiftUI ile yazıldı; 3. partiye bağımlı değil.
- Medya, konum, ödeme vb. servisler için arayüzler yer tutucu; gerçek entegrasyonlar eklenebilir.

## Dokümantasyon Paketi
- `01-project-overview.md`
- `02-requirements.md`
- `03-user-flow.md`
- `04-features.md`
- `05-tech-stack.md`
- `06-project-structure.md`
- `07-implementation.md`
- `08-generative-ui-dsl.md`
- `extras/`
  - `ADR/0001-stack.md`
  - `Observability/slo.md`
  - `QA/test-plan.md`

Sürüm: 2025-10-27 06:26 UTC

## Generative UI POC
- `backend/`: Express tabanlı DSL üretici.  
  - `cp backend/.env.example backend/.env` ile ortam değişkenlerini ayarla, `npm install` ve `npm run dev`.
  - `POST /api/dsl` uç noktası JSON şemasına uygun koç panosu döndürür; guardrail olarak Zod validasyonu kullanır.
- `frontend/`: Vite + React uygulaması.  
  - `cp frontend/.env.example frontend/.env.local`, ardından `npm install` ve `npm run dev`.  
  - `ComponentRenderer` DSL şemasındaki bileşenleri (summary-card, task-list, insight-chart, cta-card, note) render eder; aksiyonlar `/api/actions` üzerinden backend’e iletilir.
- Opsiyonel: `backend/.env` içine `OPENAI_API_KEY` (ve gerekirse `OPENAI_MODEL`) eklenirse `/api/dsl` uç noktası sahte veriler yerine OpenAI’dan gelen JSON’u kullanır; doğrulama geçmezse otomatik mock’a düşer.
