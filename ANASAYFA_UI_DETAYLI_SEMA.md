# 📱 LUGGMA ANASAYFA - DETAYLI UI/UX ŞEMASI

## 📐 Ekran Boyutları ve Düzen

**Telefon Çerçevesi:** iPhone Standard (375 x 812 pt)  
**Safe Area Top:** 44pt (Status Bar + Notch)  
**Safe Area Bottom:** 34pt (Home Indicator) + 83pt (Tab Bar)  
**İçerik Alanı:** 375 x 651 pt

---

## 🎨 Arka Plan (Background)

```
┌─────────────────────────────────────┐
│  GRADIENT BACKGROUND (tüm ekran)    │
│  ├─ Tip: LinearGradient             │
│  ├─ Başlangıç: topLeading           │
│  ├─ Bitiş: bottomTrailing           │
│  └─ Renkler (yukarıdan aşağı):      │
│     • Pembe (#F94077) - 0%          │
│     • Turuncu (#FC9A3B) - 25%       │
│     • Sarı (#F5D48C) - 45%          │
│     • Turkuaz (#70DEBF) - 65%       │
│     • Mavi (#42BDDB) - 85%          │
│     • Yeşil (#58D6A0) - 100%        │
└─────────────────────────────────────┘
```

---

## 📱 TELEFON ÜZERİNDE DETAYLI LAYOUT

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  [•••] 09:41                    🔋 100% ┃  ← STATUS BAR (sistem)
┃━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┃
┃  ┌─────────────────────────────────────────────┐  ┃
┃  │                                             │  ┃
┃  │         HERO HEADER (220pt yükseklik)       │  ┃  ← 1. BÖLÜM: HERO HEADER
┃  │  ┌─────────────────────────────────────┐   │  ┃
┃  │  │                                     │   │  ┃
┃  │  │  [HeroPlaceholder Görsel]          │   │  ┃
┃  │  │  (şu an görünmüyor ama slot var)   │   │  ┃
┃  │  │                                     │   │  ┃
┃  │  │  Merhaba!                           │   │  ┃  • Title: "Merhaba!"
┃  │  │  Bugün duman yok FENAYIZ 💪        │   │  ┃  • Subtitle: "Bugün duman yok..."
┃  │  │                                     │   │  ┃  • Border: Gradient (mint→blue)
┃  │  └─────────────────────────────────────┘   │  ┃  • Corner Radius: 16pt
┃  │  Padding: 16pt yatay                       │  ┃  • Shadow: mavi gölge
┃  └─────────────────────────────────────────────┘  ┃
┃                                                    ┃
┃  ┌─────────────────────────────────────────────┐  ┃
┃  │ ┌────────────────────┐ ┌─────────────────┐ │  ┃  ← 2. BÖLÜM: GLASS CARD'LAR
┃  │ │   GLASS CARD 1     │ │  GLASS CARD 2   │ │  ┃
┃  │ │                    │ │                 │ │  ┃
┃  │ │  ▶ play.circle.fill│ │  ❤️ heart.text  │ │  ┃  • İki kart yan yana (HStack)
┃  │ │    (28pt icon)     │ │    .square.fill │ │  ┃  • Spacing: 12pt
┃  │ │                    │ │                 │ │  ┃  • Material: .ultraThinMaterial
┃  │ │  Devam Et          │ │  SOS            │ │  ┃  • Border: Gradient (mint→blue)
┃  │ │  (headline)        │ │  (headline)     │ │  ┃  • Min Height: 110pt
┃  │ │  Son ders          │ │  Kriz anı yardımı│ │  ┃  • Corner Radius: 16pt
┃  │ │  (caption/secondary)│ │  (caption)      │ │  ┃  • Padding: 16pt içerik
┃  │ └────────────────────┘ └─────────────────┘ │  ┃  • Shadow: mavi gölge
┃  │  Gradient border + gölge efekti            │  ┃
┃  └─────────────────────────────────────────────┘  ┃
┃     Padding: 16pt yatay, 12pt dikey                ┃
┃                                                    ┃
┃  ╔═══════════════════════════════════════════╗  ┃
┃  ║  GÖREVLER                                 ║  ┃  ← 3. BÖLÜM: GÖREVLER
┃  ╚═══════════════════════════════════════════╝  ┃  • Section Header (beyaz, bold)
┃                                                    ┃
┃  ┌─────────────────────────────────────────────┐  ┃
┃  │ ☐ 💨  5 dk nefes egzersizi               ⋮ │  ┃  • TASK ROW 1
┃  └─────────────────────────────────────────────┘  ┃  • Checkbox: AnimatedCheckmark
┃  ┌─────────────────────────────────────────────┐  ┃  • Icon: wind (18pt, circular bg)
┃  │ ☐ ▶  'Tetikleyiciler' videosunu izle     ⋮ │  ┃  • TASK ROW 2
┃  └─────────────────────────────────────────────┘  ┃  • Icon: play.rectangle (gradient)
┃  ┌─────────────────────────────────────────────┐  ┃  • Padding: 16pt yatay
┃  │ ☐ ⚠️  Bugün İçin Böyle Dikkat Edelim     ⋮ │  ┃  • TASK ROW 3
┃  └─────────────────────────────────────────────┘  ┃  • Icon: exclamationmark.triangle
┃     Her satır 16pt padding yatay                  ┃  • Border: Gradient (mint→blue)
┃                                                    ┃  • Shadow: mavi gölge
┃                                                    ┃  • Tap → checkbox animasyonu
┃  ╔═══════════════════════════════════════════╗  ┃
┃  ║  MOTİVASYON                               ║  ┃  ← 4. BÖLÜM: MOTİVASYON
┃  ╚═══════════════════════════════════════════╝  ┃  • Section Header (beyaz, bold)
┃                                                    ┃
┃  ┌─────────────────────────────────────────────┐  ┃
┃  │ ☐ 💬  Toplulukta paylaşım yap            ⋮ │  ┃  • TASK ROW 4
┃  └─────────────────────────────────────────────┘  ┃  • Icon: bubble.left.and...
┃  ┌─────────────────────────────────────────────┐  ┃
┃  │ ☐ 📖  Koç notlarını oku                  ⋮ │  ┃  • TASK ROW 5
┃  └─────────────────────────────────────────────┘  ┃  • Icon: book.closed
┃  ┌─────────────────────────────────────────────┐  ┃
┃  │ ☐ 💧  Su içmeyi unutma                   ⋮ │  ┃  • TASK ROW 6
┃  └─────────────────────────────────────────────┘  ┃  • Icon: drop
┃                                                    ┃
┃  ╔═══════════════════════════════════════════╗  ┃
┃  ║  VIDEO  (dinamik renk)                    ║  ┃  ← 5. BÖLÜM: VİDEO CAROUSEL
┃  ╚═══════════════════════════════════════════╝  ┃  • Section Header (aktif video rengi)
┃                                                    ┃
┃  ┌─────────────────────────────────────────────┐  ┃
┃  │ ╔═══════════════════════════════════════╗ │  ┃  • VIDEO CARD (180pt yükseklik)
┃  │ ║                                       ║ │  ┃  • TabView (page style)
┃  │ ║  ┌────┐  Nefes Tekniği               ║ │  ┃  • Auto-scroll: 4 saniyede 1
┃  │ ║  │🫁 │  4-7-8 metodunu uygulayalım   ║ │  ┃  • Gradient Background (kart rengi)
┃  │ ║  └────┘                               ║ │  ┃  • Icon: 28pt (glassmorphism)
┃  │ ║                                       ║ │  ┃  • Title: headline (beyaz)
┃  │ ║                                       ║ │  ┃  • Subtitle: subheadline (beyaz 85%)
┃  │ ║  ▶ İzlemeye başla                    ║ │  ┃  • CTA Button: Capsule shape
┃  │ ╚═══════════════════════════════════════╝ │  ┃  • Corner Radius: 28pt
┃  │  Padding: 16pt yatay                       │  ┃  • Shadow: gradient son renk
┃  │  6 video kartı (swipe edilebilir)          │  ┃  • Padding: 22pt içerik
┃  └─────────────────────────────────────────────┘  ┃
┃                                                    ┃
┃  [daha fazla içerik - scroll edilebilir]          ┃
┃                                                    ┃
┃━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┃
┃  🏠     📖     ❤️‍🩹     👥     🛍️     👤        ┃  ← TAB BAR (83pt yükseklik)
┃  Ana  Dersler  SOS  Topluluk Mağaza Profil       ┃  • System TabView
┃━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┃  • house.fill aktif (Ana)
┃  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔  (Home Indicator)          ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

