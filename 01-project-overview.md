# LUGGMA
**Slogan:** "Bilim + Koç + Topluluk: Sigarayı Tek Başına Bırakmak Zorunda Değilsiniz."

> **Sürüm:** 2025-10-27 06:26 UTC

## 1) Vizyon ve Problem
Sigarayı bırakmak isteyen milyonlarca kişi yalnızlık, tetikleyiciler ve motivasyon düşüşü nedeniyle zorlanıyor. LUGGMA; bilimsel içerikler + koç desteği + topluluk motivasyonu ve (ayrı iş kolu) bitkisel takviye satışını **tek bir mobil deneyimde** birleştirir.

> **Tıbbi uyarı:** LUGGMA tıbbi teşhis/tedavi sunmaz. Sağlık durumları için doktorunuza danışın. Acil durumlarda 112.

## 2) Pazar ve Hedef Kitle
- **B2C:** Türkiye başlangıç, global ölçeklenebilir. 18+ kullanıcılar.
- **B2B:** İşveren destekli "wellbeing" programları.
- **Platform:** iOS öncelik (SwiftUI), sonra Android.
- **Dil:** TR (ilk), çok dilliliğe hazır.

## 3) Değer Önerisi
- **Kişisel bırakma planı:** Kısa değerlendirmeden kişiselleşen görevler.
- **Anında destek:** Koç araması/geri arama; kriz anı SOS.
- **Topluluk 2.0:** Gönderi + yorum + beğeni + **görsel/video + konum etiketleme + 24h Story**.
- **İçerik:** Mikro dersler, kısa videolar; "kaldığın yerden" devam.
- **Takviye:** Bitkisel ürünleri e-ticaretle sunma (yasal çerçevelerle).

## 4) KPI'lar
- Aylık aktif kullanıcı (MAU)
- Ücretsiz->Premium dönüşüm
- 7/30 günlük elde tutma (D7/D30)
- Ortalama "sigarasız gün" sayısı (kullanıcı beyanına dayalı)
- Koç araması bağlanma oranı
- Referans ile gelen kullanıcı oranı (K-factor)

**Hedef:** 12 ayda **1M** kayıtlı kullanıcı ve sürdürülebilir premium dönüşüm.

## 5) MVP Kapsam
**MUST**
- iOS uygulaması, Apple ile giriş, KVKK rızaları.
- Onboarding + kişisel plan + bildirimler.
- Eğitim modülleri (video+metin) ve **kaldığın yerden**.
- Kriz anı **SOS** (3 adım).
- **Koç araması** (şimdi/planla) - Twilio.
- **Topluluk 2.0 (fazlı):**
  - Faz A (MVP): metin gönderi, yorum, beğeni, **görsel** yükleme.
  - Faz B (v1): **video**, **konum etiketi**, **Story (24h)**.
- Premium (RevenueCat) + B2B kuponları.
- E-ticaret: temel ürün seti, ödeme (TR: Iyzico / Global: Stripe).
- Analitik ve telemetri, moderasyon/raporlama.

**OUT (ilk sürüm değil)**
- Android, web istemci; cihaz bazlı CO ölçer entegrasyonları.

## 6) Varsayımlar & Riskler
- Tek geliştirici -> yönetilen servislerle düşük-ops.
- Story/video/konum özellikleri bant genişliği yüksek; **fazlı** çıkarım.
- Yasal metinler ve açık rıza akışları olmazsa olmaz.

## 7) İş Modeli
- **Freemium** + **Premium abonelik** (kişisel plan, koç önceliği, özel modüller).
- **E-ticaret**: "Bırakma Başlangıç Kiti", bitkisel takviyeler, nikotin-içermeyen yardımcılar.
