import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import { z } from 'zod';

const app = express();
const port = process.env.PORT ?? 4000;

const ComponentTypeSchema = z.union([
  z.literal('summary-card'),
  z.literal('task-list'),
  z.literal('insight-card'),
  z.literal('insight-chart'),
  z.literal('cta-card'),
  z.literal('content-list'),
  z.literal('note'),
]);

const ActionSchema = z.object({
  label: z.string(),
  action: z.object({
    type: z.string().min(1),
    payload: z.record(z.any()).optional(),
  }),
});

const ComponentSchema = z.object({
  type: ComponentTypeSchema,
  props: z.record(z.any()),
});

const DSLResponseSchema = null;

app.use(
  cors({
    origin: process.env.CORS_ORIGIN ?? '*',
    methods: ['GET', 'POST', 'OPTIONS'],
  })
);
app.use(express.json({ limit: '1mb' }));

app.get('/health', (_req, res) => {
  res.json({ ok: true, service: 'dsl-backend', time: new Date().toISOString() });
});

app.post('/api/actions', (req, res) => {
  const parsed = ActionSchema.safeParse(req.body);
  if (!parsed.success) {
    console.warn('[action] rejected payload', parsed.error.flatten());
    return res.status(400).json({ error: 'Invalid action payload' });
  }

  console.log('[action]', parsed.data);
  // TODO: Koç araması planlama vb. gerçek entegrasyonlar
  return res.json({ ok: true });
});

const IncomingContextSchema = z.object({
  user: z
    .object({
      name: z.string().optional(),
      smokeFreeDays: z.number().optional(),
      triggers: z.array(z.string()).optional(),
      goal: z.string().optional(),
    })
    .default({}),
  sentiment: z.enum(['stable', 'fragile', 'motivated']).default('stable'),
  locale: z.string().default('tr-TR'),
  recentTasks: z
    .array(
      z.object({
        id: z.string(),
        label: z.string().optional(),
        completed: z.boolean().optional(),
      })
    )
    .default([]),
});

app.post('/api/dsl', async (req, res) => {
  const defaults = {
    sentiment: 'stable',
    locale: 'tr-TR',
    user: {},
    recentTasks: [],
  };

  const payload = req.body ?? {};
  const contextInput =
    payload && typeof payload.context === 'object' && payload.context !== null ? payload.context : {};
  const context = {
    ...defaults,
    ...contextInput,
    user: {
      ...(contextInput.user ?? {}),
    },
    recentTasks: Array.isArray(contextInput.recentTasks) ? contextInput.recentTasks : [],
  };

  const userPrompt =
    typeof payload.userPrompt === 'string' && payload.userPrompt.trim().length > 0
      ? payload.userPrompt.trim()
      : undefined;

  let generated = null;
  if (process.env.OPENAI_API_KEY) {
    generated = await generateWithOpenAI(context, userPrompt).catch((err) => {
      console.error('[dsl] OpenAI generation failed', err);
      return null;
    });
  }

  const dashboard = generated ?? buildMockDashboard(context, userPrompt);

  res.json(dashboard);
});

function buildMockDashboard(context, userPrompt) {
  const safeContext = context ?? {};
  const safeUser = safeContext.user ?? {};
  const recentTasks = Array.isArray(safeContext.recentTasks) ? safeContext.recentTasks : [];
  const smokeFreeDays = safeUser.smokeFreeDays ?? 0;
  const triggers = Array.isArray(safeUser.triggers) ? safeUser.triggers : [];
  const name = safeUser.name ?? 'Koç Dostu';
  const goal = safeUser.goal ?? 'Bugünü duman-sız tamamlamak';
  const sentiment = safeContext.sentiment ?? 'stable';

  const heroBody =
    sentiment === 'fragile'
      ? `Bugün destek odaklı ilerleyelim. ${triggers[0] ? `${triggers[0]} tetikleyicisi için` : ''} derin nefes egzersizini dene.`
      : sentiment === 'motivated'
        ? `Harika gidiyorsun ${name}! ${goal} hedefine çok yaklaştın. Ritmini koruyalım.`
        : `${goal} hedefin için istikrarlı ilerliyorsun. Hazırsan mini görevleri tamamla.`;

  const taskBase = [
    {
      id: 'breathing',
      label: '5 dk 4-7-8 nefes egzersizi yap',
      completed: recentTasks.some((t) => t.id === 'breathing' && t.completed),
    },
    {
      id: 'journal',
      label: '1 tetikleyici not et ve alternatif davranış yaz',
      completed: recentTasks.some((t) => t.id === 'journal' && t.completed),
    },
  ];

  if (sentiment === 'fragile') {
    taskBase.unshift({
      id: 'sos',
      label: 'Kriz anı SOS adımlarını gözden geçir',
      completed: recentTasks.some((t) => t.id === 'sos' && t.completed),
    });
  } else if (sentiment === 'motivated') {
    taskBase.push({
      id: 'share',
      label: 'Toplulukta motivasyon mesajı paylaş',
      completed: recentTasks.some((t) => t.id === 'share' && t.completed),
    });
  }

  const components = [
    {
      type: 'summary-card',
      props: {
        title: sentiment === 'motivated' ? 'Devam! Bugün çok güçlüsün 💪' : 'Bugünün odağı',
        body: heroBody,
        badge: { label: `${smokeFreeDays} gün sigarasız`, tone: smokeFreeDays >= 7 ? 'success' : 'info' },
      },
    },
    {
      type: 'task-list',
      props: {
        title: 'Günün görevleri',
        tasks: taskBase.slice(0, 4),
      },
    },
    {
      type: 'insight-chart',
      props: generateChartProps(smokeFreeDays),
    },
  ];

  const ctaCard = buildCtaCard(sentiment, triggers[0]);
  if (ctaCard) {
    components.push(ctaCard);
  }

  if (userPrompt) {
    components.push({
      type: 'note',
      props: {
        tone: 'info',
        body: `İstek notu: ${userPrompt}`,
      },
    });
  }

  return {
    version: '0.1',
    layout: 'dashboard',
    meta: {
      locale: safeContext.locale ?? 'tr-TR',
      tone: sentiment,
      source: safeContext.source ?? 'mock',
    },
    components,
  };
}