---

## 🔍 BÖLÜM DETAYLARI

### 1️⃣ HERO HEADER
**Dosya:** `LuggmaApp/DesignSystem/Theme.swift` (satır 82-111)
**Component:** `HeroHeader`

| Özellik | Değer | Açıklama |
|---------|-------|----------|
| **Yükseklik** | 220pt | `theme.headerHeight` |
| **Corner Radius** | 16pt | `theme.cardCorner` (varsayılan) |
| **Padding Yatay** | 16pt | `.padding(.horizontal)` |
| **Border** | Gradient | mint.opacity(0.65) → blue.opacity(0.45) |
| **Border Width** | 1.4pt | `lineWidth: 1.4` |
| **Shadow** | Mavi gölge | `radius: 16, y: 10` |
| **Blend Mode** | .plusLighter | Parlaklık efekti |
| **Title** | "Merhaba!" | String parametresi |
| **Subtitle** | "Bugün duman yok FENAYIZ 💪" | String parametresi |
| **Image Slot** | "HeroPlaceholder" | UIImage (şu an boş) |

**Kullanım:**
```swift
HeroHeader(title: "Merhaba!",
           subtitle: "Bugün duman yok FENAYIZ 💪",
           imageName: "HeroPlaceholder")
```

---

### 2️⃣ GLASS CARD'LAR
**Dosya:** `LuggmaApp/DesignSystem/Theme.swift` (satır 113-137)
**Component:** `GlassCard`

