# Kullanıcı Akışları

Mermaid diyagram ve detay adımlar için 02 ve 06 dosyalarına bakınız.  
Bu dosya, uygulamadaki ana akışların özetini ve kenar durumlarını içerir.

## 1) Onboarding → Plan Oluşturma
1. Kullanıcı uygulamayı ilk kez açar.
2. Splash ekranı ve KVKK/Tıbbi uyarı modal'ları gösterilir.
3. Apple ile giriş ya da e-posta + OTP akışı tamamlanır.
4. Yaş doğrulama (18+) ve açık rıza alınır.
5. 60-90 sn değerlendirme soruları: tetikleyiciler, bırakma tarihi, motivasyon, alışkanlıklar.
6. Sonuç ekranında **Bırakma Planım** özeti sunulur; bildirim izni istenir.
7. Kullanıcı Dashboard/HomeView'e yönlendirilir; plan görevlere ayrıştırılmıştır.

**Kenar durumları:**
- Giriş reddedilirse: misafir modu yok, akış tekrar giriş ekranına döner.
- Bildirim izni reddi: e-posta/iç bildirimle hatırlatma ayarlanır.
- Değerlendirme yarıda bırakılırsa: ilerleme cihazda cache; 24 saat içinde tamamlanmadıysa yeniden başlatılır.

## 2) Eğitim Modülü (Ders İzleme)
1. Kullanıcı Dashboard'dan önerilen dersi seçer.
2. Ders ekranı video/okuma sekmeleriyle açılır; video oynatıcı HLS kaynaklıdır.
3. İzleme sırasında ilerleme otomatik kayıt edilir; quiz varsa ders sonunda açılır.
4. Tamamlanan ders, kullanıcının planına “bitti” olarak düşer; premium ders ise erişim kontrolü yapılır.

**Kenar durumları:**
- Video ağ hatası: yeniden dene butonu, fallback olarak metin özeti önerilir.
- Premium ders erişim isteği: upsell modal → RevenueCat paywall.
- Quiz atlanırsa: ders kısmi tamamlanmış sayılır; tekrar hatırlatma gönderilir.

## 3) Kriz Anı SOS
1. HomeView'de SOS kartına dokunulur veya sistem bildiriminden açılır.
2. Akış üç adımdır: nefes egzersizi → dikkat dağıtıcı micro görev → yeniden çerçeveleme mesajı.
3. Her adım tamamlama sonrası ilerleme çubuğu güncellenir.
4. Son adımda kullanıcıdan durumunu değerlendirmesi istenir (1-5 ölçek).
5. Başarısız/olumsuz cevaplarda koç araması teklif edilir; randevu ya da anlık çağrı.

**Kenar durumları:**
- Adım sırasında uygulama arka plana giderse: geri dönüldüğünde kaldığı adıma döner.
- Kullanıcı SOS'u iptal ederse: ana ekrana dönülür, plan görevlerine "denendi" notu düşer.
- İnternet yoksa: offline nefes/dikkat içerikleri lokal cache'den sunulur.

## 4) Koç Araması
1. Kullanıcı SOS sonrası veya plan kartından koç aramasını başlatır.
2. "Şimdi bağlan" seçilirse: Twilio çağrısı başlatılır, kullanıcı bekleme ekranında tutulur.
3. Zaman planlanırsa: kullanıcı tarih/saat seçer, onay e-postası + push.
4. Görüşme tamamlanınca koç notları paneli açılır; kullanıcı onaylarsa planına görev eklenir.

**Kenar durumları:**
- Twilio çağrısı bağlanmazsa: 2. deneme otomatik yapılır; başarısız olursa destek e-postası.
- Zamanlama çakışması: takvim conflict bildirimi, alternatif saat önerisi.
- Kullanıcı planlanan görüşmeyi iptal ederse: 1 saat öncesine kadar cezasız, aksi halde dakika kotasından düşer.

## 5) Topluluk Paylaşımı
1. Kullanıcı Topluluk sekmesinde "Yeni Gönderi" butonuna dokunur.
2. Metin girer, en fazla 4 görsel yükler; konum etiketi isteğe bağlı.
3. Gönderi paylaşılır, feed'e düşer; moderasyon kuyruğuna paralel iletilir.
4. Diğer kullanıcılar beğenir/yorumlar; bildirimler tetiklenir.

**Kenar durumları:**
- İçerik yönerge ihlali şüphesi: otomatik filtre, mod onayı beklenir.
- Medya yükleme başarısız: sıkıştırma sonrası 3 kez retry, ardından kullanıcıya hata mesajı.
- Kullanıcı konum paylaştıysa ve izin yoksa: konum alanı pasifleşir.

## 6) Premium Satın Alma
1. Kullanıcı premium içeriğe tıklayınca paywall açılır (RevenueCat).
2. Abonelik planı seçilir, App Store IAP tamamlanır.
3. Kullanıcıya başarı mesajı, premium rozet ve yeni görevler açılır.
4. Backend'e abonelik yenileme bilgisi düşer; B2B kupon varsa kayıt edilir.

**Kenar durumları:**
- Ödeme reddedilirse: hata mesajı + tekrar dene/geri bildirim formu.
- Kullanıcı iptal talep ederse: Apple yönlendirmesi + uygulamada iptal bilgisi.
- Kupon geçersiz: nedenleri (süre dolmuş, limit dolmuş) açıklanır.

## 7) E-Ticaret Siparişi
1. Shop sekmesinde ürün seçilir, sepet oluşturulur.
2. Teslimat adresi, kargo ve ödeme yöntemi seçilir.
3. Ödeme Iyzico/Stripe üzerinden tamamlanır, webhook ile onay alınır.
4. Sipariş durumu (hazırlanıyor, kargoda, teslim) kullanıcının profilinde izlenir.

**Kenar durumları:**
- Ödeme hatası: kart reddi, 3D Secure, bakiye yetersiz mesajları ayrıştırılır.
- Stokta yok: kullanıcıya haber ver, bekleme listesi veya alternatif ürün öner.
- İade talebi: destek formu, iade politikası ve fiziki ürün kargo etiketi.

## 8) Hesap Silme
1. Profil ayarlarından "Hesabı Sil" seçilir.
2. Kullanıcıdan doğrulama (OTP veya parola) istenir.
3. Silme onayı sonrası 30 günlük bekleme süreci başlar; kullanıcı bilgilendirilir.
4. 30 gün sonunda kişisel veriler kalıcı silinir (sipariş/fatura yasal saklama hariç).

**Kenar durumları:**
- Kullanıcı bekleme sürecinde giriş yaparsa: silme işlemi iptal/hızlandırma seçenekleri sunulur.
- B2B kullanıcıysa: işveren bilgilendirmesi ve transfer prosedürü tetiklenir.
- Açık sipariş varsa: silme talebi askıya alınır, destek ekibi iletişime geçer.
