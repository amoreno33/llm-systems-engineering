# 🤖 Agentic AI & Systems Execution

En la ingeniería de IA, el paso de "Chat" a "Agente" es el cambio fundamental de paradigma. Un agente no solo genera texto; **razona, planifica y actúa** sobre su entorno.

> **Conexión con vibe coding:** Cuando usás Cursor en modo "Agent" o Claude Code, ya estás usando un sistema agéntico. El modelo lee tu código, planifica cambios, ejecuta comandos y evalúa los resultados — todo en loop. Esta sección te explica cómo controlar eso en lugar de que te controle a vos.

---

## 🆚 Chat vs. Agente: ¿Cuál es la diferencia real?

| | Chat (Copilot/ChatGPT) | Agente (Cursor Agent/Claude Code) |
| :--- | :--- | :--- |
| **Acción** | Solo genera texto | Genera texto + ejecuta acciones |
| **Memoria** | Solo el contexto de la conversación | Puede leer/escribir archivos, ejecutar comandos |
| **Loop** | Una pregunta, una respuesta | Múltiples pasos hasta completar la tarea |
| **Riesgo** | Bajo (solo texto) | Alto (puede borrar archivos, hacer commits) |
| **Control** | Vos decidís qué hacer con el output | El agente decide los pasos intermedios |

> **Tip memorable:** Un chat te da un plano. Un agente construye la casa. Ambos pueden equivocarse, pero el agente puede romper cosas reales.

---

## 🧠 El Unificador: "Spec-First Engineering"

Sin importar si usás BMAD, LangGraph o CrewAI, el éxito de un agente depende de un solo concepto: **La especificación es el código del agente.**

### ¿Por qué fallan los agentes?
Los agentes fallan cuando les damos instrucciones vagas ("Arregla este bug"). Esto deja demasiada libertad al modelo probabilístico, aumentando el riesgo de alucinaciones y **loops infinitos** donde el agente sigue intentando sin progresar.

**Ejemplo real en vibe coding:**
```
❌ Malo:  "Arregla el bug del login"
✅ Bueno: "El login falla cuando el email tiene mayúsculas.
           Archivo: src/auth/login.ts, función validateUser().
           El fix debe normalizar el email a lowercase antes de comparar.
           Test esperado: usuario@EMPRESA.com debe hacer login correctamente."
```

### La Solución: Spec antes de código
Obligamos al agente a trabajar sobre un artefacto determinístico:
1.  **Input:** La instrucción del usuario.
2.  **Plan:** El agente genera una `spec` (qué va a hacer, qué archivos toca, qué tests debe pasar).
3.  **Verificación:** El humano valida la `spec` antes de que el agente ejecute.
4.  **Ejecución:** El agente implementa basándose *estrictamente* en la `spec`.

> **Dato con respaldo:** El paper *"Chain of Specification: Enhancing LLM Reasoning"* (2024) demuestra que separar el diseño de la implementación mediante una especificación intermedia reduce errores de lógica en un **38%** vs. prompting directo.

**Specs ejecutables vs. verificables:**
- **Verificables** (tradicional): La spec es un documento que valida el código después de escrito.
- **Ejecutables** (moderno, ej: Spec-Kit): La spec **genera** el código directamente. El workflow es: `constitution → specify → plan → tasks → implement → analyze`. La spec es el input del runtime, no solo documentación.

---

## 🏗️ Frameworks Agénticos: Cuándo Usar Cada Uno

| Framework | Cómo define la "Spec" | Mejor para... | Curva de aprendizaje |
| :--- | :--- | :--- | :--- |
| **BMAD Method** | Artifacts Multi-persona: PRDs, Arquitectura, Specs técnicas | Proyectos con ciclo de vida completo | Media |
| **SDD (Starter Kit)** | Micro-specs verificables: un `.md` por feature atómica | Vibe coding quirúrgico, bug fixes, features aisladas | Baja ✅ |
| **LangGraph** | Grafos de Estado en Python | Agentes con lógica compleja y cíclica | Alta |
| **CrewAI / AutoGen** | Roles y Tareas: definición de agentes y misiones | Análisis paralelo, role-playing, brainstorming | Media |
| **PydanticAI** | Type-safe Schemas con validación estricta | Backends empresariales que requieren JSON exacto | Media |