**Container:**
- **Layout:** HStack (yatay düzen)
- **Spacing:** 12pt
- **Padding Vertical:** 12pt
- **Padding Horizontal:** 16pt
- **Container Border:** RoundedRectangle (24pt radius)
- **Container Stroke:** Gradient (mint→blue), 1.4pt

#### GLASS CARD 1 - "Devam Et"
| Özellik | Değer |
|---------|-------|
| **Icon** | play.circle.fill (SF Symbol) |
| **Icon Size** | 28pt |
| **Title** | "Devam Et" (headline) |
| **Subtitle** | "Son ders" (caption, secondary) |
| **Material** | .ultraThinMaterial (glassmorphism) |
| **Min Height** | 110pt |
| **Corner Radius** | 16pt |
| **Padding** | 16pt |
| **Border** | Gradient (mint→blue), 1.2pt |
| **Shadow** | radius: 14, y: 8 |

#### GLASS CARD 2 - "SOS"
| Özellik | Değer |
|---------|-------|
| **Icon** | heart.text.square.fill |
| **Icon Size** | 28pt |
| **Title** | "SOS" (headline) |
| **Subtitle** | "Kriz anı yardımı" (caption) |
| **[Diğer özellikler Card 1 ile aynı]** | |

**Kullanım:**
```swift
HStack(spacing: 12) {
    GlassCard(icon: "play.circle.fill", 
              title: "Devam Et", 
              subtitle: "Son ders")
    GlassCard(icon: "heart.text.square.fill", 
              title: "SOS", 
              subtitle: "Kriz anı yardımı")
}
```

---

### 3️⃣ GÖREVLER BÖLÜMÜ
**Dosya:** `LuggmaApp/HomeView.swift` (satır 37-40)

**Section Header:**
- **Component:** `SectionHeader("Görevler")`
- **Font:** Büyük, bold
- **Color:** Beyaz

**Task Rows (3 adet):**

#### Task Row Yapısı
**Dosya:** `LuggmaApp/HomeView.swift` (satır 72-110)
**Component:** `TaskRow`

