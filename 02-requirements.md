# LUGGMA Gereksinimleri

> **Sürüm:** 2025-10-27 06:26 UTC

## 1) Fonksiyonel Gereksinimler

### 1.1 Kimlik & Rıza
- Apple ile giriş, e-posta/OTP alternatif.
- Yaş doğrulama (18+); KVKK aydınlatma ve açık rıza.
- Sağlık beyanı: tıbbi iddia yok; acil durum uyarıları.

### 1.2 Onboarding & Plan
- 60-90 sn değerlendirme: tetikleyiciler, bırakma tarihi, motivasyon, alışkanlıklar.
- Çıktı: **Bırakma Planım** - gün/görev listesi ve hatırlatmalar.
- Günlük "sigarasız gün" sayacı + geri kazanım.
- Bildirim izni; reddederse e-posta/iç bildirim.

### 1.3 Eğitim Modülleri
- Ders/video + özet metin + opsiyonel kısa quiz.
- **Kaldığın yerden**; ders ilerlemesi ve son oynatma konumu.
- Premium kilitli dersler.

### 1.4 Kriz Anı SOS
- 3 adım: nefes → dikkat dağıtma → yeniden çerçeveleme.
- 2-3 dakikada tamamlanır; başarısızlıkta koç araması önerisi.

### 1.5 Koç Araması
- "Şimdi bağlan" veya "zamanla" (Twilio). Geri arama.
- Görüşme notları -> görev olarak plana düşer.
- Freemium aylık dakika kotası; premium upsell.

### 1.6 Topluluk 2.0
- **Faz A (MVP):**
  - Gönderi (metin + 4 adede kadar **görsel**), yorum, beğeni.
  - Raporla/moderasyon; topluluk kuralları.
- **Faz B (v1):**
  - **Video** yükleme (60 sn'e kadar), **konum etiketi** (şehir/semt),
  - **Story** (24 saat yaşayan foto/video; mute/engelle).
- Gizlilik: Kullanıcı adı takma ad; konum **isteğe bağlı ve yaklaşık** (±3 km).

### 1.7 Premium
- RevenueCat ile abonelik, iptal/yineleme, kupon (B2B).

### 1.8 E-Ticaret
- Ürün çeşitleri: "Başlangıç Kiti", **nikotin içermeyen** pastil/çay, destekleyici nefes egzersiz kartları, kitapçık.
- Sepet, adres/kargo, ödeme (Iyzico/Stripe). Webhook onayı.
- Mesafeli satış sözleşmesi ve KVKK metinleri.

### 1.9 Analitik
- Event'ler: `app_opened`, `assessment_done`, `plan_created`, `lesson_completed`,
  `sos_completed`, `coach_call_booked`, `post_created`, `story_published`,
  `subscription_started`, `order_paid`.
- Kullanıcı silme: soft+hard delete; event'lerde PII yok.

### 1.10 Yönetim
- Admin: içerik, moderasyon, ürün/sipariş.
- Koç: kendi çağrıları, notlar.
- RLS ile satır düzeyi yetki.

---

## 2) NFR (Kodlu)

### Performans
- **APP-P95-START:** uygulama açılışı < **2 s**.
- **API-P95-READ:** okuma < **400 ms**; **API-P95-WRITE:** yazma < **700 ms**.
- **VIDEO-PLAY:** HLS başlatma < **1 s**; story video < **10 MB**, 720p.
- **UPLOAD-LIMITS:** görsel ≤ **10 MB**, video ≤ **100 MB** (otomatik sıkıştır).

### Güvenilirlik
- **SLO:** 99.9% (API + video teslimi).
- Koç araması ilk denemede bağlanma ≥ %95; ikinci deneme otomatik.

### Güvenlik
- OAuth (Apple) + kısa ömürlü JWT; tüm trafiğe TLS 1.2+.
- Rate limit: auth 60 rpm, okuma 600 rpm, yazma 120 rpm.
- Medya erişimi: **imzalı URL** (1 saat).

### Gizlilik & Uyum
- KVKK uyumlu veri minimizasyonu; 18+ doğrulama.
- Konum isteğe bağlı ve yaklaşık; **Story** verileri 24 saatte otomatik silinir.
- Hesap silme -> 30 gün içinde tüm kişisel verilerin kalıcı silinmesi (sipariş/fatura hariç yasal saklama).

### Erişilebilirlik & Yerelleştirme
- WCAG 2.1 **AA**; VoiceOver; dinamik yazı.
- i18n hazır; TR başlangıç.

### Gözlemlenebilirlik
- Sentry (istemci + edge functions) + uptime monitörleri.

---

## 3) İzlenebilirlik Matrisi
| Feature | AC Kodları | Test | NFR |
|---|---|---|---|
| Onboarding & Plan | AC-ONB-01..03 | E2E-ONB | APP-P95-START |
| Eğitim Modülleri | AC-LESSON-01..04 | UI-LESSON, API-PROGRESS | VIDEO-PLAY |
| SOS | AC-SOS-01..04 | E2E-SOS | APP-P95-START |
| Koç Araması | AC-CALL-01..04 | API-CALL, E2E-CALL | SLO |
| Topluluk A | AC-COM-01..02 | API-FEED, E2E-FEED | UPLOAD-LIMITS |
| Topluluk B | AC-STORY-01..04 | E2E-STORY | PRIVACY |
| Premium | AC-SUB-01..03 | IAP-SUB | SEC |
| E-Ticaret | AC-SHOP-01..04 | API-SHOP, E2E-SHOP | PRIVACY |
