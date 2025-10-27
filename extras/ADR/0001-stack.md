# ADR-0001: Stack Seçimleri

- **Karar:** iOS için SwiftUI; backend için Supabase (Postgres+Auth+Storage), medya için Cloudflare Stream/Mux ve R2; koç araması için Twilio; abonelik için RevenueCat; ödemeler için Iyzico/Stripe.
- **Durum:** Kabul edildi (2025-10-27 06:26 UTC).
- **Gerekçe:** Solo geliştirici için düşük operasyon maliyeti ve hızlı MVP; medya ölçeklenebilirliği.
- **Alternatifler:** Tam özelleştirilmiş FastAPI + S3 + CloudFront (daha ağır ops).