| Özellik | Değer | Açıklama |
|---------|-------|----------|
| **Layout** | HStack | Yatay düzen |
| **Checkbox** | AnimatedCheckmark | Özel component |
| **Icon** | SF Symbol | 18pt, semibold |
| **Icon Background** | Circle | Gradient (mint→blue) |
| **Icon Frame** | 28x28pt | Sabit boyut |
| **Title** | Body font | Beyaz metin |
| **Padding Yatay** | 16pt | `.padding(.horizontal)` |
| **Border** | RoundedRectangle | Gradient (mint→blue) |
| **Border Width** | 1.5pt | `lineWidth: 1.5` |
| **Shadow** | Mavi gölge | `radius: 10, y: 6` |
| **Corner Radius** | 16pt | Theme varsayılanı |
| **Tap Action** | Checkbox toggle | Spring animasyonu |

**3 Görev:**
1. **"5 dk nefes egzersizi"** - Icon: `wind`
2. **"'Tetikleyiciler' videosunu izle"** - Icon: `play.rectangle`
3. **"Bugün İçin Böyle Dikkat Edelim"** - Icon: `exclamationmark.triangle`

---

### 4️⃣ MOTİVASYON BÖLÜMÜ
**Dosya:** `LuggmaApp/HomeView.swift` (satır 42-45)

**Section Header:**
- **Component:** `SectionHeader("Motivasyon")`

**Task Rows (3 adet):**
1. **"Toplulukta paylaşım yap"** - Icon: `bubble.left.and.exclamationmark`
2. **"Koç notlarını oku"** - Icon: `book.closed`
3. **"Su içmeyi unutma"** - Icon: `drop`

*(Yapı Task Row ile aynı)*

---

### 5️⃣ VİDEO CAROUSEL BÖLÜMÜ
**Dosya:** `LuggmaApp/HomeView.swift` (satır 112-198)
**Component:** `VideoSectionView`

**Container:**
| Özellik | Değer |
|---------|-------|
| **Layout** | VStack |
| **Spacing** | 12pt |
| **TabView Style** | .page (index gizli) |
| **Frame Height** | 180pt |
| **Corner Radius** | 28pt |
| **Auto-scroll** | 4 saniye |
| **Animation** | easeInOut (0.6s) |

**Video Card Yapısı:**
**Component:** `VideoCardView`

| Özellik | Değer | Açıklama |
|---------|-------|----------|
| **Background** | LinearGradient | Kart özel renk paleti |
| **Border** | Beyaz stroke | 1pt, opacity 0.2 |
| **Corner Radius** | 28pt | Yuvarlatılmış köşeler |
| **Padding İçerik** | 22pt | Tüm kenarlar |
| **Shadow** | Gradient son renk | radius: 20, y: 12 |
| **Icon Container** | RoundedRectangle | 18pt radius, glassmorphism |
| **Icon Size** | 28pt | Semibold |
| **Icon Padding** | 12pt | İçerik boşluğu |
| **Title Font** | headline | Beyaz |
| **Subtitle Font** | subheadline | Beyaz 85% opacity |
| **CTA Button** | Capsule | Glassmorphism background |
| **CTA Icon** | play.circle.fill | title3 |
| **CTA Text** | "İzlemeye başla" | callout.bold() |
| **CTA Padding** | 12pt | İçerik |

**6 Video Kartı:**

| # | Title | Subtitle | Icon | Gradient |
|---|-------|----------|------|----------|
| 1 | Nefes Tekniği | 4-7-8 metodunu uygulayalım | lungs.fill | Pembe→Turuncu |
| 2 | Kriz Anı | Koçtan hızlı destek ipuçları | bolt.heart.fill | Mor→İndigo |
| 3 | Hareket Molası | 3 dakikalık esneme rutini | figure.cooldown | Mint→Mavi |
| 4 | Beslenme Tüyosu | Nikotin isteğini azaltan atıştırmalıklar | leaf.fill | Yeşil→Sarı |
| 5 | Topluluk Hikayesi | Bugün bırakmayı başaran Tuğçe'yi dinle | person.3.sequence.fill | Turuncu→Kırmızı |
| 6 | Mindfulness | 2 dakikalık odaklanma egzersizi | brain.head.profile | Cyan→Teal |

