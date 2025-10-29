import { memo, useMemo, useState } from 'react';
import './components.css';

const badgeToneMap = {
  success: '#22c55e',
  info: '#60a5fa',
  warning: '#f97316',
};

export const SummaryCard = memo(function SummaryCard({ title, body, badge }) {
  return (
    <article className="dsl-card summary-card">
      <header>
        <h2>{title}</h2>
        {badge && (
          <span
            className="badge"
            style={{ backgroundColor: badgeToneMap[badge.tone ?? 'info'] ?? '#64748b' }}
          >
            {badge.label}
          </span>
        )}
      </header>
      <p>{body}</p>
    </article>
  );
});

export const TaskList = memo(function TaskList({ title, tasks = [], onToggle }) {
  const [localState, setLocalState] = useState(
    tasks.reduce((acc, task) => ({ ...acc, [task.id]: task.completed ?? false }), {})
  );

  const handleToggle = (taskId) => {
    setLocalState((prev) => {
      const next = { ...prev, [taskId]: !prev[taskId] };
      onToggle?.(taskId, next[taskId]);
      return next;
    });
  };

  return (
    <article className="dsl-card task-card">
      <header>
        <h3>{title}</h3>
      </header>
      <ul>
        {tasks.map((task) => (
          <li key={task.id}>
            <label>
              <input
                type="checkbox"
                checked={localState[task.id] ?? false}
                onChange={() => handleToggle(task.id)}
              />
              <span>{task.label}</span>
            </label>
          </li>
        ))}
      </ul>
    </article>
  );
});

export const InsightCard = memo(function InsightCard({ title, value, trend }) {
  return (
    <article className="dsl-card insight-card">
      <header>
        <h4>{title}</h4>
      </header>
      <div className="metric">
        <span className="value">{value}</span>
        {trend && <span className={`trend ${trend.direction}`}>{trend.label}</span>}
      </div>
    </article>
  );
});

export const InsightChart = memo(function InsightChart({ title, chartType, series = [], xAxis = [] }) {
  const primarySeries = series[0] ?? { values: [] };
  const path = useMemo(() => {
    if (!primarySeries.values.length) {
      return '';
    }
    const width = 320;
    const height = 140;
    const padding = 12;
    const maxValue = Math.max(...primarySeries.values, 1);
    const step = primarySeries.values.length > 1 ? (width - padding * 2) / (primarySeries.values.length - 1) : 0;

    return primarySeries.values
      .map((value, idx) => {
        const x = padding + idx * step;
        const y = height - padding - (value / maxValue) * (height - padding * 2);
        return `${idx === 0 ? 'M' : 'L'} ${x.toFixed(2)} ${y.toFixed(2)}`;
      })
      .join(' ');
  }, [primarySeries.values]);

  return (
    <article className="dsl-card chart-card">
      <header>
        <h4>{title}</h4>
      </header>
      <svg width="100%" height="140" viewBox="0 0 320 140" preserveAspectRatio="none">
        <path d={path} fill="none" stroke="url(#chartGradient)" strokeWidth="2.5" strokeLinecap="round" />
        <defs>
          <linearGradient id="chartGradient" x1="0%" y1="0%" x2="0%" y2="100%">
            <stop offset="0%" stopColor="#22d3ee" />
            <stop offset="100%" stopColor="#1d4ed8" />
          </linearGradient>
        </defs>
      </svg>
      {xAxis.length > 0 && (
        <div className="chart-x-axis">
          {xAxis.map((label) => (
            <span key={label}>{label}</span>
          ))}
        </div>
      )}
    </article>
  );
});

export const CtaCard = memo(function CtaCard({ title, body, primaryAction, secondaryAction, onAction }) {
  const trigger = (action) => {
    if (action?.action) {
      onAction?.(action);
    }
  };

  return (
    <article className="dsl-card cta-card">
      <header>
        <h3>{title}</h3>
      </header>
      <p>{body}</p>
      <div className="cta-actions">
        {primaryAction && (
          <button className="primary" onClick={() => trigger(primaryAction)}>
            {primaryAction.label}
          </button>
        )}
        {secondaryAction && (
          <button className="secondary" onClick={() => trigger(secondaryAction)}>
            {secondaryAction.label}
          </button>
        )}
      </div>
    </article>
  );
});

export const ContentList = memo(function ContentList({ title, items = [], onAction }) {
  return (
    <article className="dsl-card content-card">
      <header>
        <h3>{title}</h3>
      </header>
      <ul>
        {items.map((item) => (
          <li key={item.id ?? item.title}>
            <div>
              <strong>{item.title}</strong>
              {item.subtitle && <p>{item.subtitle}</p>}
            </div>
            {item.action && (
              <button onClick={() => onAction?.(item.action)} className="ghost">
                {item.action.label ?? 'Aç'}
              </button>
            )}
          </li>
        ))}
      </ul>
    </article>
  );
});

export const NoteCard = memo(function NoteCard({ tone = 'info', body }) {
  return (
    <article className={`dsl-card note ${tone}`}>
      <p>{body}</p>
    </article>
  );
});

export function ComponentRenderer({ component, onAction }) {
  switch (component.type) {
    case 'summary-card':
      return <SummaryCard {...component.props} />;
    case 'task-list':
      return (
        <TaskList
          {...component.props}
          onToggle={(id, completed) =>
            onAction?.({
              label: completed ? 'Görev tamamlandı' : 'Görev geri alındı',
              action: { type: 'task_toggle', payload: { id, completed } },
            })
          }
        />
      );
    case 'insight-card':
      return <InsightCard {...component.props} />;
    case 'insight-chart':
      return <InsightChart {...component.props} />;
    case 'cta-card':
      return (
        <CtaCard
          {...component.props}
          onAction={(actionPayload) =>
            onAction?.({
              label: actionPayload.label ?? 'cta',
              action: actionPayload.action,
            })
          }
        />
      );
    case 'content-list':
      return (
        <ContentList
          {...component.props}
          onAction={(action) =>
            onAction?.({
              label: action.label ?? action.type ?? 'content-action',
              action: action.action ?? action,
            })
          }
        />
      );
    case 'note':
    default:
      return <NoteCard {...component.props} />;
  }
}
