import { useCallback, useEffect, useMemo, useState } from 'react';
import './App.css';
import { ComponentRenderer } from './dsl/components.jsx';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL ?? 'http://localhost:4000';

const DEFAULT_CONTEXT = {
  user: {
    name: 'Atilla',
    smokeFreeDays: 6,
    triggers: ['iş stresi', 'akşam kahvesi'],
    goal: 'Bu hafta 7 sigarasız gün',
  },
  sentiment: 'fragile',
  locale: 'tr-TR',
  recentTasks: [],
};

export default function App() {
  const [context, setContext] = useState(DEFAULT_CONTEXT);
  const [userPrompt, setUserPrompt] = useState('Bugün iş stresimi yönetmek istiyorum.');
  const [dsl, setDsl] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [lastAction, setLastAction] = useState(null);

  const fetchDashboard = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch(`${API_BASE_URL}/api/dsl`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ context, userPrompt }),
      });

      if (!response.ok) {
        throw new Error('Koç arayüzü alınamadı.');
      }

      const data = await response.json();
      setDsl(data);
    } catch (err) {
      setError(err.message ?? 'Bilinmeyen hata');
    } finally {
      setLoading(false);
    }
  }, [context, userPrompt]);

  useEffect(() => {
    fetchDashboard();
  }, [fetchDashboard]);

  const handleAction = useCallback(async (actionPayload) => {
    setLastAction({
      timestamp: new Date().toISOString(),
      payload: actionPayload,
    });

    try {
      await fetch(`${API_BASE_URL}/api/actions`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(actionPayload),
      });
    } catch (err) {
      console.warn('Aksiyon backend ile paylaşılamadı.', err);
    }
  }, []);

  const headerMessage = useMemo(() => {
    switch (context.sentiment) {
      case 'fragile':
        return 'Bugün biraz destek odaklı ilerleyelim 💙';
      case 'motivated':
        return 'Enerjin yüksek, ritmini koruyalım! ⚡️';
      default:
        return 'İstikrarlı ilerliyorsun, birlikte planlayalım 🙌';
    }
  }, [context.sentiment]);

  const sourceBadge = useMemo(() => {
    if (!dsl?.meta?.source) return null;
    const map = {
      llm: { label: 'LLM', className: 'badge llm' },
      mock: { label: 'Mock', className: 'badge mock' },
      fallback: { label: 'Fallback', className: 'badge fallback' },
    };
    return map[dsl.meta.source] ?? { label: dsl.meta.source, className: 'badge mock' };
  }, [dsl]);

  return (
    <div className="app-shell">
      <header className="app-header">
        <h1>LUGGMA Koç Panosu</h1>
        <p>{headerMessage}</p>
        {sourceBadge && <span className={sourceBadge.className}>{sourceBadge.label}</span>}
      </header>

      <section className="control-panel">
        <div className="control-group">
          <label htmlFor="sentiment">Mood</label>
          <select
            id="sentiment"
            value={context.sentiment}
            onChange={(event) =>
              setContext((prev) => ({ ...prev, sentiment: event.target.value }))
            }
          >
            <option value="fragile">Destek ihtiyacı</option>
            <option value="stable">Dengeli</option>
            <option value="motivated">Motivasyonu yüksek</option>
          </select>
        </div>

        <div className="control-group">
          <label htmlFor="smokeFreeDays">Sigarasız gün</label>
          <input
            id="smokeFreeDays"
            type="number"
            min="0"
            max="60"
            value={context.user.smokeFreeDays}
            onChange={(event) =>
              setContext((prev) => ({
                ...prev,
                user: { ...prev.user, smokeFreeDays: Number(event.target.value ?? 0) },
              }))
            }
          />
        </div>

        <div className="control-group full">
          <label htmlFor="prompt">Koça not / istek</label>
          <textarea
            id="prompt"
            rows={2}
            value={userPrompt}
            onChange={(event) => setUserPrompt(event.target.value)}
            placeholder="Bugün nasıl destek istersin?"
          />
        </div>

        <button className="refresh-button" onClick={fetchDashboard} disabled={loading}>
          {loading ? 'Yükleniyor...' : 'Planı güncelle'}
        </button>
      </section>

      {error && <div className="error-banner">{error}</div>}

      <section className="component-grid">
        {dsl?.components?.map((component, index) => (
          <ComponentRenderer
            key={`${component.type}-${index}`}
            component={component}
            onAction={handleAction}
          />
        ))}
        {loading && <div className="loading-card">Koç önerileri hazırlanıyor...</div>}
        {!loading && (!dsl || dsl.components?.length === 0) && (
          <div className="loading-card">Şu an gösterilecek içerik bulunamadı.</div>
        )}
      </section>

      {lastAction && (
        <footer className="action-log">
          <strong>Son aksiyon:</strong>
          <span>{lastAction.payload.label ?? lastAction.payload.action?.type}</span>
        </footer>
      )}
    </div>
  );
}