function generateChartProps(smokeFreeDays) {
  const base = Math.max(smokeFreeDays - 6, 0);
  const values = Array.from({ length: 7 }, (_, idx) => Math.max(base + idx, 0));
  const capped = values.map((val) => Math.min(val, smokeFreeDays));

  return {
    title: 'Sigara içmeden geçen gün sayısı',
    chartType: 'line',
    series: [
      {
        label: 'Sigarasız gün',
        values: capped,
      },
    ],
    xAxis: ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'],
  };
}

function buildCtaCard(sentiment, primaryTrigger) {
  if (sentiment === 'fragile') {
    return {
      type: 'cta-card',
      props: {
        title: 'Destek ister misin?',
        body: primaryTrigger
          ? `Son tetikleyici: ${primaryTrigger}. Koçunla 5 dakikalık bir görüşme morale iyi gelir.`
          : 'Koçunla kısa bir görüşme planlamak isteyebilir misin?',
        primaryAction: {
          label: 'Koç araması planla',
          action: { type: 'call_coach', payload: { urgency: 'high' } },
        },
        secondaryAction: {
          label: 'Nefes pratiği aç',
          action: { type: 'open_lessons', payload: { lessonId: 'breathing-101' } },
        },
      },
    };
  }

  if (sentiment === 'motivated') {
    return {
      type: 'cta-card',
      props: {
        title: 'Motivasyonunu paylaş',
        body: 'Toplulukta bugün neler öğrendiğini paylaşarak başkalarına da ilham ol!',
        primaryAction: {
          label: 'Topluluğa yaz',
          action: { type: 'open_community_post' },
        },
        secondaryAction: {
          label: 'Koç notlarını görüntüle',
          action: { type: 'open_notes' },
        },
      },
    };
  }

  return {
    type: 'cta-card',
    props: {
      title: 'Bir sonraki adımın hazır',
      body: 'Takıldığın anlarda koç desteği veya mini dersleri kullanabilirsin.',
      primaryAction: {
        label: 'Koç çağır',
        action: { type: 'call_coach', payload: { urgency: 'medium' } },
      },
    },
  };
}

function minimalFallback() {
  return {
    version: '0.1',
    layout: 'dashboard',
    meta: { locale: 'tr-TR', tone: 'info', source: 'fallback' },
    components: [
      {
        type: 'note',
        props: {
          tone: 'warning',
          body: 'Şu anda öneri üretemedik. Lütfen daha sonra tekrar dene.',
        },
      },
    ],
  };
}

app.listen(port, () => {
  console.log(`DSL server listening on http://localhost:${port}`);
});

const OPENAI_MODEL = process.env.OPENAI_MODEL ?? 'gpt-4o-mini';
const openaiKey = process.env.OPENAI_API_KEY;

async function generateWithOpenAI(context, userPrompt) {
  if (!openaiKey) return null;

  const promptContext = JSON.stringify(
    {
      context,
      userPrompt,
      instructions:
        'Ürettiğin JSON belirtilen schema ile birebir uyumlu olmalı. Açıklama ekleme.',
    },
    null,
    2
  );

  const schema = {
    name: 'luggma_dashboard',
    schema: {
      type: 'object',
      additionalProperties: false,
      properties: {
        version: { type: 'string', enum: ['0.1'] },
        layout: { type: 'string', enum: ['dashboard'] },
        meta: {
          type: 'object',
          additionalProperties: false,
          properties: {
            locale: { type: 'string' },
            tone: { type: 'string' },
            theme: { type: 'string' },
            source: { type: 'string' },
          },
        },
        components: {
          type: 'array',
          minItems: 1,
          items: {
            type: 'object',
            additionalProperties: false,
            properties: {
              type: { type: 'string', enum: SUPPORTED_COMPONENTS },
              props: { type: 'object' },
            },
            required: ['type', 'props'],
          },
        },
      },
      required: ['version', 'layout', 'components'],
    },
  };

  const response = await fetch('https://api.openai.com/v1/responses', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${openaiKey}`,
    },
    body: JSON.stringify({
      model: OPENAI_MODEL,
      input: [
        {
          role: 'system',
          content:
            'You are a UI reasoning engine that outputs JSON dashboards for a quit smoking coach app. Always return valid JSON following the given schema. Keep tone warm and encouraging in Turkish.',
        },
        {
          role: 'user',
          content: promptContext,
        },
      ],
      response_format: {
        type: 'json_schema',
        json_schema: schema,
      },
    }),
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`OpenAI API error: ${text}`);
  }

  const json = await response.json();
  const parsed = JSON.parse(json.output_text ?? json.output?.[0]?.content?.[0]?.text ?? '{}');
  parsed.meta = { ...(parsed.meta ?? {}), source: 'llm' };
  return parsed;
}
