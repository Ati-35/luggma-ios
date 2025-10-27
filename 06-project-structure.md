# Proje Yapısı

> **Sürüm:** 2025-10-27 06:26 UTC

## Klasör Ağacı
```
luggma/
  ios/
    LuggmaApp/
      Features/
        Onboarding/
        Plan/
        Lessons/
        SOS/
        CoachCall/
        Community/
          Feed/
          PostComposer/
          Story/
          MediaPicker/
        Shop/
        Premium/
      Core/
        Networking/
        Persistence/
        Analytics/
        UIComponents/
        Location/
  server/
    functions/
      twilio-call/
      orders-webhook/
      iap-webhook/
      story-gc/           # 24h sonra Story silen cron
  docs/                   # bu klasör
```

## API Sözleşmesi (REST)
- `GET  /v1/plan` - kişisel plan
- `POST /v1/progress` - ders ilerleme
- `POST /v1/sos` - SOS oturumu (başla/bitir)
- `POST /v1/call/book` - koç araması
- `GET  /v1/feed` - gönderi listesi (sayfalanmış)
- `POST /v1/post` - gönderi (metin + imzalı URL'lerle medya)
- `POST /v1/post/<built-in function id>/like` - beğeni toggle
- `POST /v1/post/<built-in function id>/comment` - yorum
- `POST /v1/story` - story yükleme (imzalı URL); TTL=24h
- `GET  /v1/story` - yakın çevredeki story'ler (opsiyonel filtre)
- `POST /v1/order` - ödeme sonrası sipariş onayı
- `GET  /v1/products` - ürün listesi

**Kimlik:** Supabase Auth (JWT).  
**Medya erişimi:** imzalı URL (1 saat geçerli).

## Veri Modeli (özet)
- **User(id, nickname, age18plus, consentFlags, premium, locale, createdAt)**
- **Plan(userId, startDate, quitDate, goals JSON, reminders)**
- **Lesson(id, section, title, videoUrl, duration, premium, order)**
- **Progress(userId, lessonId, positionSec, completedAt)**
- **SOSSession(id, userId, startedAt, completed, steps JSON)**
- **CoachCall(id, userId, status[pending|done|failed], scheduledAt, notes)**
- **Post(id, userId, text, media[] JSON, likeCount, commentCount, createdAt, location?)**
- **Comment(id, postId, userId, text, createdAt)**
- **Like(id, postId, userId, createdAt)**
- **Story(id, userId, mediaUrl, createdAt, expiresAt, location?)**
- **Product(id, name, price, currency, stock, isActive, tags[])**
- **Order(id, userId, items[], total, status, address JSON, provider)**

## Güvenlik
- RLS: Kullanıcı sadece kendi kullanıcı verisini/özel içeriklerini okur.
- Takma ad varsayılan; konum sadece kullanıcı izin verirse ve **yaklaşık** olarak tutulur.
- Medya yüklemeleri: istemci önce imzalı URL alır, sonra yükler (doğrudan CDN).

## Diyagram (C4 - Basit)
```mermaid
flowchart LR
  U[User (iOS)] --> A[SwiftUI App]
  A -->|JWT| E[Supabase API]
  A -->|HLS| V[Stream/Mux CDN]
  A -->|SignedURL| R[R2/Storage]
  A -->|Voice| T[Twilio]
  E --> P[(PostgreSQL)]
  E --> F[Edge Functions]
  F --> T
  F --> S[(Payments)]
```
