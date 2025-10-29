# Generative UI DSL Tasarımı

> **Amaç:** LUGGMA koç deneyiminde LLM çıktılarının tek tip ve render edilebilir bir JSON şemasına dönmesini sağlamak.

## 1) DSL Şeması (v0)
```jsonc
{
  "version": "0.1",
  "layout": "dashboard",
  "meta": {
    "locale": "tr-TR",
    "tone": "warm"
  },
  "components": [
    {
      "type": "summary-card",
      "props": {
        "title": "Günün Odak Noktası",
        "body": "Bugün iş stresini yönetmek için 4-7-8 nefes tekniğini dene.",
        "badge": { "label": "6 gün sigarasız", "tone": "success" }
      }
    },
    {
      "type": "task-list",
      "props": {
        "title": "Günün Görevleri",
        "tasks": [
          { "id": "breath", "label": "5 dk nefes egzersizi", "completed": false },
          { "id": "coach_note", "label": "Koç notlarını tekrar oku", "completed": true }
        ]
      }
    },
    {
      "type": "insight-chart",
      "props": {
        "title": "Son 7 Gün",
        "chartType": "line",
        "series": [
          { "label": "Sigarasız Gün", "values": [4,5,6,6,6,6,6] }
        ],
        "xAxis": ["Pzt","Sal","Çar","Per","Cum","Cmt","Paz"]
      }
    },
    {
      "type": "cta-card",
      "props": {
        "title": "Destek mi lazım?",
        "body": "Koçunla hızlıca kısa bir görüşme ayarla.",
        "primaryAction": { "label": "Koç araması planla", "action": { "type": "call_coach" } },
        "secondaryAction": { "label": "Daha sonra hatırlat", "action": { "type": "remind_later" } }
      }
    }
  ]
}
```

### Bileşen Tipleri
| type | Açıklama | Zorunlu Alanlar |
| --- | --- | --- |
| `summary-card` | Üst kısımda hero kartı | `title`, `body` |
| `task-list` | Checkbox görev listesi | `tasks[]` (`id`, `label`, `completed`) |
| `insight-card` | Kısa metrik | `title`, `value`, `trend` |
| `insight-chart` | Mini grafik | `chartType`, `series[]`, `xAxis[]` |
| `cta-card` | CTA butonları | `primaryAction` |
| `content-list` | Link/kart listesi | `items[]` |
| `note` | Bilgi/uyarı kutusu | `tone`, `body` |

### Aksiyon Şeması
```json
{
  "label": "Koç araması planla",
  "action": {
    "type": "call_coach",
    "payload": { "urgency": "high" }
  }
}
```

## 2) Prompt Kuralları (LLM için)
- “Yanıtlarını **yalnızca geçerli JSON** olarak ver. Markdown, açıklama, doğal dil ekleme.”
- `version`, `layout`, `components` alanlarını zorunlu tut.
- Her bileşen için `type` değeri yukarıdaki tablodan biri olmalı.
- Görev listesi max 4 madde, CTA en fazla 1 birincil + 1 ikincil.
- Örnek prompt:
```
Sistem: Aşağıdaki şemaya uygun JSON üret. {...}
Kullanıcı: 
{
  "user": { "name": "Atilla", "smokeFreeDays": 6, "triggers": ["iş stresi"], "goal": "Bu hafta 7 gün" },
  "sentiment": "fragile",
  "recentTasks": [{"id":"breath","completed":false}]
}
```

## 3) Guardrail Notları
- Backend: JSON.parse → Zod şeması → geçmezse `fallback` mesajı gönder.
- Yanıt boşsa: `components: [{ "type": "note", "props": { "tone": "warning", "body": "Şu an öneri yok." } }]`
- Aksiyonlar loglanmalı; üretim öncesi beyaz liste (only `call_coach`, `open_lessons`, `open_shop`).

## 4) Frontend Render Sözleşmesi
- Her bileşen `ComponentRenderer[type]` tablosundan bulunur.
- Desteklenmeyen tip → `Note` bileşeni gösterip hata logla.
- `onAction(action)` callback’i ile ebeveyne haber ver.

## 5) Iterasyon Planı
1. v0: summary + tasks + CTA (line chart opsiyonel).
2. v0.1: form bileşeni (`type: "form"`, schema).
3. v0.2: topluluk içeriği (`type: "content-list"`).
4. Kullanıcı testlerinden sonra ton/renk varyasyonları (`meta.theme = "calm" | "energetic"`).