---

## 📏 SPACING VE PADDING DEĞERLERİ

### Genel Düzen
- **Ana VStack Spacing:** 24pt
- **Yatay Padding (çoğu element):** 16pt
- **Section başlıkları arası:** 24pt
- **Task Row'lar arası:** Otomatik (VStack default ~8pt)

### Component İçi
- **GlassCard içerik padding:** 16pt
- **GlassCard'lar arası spacing:** 12pt
- **TaskRow içerik padding:** 16pt yatay
- **VideoCard içerik padding:** 22pt
- **Video section spacing:** 12pt

### Safe Area & System
- **Status Bar:** 44pt (sistem)
- **Tab Bar:** 83pt (sistem)
- **Home Indicator:** 34pt (sistem)
- **Safe Area Top:** 44pt
- **Safe Area Bottom:** 117pt (34 + 83)

---

## 🎨 RENK PALETİ

### Gradient Background (Ana Arka Plan)
```swift
Color(red: 0.98, green: 0.25, blue: 0.47) // #F94077 - Pembe
Color(red: 0.99, green: 0.6, blue: 0.23)  // #FC9A3B - Turuncu
Color(red: 0.96, green: 0.83, blue: 0.55) // #F5D48C - Sarı
Color(red: 0.44, green: 0.87, blue: 0.75) // #70DEBF - Turkuaz
Color(red: 0.26, green: 0.74, blue: 0.86) // #42BDDB - Mavi
Color(red: 0.35, green: 0.84, blue: 0.63) // #58D6A0 - Yeşil
```

### Component Renkleri
- **Border Gradient:** `.mint.opacity(0.65)` → `.blue.opacity(0.45)`
- **Icon Gradient:** `.mint.opacity(0.8)` → `.blue.opacity(0.6)`
- **Shadow:** `.blue.opacity(0.25)` veya `.blue.opacity(0.35)`
- **Text Primary:** `.white`
- **Text Secondary:** `.white.opacity(0.85)` veya `.secondary`
- **Glassmorphism:** `.ultraThinMaterial`

---

## 🔧 İNTERAKTİF ELEMANLAR

### 1. Hero Header
- **Tap Action:** Yok (sadece görsel)
- **Durum:** Statik

### 2. Glass Card - "Devam Et"
- **Tap Action:** Derslere yönlendirme (muhtemelen)
- **Icon:** play.circle.fill
- **Hedef:** Son kaldığı ders

### 3. Glass Card - "SOS"
- **Tap Action:** SOS ekranına yönlendirme
- **Icon:** heart.text.square.fill
- **Hedef:** Kriz anı yardım ekranı

### 4. Task Row (Her biri)
- **Tap Action:** Checkbox toggle
- **Animation:** Spring animation
- **State:** `@State private var done = false`
- **Visual Feedback:** AnimatedCheckmark component

### 5. Video Cards
- **Tap Action:** Video oynatma (muhtemelen)
- **Swipe Action:** Yatay kaydırma (TabView)
- **Auto-scroll:** 4 saniyede otomatik değişim
- **Animation:** easeInOut (0.6s)

---

## 📂 DOSYA YAPISI

```
LuggmaApp/
├── HomeView.swift (satır 1-204)
│   ├── HomeView (ana component)
│   ├── SectionHeader (başlık component)
│   ├── TaskRow (görev satırı)
│   ├── VideoSectionView (video carousel)
│   ├── VideoCardView (tek video kartı)
│   └── VideoItem (data model)
│
├── DesignSystem/
│   └── Theme.swift (satır 1-180)
│       ├── LiveTheme (tema yönetimi)
│       ├── GradientBackground
│       ├── HeroHeader
│       ├── GlassCard
│       ├── PrimaryButton
│       └── ShimmerView
│
├── Components/
│   └── AnimatedCheckmark.swift
│       └── AnimatedCheckmark (checkbox animasyonu)
│
└── AppTabView.swift
    └── TabView (alt navigasyon)
```

---

