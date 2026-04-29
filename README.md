# 🧠 LLM Systems Engineering: Guía Práctica

Una guía práctica para desarrolladores de IA que buscan iniciarse o reforzar conocimientos en el desarrollo de sistemas basados en LLMs.

El contenido abarca desde fundamentos técnicos hasta implementación en producción, incluyendo optimización de costos, RAG avanzado, sistemas agénticos, arquitecturas cloud (AWS/Azure) y seguridad.

---

## 🗺️ Mapa de Navegación

| Sección | Core Focus | Valor para Ingeniería de IA |
| :--- | :--- | :--- |
| **[01. Foundations](./01-foundations/README.md)** | Modern Core | Optimización de costos (tokens) y control de determinismo. |
| **[02. LLM Engineering](./02-llm-engineering/README.md)** | Intelligence Layer | Mitigación de alucinaciones y dominio de la RAM del agente. |
| **[03. Advanced RAG](./03-advanced-rag/README.md)** | Expert Retrieval | Precisión quirúrgica en datos corporativos vs. "Naive RAG". |
| **[04. Agentic Systems](./04-agentic-systems/README.md)** | Action & Reasoning | Orquestación de flujos de trabajo autónomos verificables. |
| **[05. Cloud](./05-cloud-architectures/README.md)** | AWS & Azure | Escalabilidad, gobernanza y estrategia multi-nube. |
| **[06. Ops & Security](./06-llmops-security/README.md)** | Governance | Seguro contra ciberataques y observabilidad en producción. |

### [07. High-Value Resources](./07-high-value-resources/README.md)
*   Listado curado de papers, repositorios de referencia y herramientas "State of the Art".

---

## 🚀 Filosofía de Trabajo: De Vibe Coding a SDD

### El problema: Vibe Coding no escala

El "vibe coding" es el modo por defecto cuando empezás con agentes: describís lo que querés, el agente genera, revisás el resultado, señalás lo que está mal, el agente lo intenta de nuevo. Funciona para prototipos rápidos. No funciona para sistemas reales.

Los problemas acumulados del vibe coding sin estructura:
- **Sesiones sin memoria**: cada conversación empieza desde cero, el agente no sabe qué decidiste la semana pasada
- **Código desechable**: el agente optimiza para el prompt actual, no para el sistema a largo plazo
- **Deuda técnica acelerada**: un agente puede generar entropía 10x más rápido que un humano (ver [Patrón 4: Ball of Mud](./04-agentic-systems/README.md))
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

> **Dato con respaldo:** Separar diseño de implementación mediante una especificación intermedia reduce errores de lógica en un **38%** vs. prompting directo. *(Chain of Specification: Enhancing LLM Reasoning, 2024)*

> *Conceptos basados en [Spec-Driven Development for AI Coding Agents](https://learn.deeplearning.ai/) — DeepLearning.AI*

Para ver cómo esto se implementa con archivos reales, consultá el [Agentic SDD Starter](./agentic-sdd-starter/README.md) y los [Templates listos para usar](./07-high-value-resources/README.md#-templates--starter-kits).

---

## 🚀 Getting Started

Esta sección está diseñada para ayudar a nuevos usuarios y equipos a integrar este proyecto en sus flujos de trabajo de manera eficiente.

### 1. Requisitos Previos
Antes de comenzar, asegúrate de tener lo siguiente:
- **Entorno de desarrollo**: Node.js (v16 o superior) y Python (v3.9 o superior).
- **Dependencias**: Instala las dependencias necesarias ejecutando `npm install` y configurando el entorno virtual de Python.
- **Acceso a herramientas**: Asegúrate de tener acceso a las herramientas mencionadas en las secciones específicas (por ejemplo, OpenAI API, bases de datos vectoriales).

### 2. Configuración Inicial
1. Clona este repositorio:
   ```bash
   git clone https://github.com/tu-usuario/tu-repositorio.git
   cd tu-repositorio
   ```
2. Configura las variables de entorno necesarias:
   - Copia el archivo `.env.example` y renómbralo a `.env`.
   - Llena las variables requeridas, como claves de API y configuraciones específicas.

3. Ejecuta los scripts de inicialización:
   ```bash
   npm run setup
   ```

### 3. Ejecución de Ejemplos
- **Ejemplo 1**: Integración de un flujo de trabajo básico con prompts optimizados.
  ```bash
  python examples/semantic_cache_example.py
  ```
- **Ejemplo 2**: Uso de especificaciones para agentes autónomos.
  ```bash
  npm run agent-example
  ```

---

## 📝 Model Card

### Descripción General
Este proyecto está diseñado para quienes trabajan con sistemas de IA avanzados. Proporciona herramientas y guías para construir sistemas escalables, seguros y eficientes.

### Características Clave
- **Optimización de costos**: Técnicas para reducir el uso de tokens y mejorar la eficiencia.
- **Seguridad**: Estrategias para proteger sistemas de IA en producción.
- **Adopción empresarial**: Guías prácticas para integrar IA en flujos de trabajo corporativos.

### Limitaciones
- **Dependencia de herramientas externas**: Algunas funcionalidades requieren acceso a APIs de terceros.
- **Curva de aprendizaje**: El contenido está diseñado para usuarios con experiencia técnica avanzada.

### Casos de Uso
1. **Optimización de Prompts**: Mejora de prompts para tareas específicas como generación de texto o clasificación.
2. **RAG Avanzado**: Implementación de técnicas de recuperación de datos para mejorar la precisión en sistemas empresariales.
3. **Agentes Autónomos**: Creación de agentes que pueden razonar, planificar y ejecutar tareas de manera autónoma.

---

## 📂 Ejemplos Prácticos (Copy-Paste Ready)

| Ejemplo | Qué vas a encontrar |
| :--- | :--- |
| **[CLAUDE.md para un proyecto real](./examples/claude-md-real-project.md)** | Un `CLAUDE.md` completo para una API de pagos (Node.js/TypeScript). Copialo y adaptalo. |
| **[Decision Log (workflow.md)](./examples/workflow-md-decision-log.md)** | Cómo se ve un log de decisiones después de 2 semanas de desarrollo. Con antes/después. |
| **[Obsidian como Second Brain](./examples/obsidian-second-brain.md)** | Estructura de vault, notas con links bidireccionales, Graph View y plugins de IA. |
| **[Antes vs Después: Prompts Reales](./examples/antes-despues-prompts.md)** | 5 escenarios reales: el prompt vago vs. el prompt optimizado. La diferencia es brutal. |

---

## 🛠️ Contribución

Este es un repositorio vivo. Esperamos contribuciones que suban el nivel técnico:
1.  Nuevos patrones de RAG probados en producción.
2.  Benchmarks de modelos en tareas específicas de nuestra industria.
3.  Scripts de automatización y hooks de seguridad.

---
*© 2024-2025 AI Engineering Team | Partner de AWS & Microsoft*
