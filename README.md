# 🧠 LLM Systems Engineering: Guía Práctica

---

## 🗺️ Mapa de Navegación

| Sección | Core Focus | Valor para Ingeniería de IA |
| :--- | :--- | :--- |
| **[01. Foundations](./01-foundations/README.md)** | Modern Core | Tokens, ventanas de contexto, temperature, model routing. Lo que afecta tu trabajo diario. |
| **[02. LLM Engineering](./02-llm-engineering/README.md)** | Intelligence Layer | Cómo gestionar el contexto, reducir alucinaciones y estructurar prompts. |
| **[03. Advanced RAG](./03-advanced-rag/README.md)** | Retrieval | Comparativa Naive RAG vs. Advanced RAG: query transform, reranking, hybrid search. |
| **[04. Agentic Systems](./04-agentic-systems/README.md)** | Agents | Patrones de agentes, hooks, skills, SDD y persistencia de memoria. |
| **[05. Cloud](./05-cloud-architectures/README.md)** | AWS & Azure | AWS Bedrock y Azure AI Foundry: servicios, cuándo usarlos, gobernanza enterprise. |
| **[06. Ops & Security](./06-llmops-security/README.md)** | Governance | Versionado de prompts, observabilidad, prompt injection y gobernanza de memoria. |

### [07. High-Value Resources](./07-high-value-resources/README.md)
*   Papers, repositorios de referencia y herramientas con links verificados.

---

## 🚀 Filosofía de Trabajo: De Vibe Coding a SDD

### El problema: Vibe Coding no escala

El "vibe coding" es el modo por defecto cuando empezás con agentes: describís lo que querés, el agente genera, revisás el resultado, señalás lo que está mal, el agente lo intenta de nuevo. Funciona para prototipos rápidos. No funciona para sistemas reales.

Los problemas acumulados del vibe coding sin estructura:
- **Sesiones sin memoria**: cada conversación empieza desde cero, el agente no sabe qué decidiste la semana pasada
- **Código desechable**: el agente optimiza para el prompt actual, no para el sistema a largo plazo
- **Deuda técnica acelerada**: un agente puede generar entropía más rápido que un humano (ver [Patrón 4: Ball of Mud](./04-agentic-systems/README.md))
- **Drift de intención**: lo que pediste en el turno 1 ya no tiene coherencia con lo del turno 20

### La respuesta profesional: Specification Driven Development (SDD)

SDD separa dos responsabilidades que el vibe coding mezcla:

| | Vibe Coding | SDD |
| :--- | :--- | :--- |
| **Qué produce el humano** | Prompts en conversación | Especificaciones como artefacto |
| **Qué hace el agente** | Interpreta e improvisa | Ejecuta contra un contrato |
| **Persistencia** | Solo dura la sesión | La spec sobrevive entre sesiones y agentes |
| **Escalabilidad** | Se rompe en proyectos grandes | Funciona en proyectos nuevos y existentes |
| **Rol del dev** | Corrector de resultados | Arquitecto de especificaciones |

