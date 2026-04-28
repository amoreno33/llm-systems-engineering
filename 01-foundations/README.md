# 🧬 Foundations: Lo Que Necesitás Saber Para Entender Por Qué Tu Agente Hace Lo Que Hace

No es necesario saber entrenar un Transformer. Pero sí entender las 4 cosas que afectan directamente tu trabajo diario con IA.

## 🪙 Los Tokens: Tu Unidad de Costo

Los modelos no leen palabras, leen **tokens** (fragmentos de caracteres). Todo el pricing, los límites y la performance se miden en tokens.

Dato clave que pocos saben:
> **El español es ~30% más caro que el inglés.** La palabra "autenticación" puede ser 1 token en inglés ("authentication") pero 3-4 tokens en español. Esto significa que tu ventana de contexto se llena más rápido y pagás más por la misma información.

Verificalo vos mismo: [OpenAI Tokenizer](https://platform.openai.com/tokenizer)

### Ventanas de Contexto Actuales (2025):
| Modelo | Context Window | Costo aprox. input (1M tokens) |
| :--- | :--- | :--- |
| GPT-4o | 128k tokens | $2.50 |
| Claude 3.5 Sonnet | 200k tokens | $3.00 |
| Gemini 1.5 Pro | 2M tokens | $1.25 |
| Llama 3.1 405B | 128k tokens | Self-hosted |

## 🌡️ Temperature: No hace lo que pensás


**Temperature 0 NO es determinístico.** Incluso con temperature=0, puede haber variaciones por sampling, batching y hardware. Para reproducibilidad real necesitás `temperature=0` + `seed` parameter + `top_p=1`.

*Fuente: [OpenAI API Reference](https://platform.openai.com/docs/guides/text-generation)*

### Guía rápida:
- **0.0 - 0.2:** Tareas determinísticas (code generation, extracción de datos). Lo que usás el 90% del tiempo en vibe coding.
- **0.3 - 0.7:** Tareas creativas con cierto control (copywriting, brainstorming acotado).
- **0.8 - 1.0:** Exploración creativa libre. Rara vez útil en producción.

> **¿Dónde se configura la temperature?**
> - **Cursor:** En Settings > LLM > Advanced podés ajustar temperature.
> - **Antigravity:** Permite modificar temperature en la configuración avanzada del proyecto o prompt.
> - **VS Code con Copilot:** **No permite configurar temperature manualmente.** Copilot usa valores internos optimizados para cada tarea (chat, autocompletado, etc.), y no es posible cambiarlos desde la interfaz. 

## ⚖️ Modelos Grandes vs Pequeños: Cuándo Usar Cada Uno

No siempre el modelo más grande es el mejor. La regla es simple:

| Situación | Modelo recomendado | Por qué |
| :--- | :--- | :--- |
| Razonamiento complejo, código difícil | Claude 3.5 Sonnet / GPT-4o | Necesitás capacidad de razonamiento superior. |
| Clasificación, extracción, formateo | Llama 3 8B / Phi-3 / Gemma | Más rápido, más barato, suficiente calidad. |
| Validación o scoring de outputs | Modelo pequeño (SLM) | El resultado del grande se valida con uno barato. |
| Embeddings para RAG | text-embedding-3-small | Especializado y económico. No necesitás un LLM para esto. |

## 🔀 Model Routing: No uses un Ferrari para ir al kiosco

La tendencia más fuerte de 2025 es el **Model Routing** — una capa intermedia que decide automáticamente qué modelo debe responder cada request según la complejidad de la tarea.

### ¿Por qué importa?
Usar Claude 3.5 Sonnet ($3/M tokens) para clasificar si un email es spam es como usar un Ferrari para ir a 2 cuadras. El resultado es el mismo con GPT-4o Mini ($0.15/M tokens) → **20 veces más barato**.

### Cómo funciona en práctica:
```
Request llega al sistema
    │
    ▼
┌──────────────────────────────┐
│  ROUTER (clasifica complejidad)│
│  Opciones:                    │
│  • Rule-based (if/else)       │
│  • LLM-as-Judge (modelo tiny) │
│  • Fallback Chain             │
└──────────┬───────────────────┘
           │
    ┌──────┼──────┐
    ▼      ▼      ▼
  Haiku  Sonnet  Opus
  $0.25   $3     $15
  simple  medio  complejo
```

### 3 Estrategias de Routing:

**1. Rule-Based (la más simple):**
Definís reglas estáticas: "Si la tarea es formateo → modelo barato. Si es code generation → modelo caro."

**2. LLM-as-Judge (la más inteligente):**
Usás un modelo ultra-barato (Claude Haiku, GPT-4o Mini) solo para **clasificar** la complejidad de la tarea. Ese modelo decide a cuál modelo grande rutear la tarea real. El costo del "juez" es despreciable comparado con lo que ahorrás.

**3. Fallback Chain (la más resiliente):**
Intentás primero con el modelo barato. Si la respuesta no pasa un quality gate (score de confianza, validación de schema), escala automáticamente al modelo caro. Si todos fallan, failover a otro proveedor.

### Herramientas que ya ofrecen esto:
| Herramienta | Tipo | Destaque |
| :--- | :--- | :--- |
| **[LiteLLM](https://github.com/BerriAI/litellm)** | Open-source proxy (Python) | Interfaz OpenAI unificada para 100+ modelos. El estándar del mercado. |
| **[Bifrost](https://github.com/maxim-ai/bifrost)** | Open-source gateway (Go) | 11µs de latencia. Enterprise-ready con RBAC y semantic caching. |
| **[OpenRouter](https://openrouter.ai/)** | SaaS marketplace | Acceso a cientos de modelos con una sola API key. Ideal para prototipar. |
| **[Portkey](https://portkey.ai/)** | SaaS gateway | Observabilidad avanzada + routing + guardrails. |
| **Cloudflare AI Gateway** | Edge gateway | Routing dinámico integrado en la CDN de Cloudflare. |

### El dato killer:
> Equipos que implementan model routing reportan **reducciones de 40-70% en costos de API** sin pérdida medible de calidad en las respuestas. La clave es que el 60-80% de las tareas de una aplicación típica NO necesitan el modelo más caro.

### Conexión con vibe coding:
Cuando usás Cursor o Claude Code, **ya estás usando routing sin darte cuenta**. Cursor usa modelos diferentes para autocompletado (rápido/barato) vs. chat (potente/caro). Entender esto te ayuda a elegir cuándo pedir algo vía tab-completion vs. cuándo abrir el chat para una tarea compleja.

---

## 🤯 La Alucinación: Entenderla Cambia Cómo Le Pedís Cosas

El modelo no "sabe" nada. Predice el siguiente token más probable estadísticamente. Cuando el modelo "inventa" una función que no existe en tu codebase, no está mintiendo a propósito: está generando la secuencia de tokens más probable dado el contexto.

### Implicancias directas para vibe coding:
1. **Si el agente inventa un endpoint, es porque tu contexto no tiene la información correcta.** La solución no es pedirle que "no invente", sino darle un `CLAUDE.md` con la lista real de endpoints.
2. **Temperature baja reduce alucinaciones pero no las elimina.** La única mitigación real es RAG (darle la fuente de verdad) o verificación post-generación (tests, hooks).
3. **Los modelos alucinan más sobre datos recientes** (post-training cutoff). Si tu stack usa una librería que se actualizó hace 2 meses, el modelo puede generar código para la versión anterior.

---
[Volver al Inicio](../README.md)

