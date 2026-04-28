# 🔬 Context Window: Lo Que Todo Dev Debe Saber Para No Perder Sesiones

Esta sección NO es sobre cómo entrenar modelos. Es sobre **por qué tu agente de código se confunde después del prompt número 15** y qué podés hacer al respecto cuando trabajás con Cursor, Claude Code, Copilot o cualquier herramienta de Vibe Coding.

> **La regla de oro:** La ventana de contexto es como la RAM de tu agente. Si la llenás de basura, el agente empieza a delirar. Si la organizás bien, el agente es quirúrgico.

---

## 🧠 1. ¿Por qué tu agente "se pierde" a mitad de una sesión?

Todos lo hemos vivido: arrancás una sesión en Cursor o Claude Code, todo va perfecto los primeros 10 mensajes, y de repente el agente:
- **Olvida lo que le dijiste al principio.**
- **Repite código que ya habías corregido.**
- **Ignora las reglas del CLAUDE.md.**
- **Empieza a "inventar" funciones que no existen en tu codebase.**

### La causa técnica:
Cada mensaje tuyo, cada respuesta del agente, cada archivo que lee, cada resultado de herramienta... **todo se acumula en la ventana de contexto**. Cuando se llena:

```
┌─────────────────────────────────────────────────────────┐
│  CONTEXT WINDOW (ej: 200k tokens en Claude 3.5)        │
│                                                         │
│  [System Prompt + CLAUDE.md]     ← recuerda bien ✅    │
│  [Tu primer mensaje]              ← recuerda bien ✅    │
│  [Respuesta 1 del agente]                               │
│  [Tu segundo mensaje]                                   │
│  [Archivo que leyó]                                     │
│  [Resultado de test]                                    │
│  [...más interacciones...]        ← SE PIERDE AQUÍ ❌  │
│  [Tu mensaje 12]                                        │
│  [Otro archivo que leyó]                                │
│  [Tu último mensaje]              ← recuerda bien ✅    │
│                                                         │
│  ☠️ "Lost in the Middle" = el centro se ignora          │
└─────────────────────────────────────────────────────────┘
```

El fenómeno "Lost in the Middle" (Liu et al., Stanford/Berkeley, 2023) demuestra que la precisión cae hasta un **40% en el centro** del contexto. Con 20 documentos en el prompt, mover el dato clave de la posición 1 a la posición 10 reduce la precisión del 95% al 56%. No es un bug, es una propiedad del mecanismo de atención del Transformer.