> **Tip para empezar:** Si estás haciendo vibe coding hoy, empezá por **SDD**. Es el más parecido a lo que ya hacés con Cursor/Claude Code pero con estructura. El `CLAUDE.md` de tu proyecto es literalmente el primer paso del método.

---

## 🔌 MCP (Model Context Protocol)

MCP es el estándar abierto de Anthropic para que los agentes se conecten a herramientas y fuentes de datos externas de forma estandarizada.

**¿Qué problema resuelve?**
Sin MCP, cada integración (GitHub, Jira, Notion, base de datos) requería código custom para cada agente. Con MCP, escribís la integración una vez como "servidor MCP" y funciona en cualquier cliente compatible: Cursor, Claude Code, VS Code con Copilot, etc.

```
Sin MCP:  Agente A ──── código custom ──── GitHub
          Agente B ──── código custom ──── GitHub  (duplicado)
          Agente C ──── código custom ──── GitHub  (triplicado)

Con MCP:  Agente A ──┐
          Agente B ──┤── MCP Server (GitHub) ──── GitHub
          Agente C ──┘
```

**Servidores MCP más útiles para vibe coding:**
- `@modelcontextprotocol/server-github` — Leer PRs, issues, repos.
- `@modelcontextprotocol/server-filesystem` — Acceso controlado a archivos.
- `@modelcontextprotocol/server-postgres` — Consultas a base de datos.

> **Tip de seguridad:** Antes de conectar un servidor MCP a tu agente, revisá qué permisos expone. Un MCP server mal configurado puede darle al agente acceso de escritura a recursos que no debería tocar.

---

## 🛡️ Human-in-the-Loop (HITL): No Todo Puede Ser Autónomo

En entornos corporativos, la autonomía total es un riesgo operacional. El HITL no es una limitación — es una feature de diseño.

**¿Cuándo implementar HITL obligatoriamente?**

| Acción del agente | Nivel de riesgo | Control recomendado |
| :--- | :--- | :--- |
| Leer archivos / generar borrador | 🟢 Bajo | Autónomo OK |
| Modificar código / crear archivos | 🟡 Medio | Revisión antes de guardar |
| Ejecutar comandos en terminal | 🟠 Alto | Aprobación explícita |
| Borrar datos / hacer deploy | 🔴 Crítico | HITL obligatorio + log de auditoría |

> **Tip memorable:** Pensá en el HITL como el `git diff` antes del commit. El agente propone, vos aprobás. Sin ese paso, estás haciendo `git push --force` en producción con los ojos cerrados.

---

## 🎯 Los 4 Patrones de Fallo Comunes (Y Cómo Solucionarlos)