> *Concepto basado en [Spec-Driven Development for AI Coding Agents](https://learn.deeplearning.ai/) — DeepLearning.AI*

### La analogía del compilador

Los compiladores traducen código fuente legible → código máquina ejecutable.  
SDD hace lo mismo un nivel más arriba: traduce **especificaciones en lenguaje humano → código fuente**.

La ventaja clave: las specs están en lenguaje natural. Las puede leer el equipo técnico, el producto, y el negocio. Son el contrato entre todos.

> **Mantra:** *El agente es el músculo. La spec es el cerebro.*

### Los 3 beneficios concretos del SDD

**1. Control con cambios mínimos**  
Pequeños cambios en la especificación generan grandes cambios en el código. Unas pocas líneas sobre "look and feel" pueden generar cientos de líneas de CSS consistentes. La carga cognitiva la lleva la spec, no la conversación.

**2. Elimina el problema de contexto**  
En sesiones multi-turno, la ventana de contexto se llena y el agente empieza a cometer errores por perder el hilo. Una spec bien definida ancla al agente al contexto central necesario, sesión tras sesión, sin importar qué agente lo ejecute.

**3. Mejora la fidelidad de intención**  
Escribir una spec te obliga a definir antes de codear: el problema, los criterios de éxito, las restricciones, los flujos de usuario. El código generado coincide con tus objetivos reales —no con lo que dijiste en el momento.

### La habilidad clave: nivel correcto de detalle

Tratá al agente como un **pair programmer altamente capaz pero sin contexto de tu proyecto**:

- ✅ **Dale mucho contexto sobre**: objetivos, misión, audiencia, restricciones, decisiones de arquitectura
- ❌ **No microgestiones**: las decisiones de bajo nivel que el agente puede resolver solo no necesitan estar en la spec

> El secreto no es escribir más — es escribir lo que el agente genuinamente no puede saber por sí solo.

### El ciclo de trabajo en SDD

SDD no es lineal. Es un ciclo disciplinado con tres fases que se repiten:

```
CONSTITUCIÓN (nivel proyecto — se define una vez)
        ↓
FEATURE N → Plan → Implement → Validate
        ↓
   REPLANNING (revisás y ajustás antes de la siguiente)
        ↓
FEATURE N+1 → Plan → Implement → Validate
        ↓
        ...
```

**Fase 1 — Constitución del Proyecto**  
Define los acuerdos estructurales que no cambian feature a feature:

| Elemento | Qué incluye |
| :--- | :--- |
| **Misión** | El "por qué": visión, audiencias, alcance del proyecto |
| **Tech Stack** | Lenguajes, frameworks, herramientas de deploy |
| **Roadmap** | Documento vivo con fases y prioridades |

> La Constitución es *agent-agnostic*: si mañana cambiás de Claude a otro modelo, la Constitución no cambia. Tu contexto es tuyo, no del proveedor.

**Fase 2 — Ciclo por Feature (se repite)**  
1. **Plan** — Especificás la feature: qué construir, criterios de éxito, restricciones
2. **Implement** — El agente construye contra esa spec
3. **Validate** — Revisás, aceptás o pedís cambios

**Fase 3 — Replanning (entre features)**  
Después de cada entrega: revisás la Constitución, actualizás el Roadmap, y mejorás el proceso mismo. Cada ciclo agrega aprendizaje.

### La analogía del arquitecto

```
Tú (Arquitecto)             Agente (Constructores)
├─ Diseñás                  ├─ Ejecutan la construcción
├─ Supervisás               └─ Implementan los detalles técnicos
└─ Revisás y aceptás
   (o pedís cambios)
```

No le decís al constructor cómo clavar los clavos. Le das el plano y el contexto que él no tiene. Eso es exactamente lo que hace una buena spec.

### SDD en la Práctica: Workflow técnico de 6 pasos

La diferencia crítica en SDD moderno (como en [Spec-Kit](https://github.com/github/spec-kit)) es que **las especificaciones no solo verifican el código — lo generan directamente**:

1. **Constitution** — Principios y reglas del proyecto
2. **Specify** — El QUÉ y el POR QUÉ (sin mencionar tecnología)
3. **Plan** — El CÓMO (con tech stack y arquitectura)
4. **Tasks** — Lista accionable en piezas de 2-5 minutos
5. **Implement** — Ejecución por el agente contra la spec
6. **Analyze** — Validación de consistencia spec ↔ código

> *Conceptos basados en [Spec-Driven Development for AI Coding Agents](https://learn.deeplearning.ai/) — DeepLearning.AI*

Para ver cómo esto se implementa con archivos reales, consultá el [Agentic SDD Starter](./agentic-sdd-starter/README.md) y los [Templates listos para usar](./07-high-value-resources/README.md#-templates--starter-kits).

---

---

## 📂 Ejemplos Prácticos (Copy-Paste Ready)

| Ejemplo | Qué vas a encontrar |
| :--- | :--- |
| **[CLAUDE.md para un proyecto real](./examples/claude-md-real-project.md)** | Un `CLAUDE.md` completo para una API de pagos (Node.js/TypeScript). Copialo y adaptalo. |
| **[Decision Log (workflow.md)](./examples/workflow-md-decision-log.md)** | Cómo se ve un log de decisiones después de 2 semanas de desarrollo. Con antes/después. |
| **[Obsidian como Second Brain](./examples/obsidian-second-brain.md)** | Estructura de vault, notas con links bidireccionales, Graph View y plugins de IA. |
| **[Antes vs Después: Prompts Reales](./examples/antes-despues-prompts.md)** | 5 escenarios: el prompt vago vs. el prompt con contexto. |

---

## 🛠️ Contribución

Este es un repositorio vivo. Las contribuciones bienvenidas son:
1.  Correcciones de contenido desactualizado o impreciso.
2.  Referencias nuevas con fuente verificable.
3.  Ejemplos concretos que ilustren conceptos ya documentados.

---
*© 2025-2026 AI Engineering Team*