## 🎯 DEĞİŞTİRİLEBİLİR ELEMANLAR

### Kolay Değiştirilebilir:

1. **Hero Header Metinleri** (`HomeView.swift` satır 16-17)
   ```swift
   title: "Merhaba!"
   subtitle: "Bugün duman yok FENAYIZ 💪"
   ```

2. **Glass Card İçerikleri** (`HomeView.swift` satır 30-31)
   ```swift
   GlassCard(icon: "...", title: "...", subtitle: "...")
   ```

3. **Task Row Metinleri** (`HomeView.swift` satır 38-45)
   ```swift
   TaskRow(title: "...", icon: "...")
   ```

4. **Video Kartları** (`HomeView.swift` satır 4-11)
   ```swift
   videoItems: [VideoItem] dizisi
   ```

### Tema Değişiklikleri (`Theme.swift`):

5. **Corner Radius** (satır 5)
   ```swift
   @Published var cardCorner: CGFloat = 16
   ```

6. **Header Yüksekliği** (satır 6)
   ```swift
   @Published var headerHeight: CGFloat = 220
   ```

7. **Gradient Background** (satır 64-79)
   ```swift
   LinearGradient renk değerleri
   ```

8. **Border/Shadow Renkleri** (her component içinde)
   ```swift
   .mint, .blue, .purple gibi renkler
   ```

---

## 🚀 PERFORMANS NOTLARI

- **Video Auto-scroll:** Timer kullanıyor (`Timer.publish(every: 4)`)
- **Animasyonlar:** Spring ve easeInOut animasyonları
- **Glassmorphism:** `.ultraThinMaterial` (GPU-intensive)
- **Gradient Background:** `ignoresSafeArea()` ile tüm ekran
- **ScrollView:** Ana VStack scroll edilebilir (içerik uzunsa)

---

## 📱 RESPONSIVE DAVRANIŞLAR

- **SafeArea:** Tüm elementler safe area içinde
- **Padding:** Kenarlardan 16pt boşluk
- **Tab Bar:** Sistem TabView (otomatik yerleşim)
- **Card Genişlikleri:** `.frame(maxWidth: .infinity)` ile esnek
- **Video Carousel:** Tam genişlik kullanıyor

---

## 🎨 DESIGN SYSTEM

**Material:** iOS glassmorphism (.ultraThinMaterial)  
**Typography:** San Francisco (sistem fontu)  
**Icons:** SF Symbols  
**Shadows:** Yumuşak mavi tonlar  
**Borders:** Gradient stroke'lar  
**Corners:** Tutarlı 16-28pt radius'lar  
**Spacing:** 8, 12, 16, 22, 24pt sistemi

---

## 🔄 DURUM YÖNETİMİ

- **LiveTheme:** `@EnvironmentObject` - Tema değişiklikleri
- **Task Done State:** `@State private var done = false` - Her task row
- **Video Index:** `@State private var currentIndex = 0` - Carousel
- **Timer:** Auto-scroll için SwiftUI Timer

---

## ✅ ÖZET: BİLMEN GEREKENLER

1. **Ana Layout:** VStack (24pt spacing) + ScrollView
2. **5 Ana Bölüm:** Hero + Glass Cards + Görevler + Motivasyon + Video
3. **Renk Sistemi:** Gradient background + mint-blue accent
4. **Etkileşim:** Tap (glass cards, tasks), swipe (video), auto-scroll
5. **Dosyalar:** `HomeView.swift` (ana) + `Theme.swift` (components)
6. **Değiştir:** Metinler, iconlar, renkler, spacing değerleri
7. **Tema:** `LiveTheme` ile global değişiklikler yapılabilir
8. **Tab Bar:** Ana sayfa 6 tab'dan biri (house.fill aktif)

---

**📝 Not:** Bu şema, kodda gördüğün tüm değerlere dayanıyor. Herhangi bir elementi değiştirmek istersen, yukarıdaki dosya/satır bilgilerini kullanabilirsin!

**🎯 Kullanım:** Bu dökümana bakarak uygulamanda neyin nerede olduğunu görebilir ve istediğin değişiklikleri yapabilirsin.


