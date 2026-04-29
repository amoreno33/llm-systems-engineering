# 🧠 Obsidian como "Second Brain" para IA — Ejemplo Práctico

## El problema que resuelve

Cada sesión con un agente empieza desde cero. El agente no sabe qué decisiones tomaste la semana pasada, qué tecnologías descartaste ni por qué el carrito vive en Redis y no en la base de datos. Tenés que re-explicar el contexto cada vez, y con el tiempo ese contexto se degrada o se pierde.

Obsidian resuelve esto actuando como la **memoria persistente del proyecto**: un conjunto de archivos `.md` locales, conectados entre sí con links bidireccionales, que el agente puede leer directamente como contexto en cada sesión.

Es la solución práctica para equipos o desarrolladores individuales que trabajan con sesiones sueltas sin un framework estructurado. En lugar de explicarle al agente "no uses Fastify porque lo rechazamos en el Sprint 3", tenés una nota `decisiones/no-fastify.md` que el agente lee antes de empezar.

> **Obsidian es la memoria de largo plazo del proyecto. El agente es stateless; Obsidian no lo es.**

---

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

### Configurar tu vault (10 min):
1. Descargá [Obsidian](https://obsidian.md/) (gratis)
2. Creá un vault nuevo llamado `equipo-dev`
3. Creá 5-6 notas con la estructura de arriba
4. Conectalas con `[[links]]` como en el ejemplo de retry
5. Abrí el Graph View (Ctrl+G) para visualizar las relaciones

### Plugins Recomendados para Integración con IA:
| Plugin | Qué hace | Por qué importa |
| :--- | :--- | :--- |
| **[Copilot](https://github.com/logancyang/obsidian-copilot)** | Chat con IA dentro de Obsidian usando tus notas como contexto | GraphRAG gratis sin infraestructura |
| **[Smart Connections](https://github.com/brianpetro/obsidian-smart-connections)** | Encuentra notas relacionadas semánticamente (no solo por link) | Descubre conexiones que no sabías que existían |
| **[Templater](https://github.com/SilentVoid13/Templater)** | Templates dinámicos con JavaScript | Automatizar la creación de specs y decision logs |