Esta sección está basada en los aprendizajes de **Matt Pocock** ([34k+ stars en GitHub](https://github.com/mattpocock/skills)), quien identificó los errores más comunes al desarrollar con agentes y propone soluciones concretas.

### 1️⃣ "El Agente No Hizo Lo Que Yo Quería"

**El Problema:**
La causa #1 de fracaso en desarrollo de software (con o sin IA) es el **desalineamiento**. Creés que el dev (o el agente) entendió lo que querías. Ves el resultado y te das cuenta de que no captó nada.

**La Solución: Grilling Session (Sesión de Interrogación)**

En lugar de darle instrucciones y esperar, hacés que el agente **te interrogue primero**:

```
❌ Enfoque típico:
Tú: "Haceme un sistema de pagos con Stripe"
Agente: [Genera 800 líneas de código]
Tú: "No, necesitaba soporte para suscripciones recurrentes..."

✅ Enfoque con Grilling:
Tú: "Necesito integrar Stripe para pagos"
Agente: "Antes de empezar, dejame hacerte algunas preguntas:
         - ¿Es para pagos únicos o recurrentes?
         - ¿Qué monedas necesitás soportar?
         - ¿Ya tenés una cuenta de Stripe configurada?
         - ¿Cómo manejás los webhooks de confirmación?"
Tú: [Respondés en 2 minutos]
Agente: [Genera el código correcto la primera vez]
```

> **Tip memorable:** Nadie sabe exactamente lo que quiere hasta que ve lo que no quiere. La grilling session te obliga a pensar antes de codear.

> 📚 **¿No sabés qué es una "Grilling Session"?** → Ver [Conceptos Fundamentales](../07-high-value-resources/README.md#-conceptos-fundamentales)

**Herramientas que implementan esto:**
- **BMAD** tiene una fase de "Interview" antes de generar specs
- **Matt Pocock Skills**: `/grill-me` y `/grill-with-docs`

---

### 2️⃣ "El Agente Es Demasiado Verboso"

**El Problema:**
El agente usa 20 palabras donde 1 es suficiente. Dice "implementación de la funcionalidad de autenticación de usuarios" en lugar de simplemente "login". Esto consume tokens, dificulta la lectura y hace que el contexto se llene de ruido.

**La Solución: Lenguaje Compartido (Domain Language)**

> 📚 **¿Qué es Domain-Driven Design?** → Ver [Conceptos Fundamentales](../07-high-value-resources/README.md#domain-driven-design-ddd)

Inspirado en **Domain-Driven Design** de Eric Evans, la idea es crear un vocabulario común entre vos y el agente mediante un archivo `CONTEXT.md` en la raíz del proyecto.

**Ejemplo de CONTEXT.md:**

```markdown
# Lenguaje del Proyecto

## Términos del Dominio

- **Usuario**: Persona con cuenta en el sistema. NO uses "cliente" ni "account holder".
- **Pedido**: Solicitud de compra. NO uses "order request" ni "purchase".
- **Fulfillment**: Proceso de preparación y envío. NO traducir a español.
- **SKU**: Identificador único de producto (ej: "LAPTOP-001"). NO uses "product ID".

## Decisiones de Arquitectura que el Agente DEBE respetar

- Usamos **Prisma** como ORM. NO sugieras cambiar a TypeORM.
- Los tests se escriben en **Vitest**, no Jest.
- Las validaciones usan **Zod**, no Joi ni Yup.
```

**Resultado:**
El agente lee este archivo al inicio de cada sesión y adopta tu lenguaje. Ahora dice "crear el SKU" en lugar de "generar el identificador único del producto en la base de datos".

> **Tip memorable:** Un CONTEXT.md bien hecho puede reducir el uso de tokens en un 30-50% y hace que el código generado use nombres consistentes. Es como darle al agente el "manual de estilo" de tu proyecto.

**Herramientas que lo implementan:**
- **Matt Pocock Skills**: `/grill-with-docs` actualiza `CONTEXT.md` mientras trabajás
- **SDD Starter Kit**: Incluye templates de `CONTEXT.md` y `CLAUDE.md`

---

### 3️⃣ "El Código Que Genera No Funciona"

**El Problema:**
El agente está alineado contigo sobre qué construir, pero igual produce código con bugs o que no compila. Sin feedback, el agente está volando a ciegas.

**La Solución: Feedback Loops (Ciclos de Retroalimentación)**

El agente necesita **feedback rápido** sobre si el código que generó funciona o no. Sin esto, cada cambio es un tiro al aire.

**Los 3 Feedback Loops Esenciales:**

1. **Static Types (Tipos Estáticos):**
   - TypeScript, Python con type hints, Rust, etc.
   - El agente ve errores de tipo **antes** de ejecutar el código.
   
2. **Automated Tests (Tests Automatizados):**
   - Unit tests, integration tests.
   - El agente puede **correr los tests** y ver si el cambio rompe algo existente.

3. **Browser/Runtime Access (Acceso al Entorno):**
   - El agente puede abrir el navegador o ejecutar el programa.
   - Ve los errores reales en tiempo de ejecución.

**TDD con Agentes: Red-Green-Refactor**

> 📚 **¿No sabés qué es TDD o red-green-refactor?** → Ver [Conceptos Fundamentales](../07-high-value-resources/README.md#tdd-test-driven-development)

El loop clásico de TDD, pero aplicado a desarrollo con IA:

```
1. RED:   Escribir un test que falle (el agente lo genera)
2. GREEN: Escribir el código mínimo para que el test pase
3. REFACTOR: Mejorar el código sin romper el test
```

**Ejemplo real:**

```
Tú: "Necesito una función que valide emails"

Agente (paso RED):
  test('debe validar emails correctamente', () => {
    expect(isValidEmail('test@example.com')).toBe(true);
    expect(isValidEmail('invalid')).toBe(false);
  });
  // Este test falla porque isValidEmail() no existe aún

Agente (paso GREEN):
  function isValidEmail(email: string): boolean {
    return email.includes('@') && email.includes('.');
  }
  // Test pasa ✅

Agente (paso REFACTOR):
  function isValidEmail(email: string): boolean {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return regex.test(email);
  }
  // Test sigue pasando ✅, pero el código es más robusto
```

> **Tip memorable:** Sin tests, el agente es como un dev programando en un notepad sin compilador. No sabe si lo que escribió funciona hasta que vos lo probás manualmente.

**Herramientas que lo implementan:**
- **Matt Pocock Skills**: `/tdd` para red-green-refactor automatizado
- **Cursor**: Puede ejecutar tests automáticamente si configurás `package.json`

---

### 🪝 Hooks y Skills: Dónde vive cada concepto

Una fuente frecuente de confusión en sistemas agénticos es mezclar tres capas que son distintas:

| Capa | Quién define los hooks | Ejemplo |
| :--- | :--- | :--- |
| **Claude Code / Editor** | `settings.json` → scripts en `.claude/hooks/` | Bloquear `rm -rf` antes de ejecutar |
| **Framework Python propio** | `runtime.register_hook()` | Validar spec antes de implementar |
| **BMAD / Spec Kit** | El editor/runtime subyacente ejecuta los hooks | BMAD define el rol; Claude Code ejecuta el control |

> **La regla central:** el LLM no tiene hooks. El runtime sí. Los hooks están en Claude Code, en tu framework, o en los guardrails de tu metodología — nunca dentro del modelo.

> 📖 **Ver guía completa:** [Hooks & Skills — Las 3 Capas](../agentic-sdd-starter/docs/hooks-skills-guide.md)

---

### 4️⃣ "Construimos Una Bola de Barro (Ball of Mud)"

**El Problema:**
El agente genera código rápido, pero con el tiempo el proyecto se vuelve un caos: código duplicado, funciones gigantes, módulos acoplados. Porque el agente puede codear 10x más rápido, también puede generar **entropía** 10x más rápido.

> **Esto pasa con BMAD, con Spec-Kit, y con cualquier framework.** Ninguna metodología te salva automáticamente del caos si no invertís en diseño todos los días.

**La Solución: Invertir en Diseño Todos Los Días**

> "Invest in the design of the system every day."  
> — Kent Beck, *Extreme Programming Explained*

**Prácticas concretas:**

1. **Módulos Profundos (Deep Modules):**
   - Un módulo es "profundo" cuando expone una **interfaz simple** pero provee **mucha funcionalidad**.
   - Ejemplo: `saveUser(user)` internamente maneja validación, encriptación, transacciones, logs... pero para el usuario es solo una función.

2. **Refactoring Frecuente:**
   - Cada 3-4 features nuevas, dedicá una sesión a **refactorizar código duplicado**.
   - Herramienta: `/improve-codebase-architecture` (Matt Pocock Skills) escanea el código y sugiere mejoras.

3. **Explicar el Código en Contexto del Sistema:**
   - No dejés que el agente vea solo funciones aisladas.
   - Pedile que **explique cómo encaja** ese módulo en la arquitectura general.
   - Herramienta: `/zoom-out` (Matt Pocock Skills) le pide al agente que explique el código en el contexto del sistema completo.

**Ejemplo de Módulo Profundo:**

```typescript
// ❌ Interfaz superficial (expone complejidad al usuario)
function saveUser(user, db, logger, validator, encryptor, emailService) {
  // El usuario tiene que saber de TODAS estas dependencias
}

// ✅ Módulo profundo (interfaz simple, mucha funcionalidad interna)
function saveUser(user: User) {
  // Internamente maneja: validación, encriptación, DB, logs, emails
  // El usuario solo pasa el user y listo
}
```

> **Tip memorable:** El código fácil de escribir suele ser difícil de mantener. El código fácil de mantener requiere diseño intencional. Con agentes, tenés que ser **más disciplinado con el diseño**, no menos.

---

## 🛠️ Herramientas y Frameworks Recomendados

Esta lista incluye herramientas probadas en producción para trabajar con agentes de IA.

### Frameworks de Workflow

| Framework | Propósito | Mejor para | Repositorio |
| :--- | :--- | :--- | :--- |
| **BMAD** | Build, Measure, Adjust, Deploy | Proyectos con ciclo completo y equipos | [Link pendiente] |
| **Spec-Kit** | Specs ejecutables con workflow de 6 pasos: constitution → specify → plan → tasks → implement → analyze | Desarrollo con specs que generan código directamente. 91k+ estrellas, 100+ extensiones comunitarias | [github.com/github/spec-kit](https://github.com/github/spec-kit) |
| **Superpowers** | Metodología completa con skills automáticos: brainstorming → worktrees → plans → subagent-driven-dev → TDD → code review → finish | Workflow end-to-end con TDD forzado y subagentes. 171k+ estrellas, filosofía de diseño intencional | [github.com/obra/superpowers](https://github.com/obra/superpowers) |
| **Matt Pocock Skills** | Skills modulares para agentes | Ingeniería disciplinada con IA | [github.com/mattpocock/skills](https://github.com/mattpocock/skills) |

### Skills Útiles (Matt Pocock)

**Para Código:**
- `/grill-with-docs` — Grilling session que actualiza `CONTEXT.md` y ADRs
- `/tdd` — Test-Driven Development con red-green-refactor
- `/diagnose` — Loop estructurado para debugging: reproducir → minimizar → fix
- `/improve-codebase-architecture` — Encuentra oportunidades de refactoring

**Para Productividad:**
- `/grill-me` — Sesión de preguntas antes de empezar cualquier tarea
- `/caveman` — Modo ultra-comprimido (reduce tokens ~75%)

> **Cómo instalarlas:**
> ```bash
> npx skills@latest add mattpocock/skills
> ```
> Elegís las skills que querés y en qué agente instalarlas (Cursor, Claude Code, etc.)

### Documentos Esenciales del Proyecto

Estos archivos viven en la raíz de tu proyecto y el agente los lee automáticamente:

| Archivo | Propósito | Cuándo usarlo |
| :--- | :--- | :--- |
| **CONTEXT.md** | Lenguaje compartido y decisiones de arquitectura | Siempre, desde el día 1 |
| **CLAUDE.md** | Instrucciones específicas para Claude/agentes | Proyectos con Claude Code o Cursor |
| **docs/adr/** | Architecture Decision Records (ADRs) | Cuando tomás decisiones técnicas importantes |
| **CONTRIBUTING.md** | Guía de contribución (también para agentes) | Proyectos open source o con equipo grande |

**Ejemplo de ADR (Architecture Decision Record):**

> 📚 **¿Qué son los ADRs?** → Ver [Conceptos Fundamentales](../07-high-value-resources/README.md#adr-architecture-decision-record)

```markdown
# ADR 003: Usar Zod en lugar de Joi para Validación

## Fecha: 2025-01-15

## Estado: Aceptado

## Contexto:
Necesitábamos un sistema de validación de schemas con inferencia de tipos en TypeScript.

## Decisión:
Usar **Zod** como biblioteca de validación en lugar de Joi.

## Consecuencias:
✅ Inferencia automática de tipos TypeScript
✅ Mejor integración con tRPC
✅ Bundle size más pequeño (12kb vs 50kb de Joi)
❌ Sintaxis menos conocida por el equipo (curva de aprendizaje)

## Alternativas consideradas:
- Joi: Popular pero no tiene inferencia de tipos nativa
- Yup: Mejor que Joi pero inferencia de tipos limitada
```

> **Tip memorable:** Los ADRs son tu memoria a largo plazo. Cuando el agente pregunta "¿por qué usamos Zod?", le decís "lee ADR 003". Sin esto, explicás lo mismo 20 veces.

---

## 📚 Recursos Complementarios

**Libros citados en esta sección:**
- *Domain-Driven Design* — Eric Evans
- *The Pragmatic Programmer* — David Thomas & Andrew Hunt  
- *Extreme Programming Explained* — Kent Beck
- *A Philosophy of Software Design* — John Ousterhout

**Repositorios para profundizar:**
- [Matt Pocock Skills](https://github.com/mattpocock/skills) — 34k+ stars, skills de ingeniería para agentes
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook) — Mejores prácticas para Claude
- [LangGraph Examples](https://github.com/langchain-ai/langgraph) — Arquitecturas de agentes cíclicos
- [Promptfoo](https://github.com/promptfoo/promptfoo) — Testing y evaluación de prompts

---
[Volver al Inicio](../README.md)


