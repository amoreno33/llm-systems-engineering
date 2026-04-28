# 🧠 Obsidian como "Second Brain" para IA — Ejemplo Práctico

## ¿Por qué Obsidian y no Notion/Confluence?

| Feature | Obsidian | Notion | Confluence |
| :--- | :--- | :--- | :--- |
| **Local-first** | ✅ Archivos `.md` en tu disco | ❌ Nube | ❌ Nube |
| **Links bidireccionales** | ✅ `[[nota]]` | ⚠️ Limitado | ❌ No |
| **Graph View** | ✅ Visualiza relaciones | ❌ No | ❌ No |
| **Funciona offline** | ✅ Siempre | ❌ No | ❌ No |
| **Lo lee la IA local** | ✅ Son `.md` planos | ⚠️ Requiere API | ⚠️ Requiere API |
| **Gratis** | ✅ | ⚠️ Freemium | ❌ Pago |

## Estructura de Vault para un Equipo de Desarrollo

```
📁 mi-vault-equipo/
├── 📁 proyectos/
│   ├── api-pagos.md
│   ├── mobile-app.md
│   └── dashboard-admin.md
├── 📁 arquitectura/
│   ├── decisiones/
│   │   ├── 2025-04-14-refunds-async.md
│   │   ├── 2025-04-16-decimal-js.md
│   │   └── 2025-04-21-no-fastify.md
│   ├── diagramas/
│   │   └── flujo-pagos.canvas
│   └── patrones/
│       ├── retry-con-backoff.md
│       ├── cache-invalidation.md
│       └── idempotency-keys.md
├── 📁 runbooks/
│   ├── deploy-produccion.md
│   ├── rollback-emergencia.md
│   └── investigar-webhook-fallido.md
├── 📁 ia-prompts/
│   ├── claude-md-template.md
│   ├── spec-template.md
│   └── prompts-utiles/
│       ├── code-review.md
│       ├── generar-tests.md
│       └── refactoring-seguro.md
└── 📁 daily/
    ├── 2025-04-28.md
    └── ...
```

## Ejemplo: Nota de Arquitectura con Links

Archivo: `arquitectura/patrones/retry-con-backoff.md`

```markdown
# Retry con Exponential Backoff

## Patrón
Cuando una llamada externa falla (Stripe, AWS, etc), reintentar con delays crecientes.

## Implementación
- Delay base: 1 segundo
- Factor: 2x por intento
- Max intentos: 3
- Jitter: ±500ms aleatorio (evita thundering herd)

## Dónde lo usamos
- [[api-pagos]] → Webhooks de Stripe (ver [[2025-04-23-retry-webhooks]])
- [[mobile-app]] → Push notifications con Firebase
- [[dashboard-admin]] → Export de reportes grandes

## Código de referencia
```typescript
async function withRetry<T>(
  fn: () => Promise<T>,
  maxRetries = 3,
  baseDelay = 1000
): Promise<T> {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (error) {
      if (i === maxRetries - 1) throw error;
      const jitter = Math.random() * 500;
      const delay = baseDelay * Math.pow(2, i) + jitter;
      await new Promise(r => setTimeout(r, delay));
    }
  }
  throw new Error('Unreachable');
}
```

## Errores comunes
- ❌ NO reintentar errores 4xx (son errores del cliente, reintentar no va a cambiar nada)
- ❌ NO reintentar sin jitter (todos los workers reintentan al mismo tiempo → DDoS a tu propio servicio)
- ✅ SÍ loguear cada retry con el intento número y el delay aplicado

## Links relacionados
- [[idempotency-keys]] — Combinar con retry para evitar duplicados
- [[cache-invalidation]] — El retry puede devolver datos cacheados, tener en cuenta
```

## El Poder del Graph View

Cuando tu vault tiene 50+ notas con `[[links]]`, el Graph View de Obsidian te muestra:

```
┌──────────────┐     ┌───────────────────┐     ┌──────────────┐
│  api-pagos   │────▶│ retry-con-backoff  │◀────│  mobile-app  │
└──────┬───────┘     └────────┬──────────┘     └──────────────┘
       │                      │
       ▼                      ▼
┌──────────────┐     ┌───────────────────┐
│ decimal-js   │     │ idempotency-keys  │
└──────────────┘     └───────────────────┘
```

**Esto es un GraphRAG personal.** 
Cuando le pasás tu vault a un agente (o usás plugins como **Smart Connections** o **Copilot for Obsidian**), el agente no solo busca por texto sino que entiende que `retry-con-backoff` está conectado a `api-pagos` y a `idempotency-keys`. 

Eso es información que un RAG basado en vectores **pierde**.

### Preparar tu vault para la demo (10 min):
1. Descargá [Obsidian](https://obsidian.md/) (gratis)
2. Creá un vault nuevo llamado `equipo-dev`
3. Creá 5-6 notas con la estructura de arriba
4. Conectalas con `[[links]]` como en el ejemplo de retry
5. Abrí el Graph View (Ctrl+G) → Eso es lo que mostrás en la charla

### Plugins Recomendados para Integración con IA:
| Plugin | Qué hace | Por qué importa |
| :--- | :--- | :--- |
| **[Copilot](https://github.com/logancyang/obsidian-copilot)** | Chat con IA dentro de Obsidian usando tus notas como contexto | GraphRAG gratis sin infraestructura |
| **[Smart Connections](https://github.com/brianpetro/obsidian-smart-connections)** | Encuentra notas relacionadas semánticamente (no solo por link) | Descubre conexiones que no sabías que existían |
| **[Templater](https://github.com/SilentVoid13/Templater)** | Templates dinámicos con JavaScript | Automatizar la creación de specs y decision logs |

---

## Tip de Presentación: Demo en Vivo

Si querés que este tip brille en la charla:

1. Abrí tu Obsidian con un vault preparado (este ejemplo)
2. Mostrá el Graph View con las líneas de conexión
3. Decí: *"¿Ven estas líneas? Cada una es una decisión de arquitectura que se conecta con nuestro código. Cuando el agente lee esto, entiende el CONTEXTO de nuestro sistema, no solo fragmentos sueltos."*
4. Abrí una nota y mostrá los `[[links]]`
5. Decí: *"Esto es GraphRAG personal. Gratis. Local. Sin tokens."*

La audiencia va a querer instalarlo antes de que termines la frase.