*Paper: [Lost in the Middle: How Language Models Use Long Contexts](https://arxiv.org/abs/2307.03172)*

---

## 📡 2. El Piso de Ruido: El Enemigo Silencioso

El **piso de ruido** (noise floor) es la cantidad de información irrelevante acumulada en la ventana de contexto. A mayor piso de ruido, menor la capacidad del modelo de distinguir lo que importa.

### Fuentes de ruido en una sesión de Vibe Coding:
- **Stack traces completos** que se inyectan cuando solo importan 3 líneas.
- **Archivos leídos "por si acaso"** que el agente nunca usó.
- **Mensajes del tipo "sí, eso" o "dale"** que ocupan tokens sin aportar.
- **Respuestas largas del agente** con explicaciones que no pediste.
- **Resultados de herramientas** (búsquedas, tests) que ya no son relevantes.

### Cómo se manifiesta:
```
Señal útil:     ████████░░░░░░░░░░░░  (lo que el agente necesita)
Ruido:          ░░░░████████████████  (basura acumulada)
                ─────────────────────
                  ↑ Piso de ruido

A medida que el piso sube, la señal se hunde.
El agente no distingue tu instrucción de un log viejo.
```

### La consecuencia práctica:
Cuando el ratio señal/ruido baja, el agente empieza a:
1. **Mezclar contextos:** Usa código de un archivo que leyó hace 20 mensajes como si fuera el actual.
2. **Alucinar:** Inventa funciones, endpoints o tablas que no existen porque "recuerda" fragmentos de stack traces.
3. **Ignorar instrucciones:** Tu regla de "no usar Firebase" queda enterrada bajo 50k tokens de resultados de herramientas anteriores.

---

## 🌍 3. Dónde se manifiesta el problema de la ventana de contexto

No es un problema teórico. Ocurre en situaciones concretas que tu equipo enfrenta todos los días:

### Escenario 1: Sesión larga de implementación
Llevás 45 minutos implementando una feature. El agente ya leyó 15 archivos, corrió 3 tests y recibió 20 mensajes tuyos. A esta altura, si le pedís algo que le dijiste al mensaje 3, **no lo va a recordar**.

### Escenario 2: Debug con logs extensos
Le pegás un error con 200 líneas de stack trace. El agente "lee" todo, pero la ventana se llenó de basura. La siguiente instrucción tuya compite con 200 líneas de noise para captar la atención del modelo.

### Escenario 3: Multi-file refactoring
El agente necesita entender la relación entre 8 archivos. Los lee todos. Ahora tiene 50k tokens de código en la ventana, pero tu instrucción de "no cambiar la interfaz pública" está enterrada en el medio → la ignora.

### Escenario 4: Agentes multi-paso (BMAD, LangGraph)
Un agente que ejecuta un pipeline de 7 pasos acumula observaciones, resultados de herramientas y decisiones intermedias. Para el paso 6, la información del paso 1 ya está en la zona muerta del contexto.

### Escenario 5: Pair programming prolongado
Usás Cursor o Claude Code como pair programmer durante todo el día. Cada sesión nueva empieza limpia, pero si no cerrás la sesión, la ventanta se satura progresivamente.

---

## 🛠️ 4. Cómo BMAD y SDD atacan este problema

### BMAD Method y el Contexto

BMAD ataca el problema de raíz con su diseño de **Agent Personas separadas**:
- Cada persona (PM, Architect, Dev, QA) trabaja en una **sesión independiente**.
- Los artifacts (PRD, Architecture Doc) son el **mecanismo de transferencia de contexto** entre sesiones.
- Nunca se acumula todo el contexto de un proyecto en una sola ventana.

```
Sesión 1 (PM Agent):     Input: brief → Output: PRD.md ✅
Sesión 2 (Arch Agent):   Input: PRD.md → Output: architecture.md ✅
Sesión 3 (Dev Agent):    Input: architecture.md + spec → Output: código ✅
```

> Los artifacts de BMAD no son solo documentación. Son **compresores de contexto** que permiten que un agente nuevo arranque con el conocimiento esencial sin cargar toda la historia.

### SDD y el CLAUDE.md como Contexto Permanente

En el enfoque SDD del `agentic-sdd-starter`:
- El `CLAUDE.md` se carga **siempre al inicio** de la ventana → zona de alta atención ✅
- Las specs (`specs/*.md`) son **documentos pequeños y focalizados** → no saturan la ventana
- Los hooks validan automáticamente → el agente no necesita "recordar" reglas de lint

### Cómo lo manejan las herramientas:

| Herramienta | Técnica de Contexto | Implicancia |
| :--- | :--- | :--- |
| **Cursor** | Indexa tu codebase con embeddings y solo inyecta archivos relevantes. | No carga TODO tu proyecto, solo lo que necesita. Pero si vos le pedís que lea 10 archivos de más, elevaste el piso de ruido. |
| **Claude Code** | Lee archivos bajo demanda con herramientas. Usa `CLAUDE.md` como contexto base persistente. | Cada herramienta que ejecuta consume tokens. Sesiones largas sin corte = degradación. |
| **GitHub Copilot** | Usa "neighboring tabs" y el archivo actual como contexto principal. | Contexto limitado pero limpio. Ideal para autocompletado, insuficiente para tareas complejas. |
| **Windsurf** | Cascade mode con contexto multi-archivo inteligente. | Selecciona archivos automáticamente, pero la selección no siempre es la óptima. |

---

## 📐 5. Técnicas Prácticas

### Técnica 1: "Sesiones Cortas, Artifacts Largos"
**El anti-patrón:** Una sesión de 2 horas con 50 mensajes donde el agente ya perdió el hilo.
**El patrón correcto:**
- Sesiones cortas (5-15 mensajes) con un objetivo claro.
- Al final de cada sesión, pedirle al agente que genere un **resumen/artifact**.
- Iniciar la siguiente sesión pasándole el artifact como contexto fresco.

### Técnica 2: "CLAUDE.md como Memoria de Largo Plazo"
Tu `CLAUDE.md` es lo primero que lee el agente. Es el lugar donde guardás lo que NO debe olvidar nunca:
```markdown
## Decisiones Arquitectónicas (no cambiar sin aprobación)
- Backend: NestJS + Prisma + PostgreSQL
- Auth: AWS Cognito (NO Firebase)
- API Style: REST, no GraphQL
- Tests: Vitest, mínimo 80% coverage

## Errores Comunes en Este Proyecto
- El endpoint /users requiere header X-Tenant-ID
- La tabla "orders" tiene soft-delete, siempre filtrar por deleted_at IS NULL
```

### Técnica 3: "Context Windowing Manual"
Cuando trabajás en una tarea larga, refrescá el contexto:
1. Cada 10-15 mensajes: *"Resumí lo que llevamos hecho, archivos tocados y pendientes."*
2. Copiá ese resumen.
3. Abrí una **nueva sesión** y pegá el resumen como primer mensaje.
4. El agente arranca fresco, con contexto comprimido y piso de ruido en cero.

### Técnica 4: "Spec-Scoped Tasks" (SDD)
No le pidas al agente que "haga toda la feature". Dividí en micro-tareas con specs:
```
❌ "Implementá el sistema de notificaciones completo"

✅ "Implementá specs/notification-service.md:
    - Solo el endpoint POST /notifications
    - Solo la tabla notifications
    - Solo los tests unitarios para ese endpoint"
```
Cada micro-tarea cabe en la ventana de contexto sin degradación.

### Técnica 5: "Reducir el Piso de Ruido Activamente"
- Cuando pegás un error, **recortá el stack trace** a las líneas relevantes.
- Cuando el agente lee archivos innecesarios, avisale: *"No necesitás leer ese archivo, enfocate en X."*
- Evitá mensajes cortos sin contenido ("ok", "dale", "sí"). Si vas a confirmar, aprovechá para agregar contexto: *"Sí, avanzá. Tené en cuenta que ese módulo usa inyección de dependencias."*
- Pedí respuestas concisas: *"Respondé solo con el código modificado, sin explicaciones."*

### Técnica 6: "Prompt Caching"
Anthropic y OpenAI ofrecen **Prompt Caching** nativo:
- Las llamadas repetidas con el mismo `CLAUDE.md` + system prompt son **90% más baratas**.
- El truco: la parte estática **siempre al inicio**, la parte dinámica al final.
- Claude Code ya hace esto automáticamente con tu `CLAUDE.md`.

*Fuente: [Anthropic Prompt Caching Docs](https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching)*

### Técnica 7: "El Log de Decisiones (Workflow.md)" ⭐
Esta es una técnica avanzada de **Memoria Externa**. Consiste en crear un archivo (ej: `workflow.md` o `decisions.log`) y obligar al agente a usarlo como su "bitácora de vuelo".

**Por qué funciona:**
En lugar de confiar en que el agente "recuerde" una decisión tomada en el mensaje 5 del chat, la decisión se persiste en disco. En la siguiente sesión, el agente lee el archivo y sabe exactamente qué se decidió y por qué.

**Configuración en `CLAUDE.md`:**
```markdown
## Memoria de Proyecto
- Mantén un log de decisiones técnicas en `workflow.md`.
- Cada vez que tomemos una decisión de arquitectura, modelo de datos o lógica compleja, documéntala ahí brevemente.
- Antes de proponer un cambio, consulta siempre `workflow.md` para asegurar consistencia.
```


---

## ⚖️ 6. RAG vs. Contexto Largo: Cuándo Usar Cada Uno

| Situación | Enfoque Recomendado | Por qué |
| :--- | :--- | :--- |
| Implementar una feature con spec | **Contexto directo** (pasar el .md) | La spec es corta y el agente la necesita completa. |
| Debuggear con logs de producción | **RAG / Herramienta de búsqueda** | Los logs pueden ser 1M+ tokens, imposible inyectarlos sin saturar. |
| Refactorizar siguiendo convenciones | **CLAUDE.md + Rules** | Las reglas se cachean, no gastan contexto nuevo. |
| Analizar un codebase nuevo | **Lectura incremental** (Context Paging) | El agente lee archivos bajo demanda, no todo de golpe. |
| Preguntas sobre docs internos | **RAG con reranking** | Muchos documentos, solo 2-3 son relevantes por consulta. |

---

## 📊 7. Métricas Que Deberías Trackear

| Métrica | Qué mide | Target |
| :--- | :--- | :--- |
| **Mensajes por sesión efectiva** | Cuántos mensajes antes de degradación visible. | < 20 en tareas complejas |
| **Tasa de re-explicación** | Cuántas veces tenés que repetir algo que ya dijiste. | 0 idealmente. Si pasa, la sesión es demasiado larga. |
| **Coste por task completado** | Tokens consumidos para resolver una tarea. | Comparar con y sin Prompt Caching. |
| **Artifacts generados por sesión** | El equipo está creando contexto reutilizable? | ≥ 1 artifact por sesión larga. |

---

## 🔩 8. Qué Pasa Bajo El Capó (para los curiosos)

### El KV Cache
Cada token procesado genera vectores Key y Value almacenados en memoria GPU. Es lo que permite que el modelo "recuerde" lo anterior. Cuando el contexto es largo, este cache consume decenas de GB y el modelo empieza a ser impreciso.

### Sparse Attention
Modelos como Mistral y DeepSeek no leen todo el contexto con la misma intensidad. Usan "ventanas deslizantes" que priorizan tokens cercanos. Por eso la información del medio se pierde.

### Prompt Caching (Anthropic/OpenAI)
Cuando enviás el mismo bloque de texto (ej: tu CLAUDE.md) en múltiples llamadas, el proveedor guarda los cálculos de atención en cache. La segunda vez no recalcula → más rápido y más barato.

---
[Volver a LLM Engineering](./README.md) | [Volver a Context Orchestration](./context-orchestration.md) | [Volver al Inicio](../README.md)
