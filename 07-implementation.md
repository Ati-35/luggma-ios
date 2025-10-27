# Uygulama Planı ve Standartlar

> **Sürüm:** 2025-10-27 06:26 UTC

## Yol Haritası (fazlı)
- **M0**: iOS iskelet + Auth + Supabase; navigasyon.  
- **M1**: Onboarding & Plan + bildirimler + "Devam et".  
- **M2**: Video dersler (HLS), ilerleme, quiz.  
- **M3**: SOS akışı + analitik event'ler.  
- **M4**: Koç araması (Twilio) + geri arama.  
- **M5**: Topluluk **Faz A** (metin + görsel).  
- **M6**: Premium (RevenueCat) + paywall.  
- **M7**: E-ticaret temel ürün seti + ödeme webhooks.  
- **V1**: Topluluk **Faz B** (video, konum etiketi, Story + 24h GC).

## Branching & PR
- Trunk-based; kısa ömürlü feature branch'ler.
- PR şablonu: kapsam, AC, testler, "docs updated?" onayı.

## DoR / DoD
- **DoR**: AC net, ekran tasarımı/akış, analitik event tanımı.  
- **DoD**: Unit testler, E2E smoke, Sentry yeni hata yok, dokümantasyon güncel.

## Test Stratejisi
- iOS: XCTest (unit/UI), snapshot kritik ekranlarda.
- E2E "happy path" senaryoları: onboarding→plan→ders→SOS→community→paywall.
- Performans: başlatma, HLS start, SOS açılışı (Xcode Instruments).
- Güvenlik: RLS negatif testler, imzalı URL süresi.

## CI/CD
- GitHub Actions → Build + Unit Test + TestFlight dağıtımı.
- Edge Functions otomatik deploy (stage/prod).
- Crash & telemetri: Sentry; Uptime monitörleri.

## Operasyon (Runbook)
- **Video başlamıyor** → Stream/Mux status → kalite düşür → yeniden dener.  
- **Arama bağlanmıyor** → Twilio status → 2. deneme → geri arama planla.  
- **Ödeme** → Webhook kuyruğu → yeniden dene → manuel kontrol listesi.

## Hukuki/İçerik
- KVKK metinleri, topluluk kuralları, sağlık beyanı.  
- Takviye içerikleri tıbbi iddia içermez; mesafeli satış sözleşmeleri zorunlu.
