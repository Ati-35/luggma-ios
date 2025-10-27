# Teknoloji Yığını

> **Sürüm:** 2025-10-27 06:26 UTC

## iOS
- **SwiftUI**, iOS 16+; async/await; Combine/ObservableObject
- Video: AVPlayer (HLS); medya sıkıştırma (AVAssetExportSession)
- Konum: CoreLocation (yaklaşık konum)
- Yerel veri: Core Data veya SQLite (GRDB)
- Bildirim: UserNotifications
- Abonelik: **RevenueCat** (Apple IAP)
- Hata izleme: Sentry iOS
- Analitik: Firebase (veya Amplitude)

## Sunucu/Servisler
- **Supabase** (PostgreSQL + Auth + RLS + Storage)
- **Cloudflare Stream**/**Mux**: video/Story barındırma + CDN
- **Cloudflare R2**/**Supabase Storage**: görsel dosyalar (imzalı URL)
- **Twilio**: Koç aramaları
- **Iyzico/Stripe**: Fiziksel ürün ödemeleri
- **Supabase Edge Functions**: webhooks (IAP, ödeme), Twilio imzalama
- İzleme: UptimeRobot + Sentry (functions)

## Neden?
- Solo geliştirici için düşük operasyon maliyeti ve hızlı çıkış.
- Yüksek medya kalitesi, imzalı URL'lerle güvenli erişim.
