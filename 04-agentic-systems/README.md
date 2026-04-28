# 🤖 Agentic AI & Systems Execution

En la ingeniería de IA senior, el paso de "Chat" a "Agente" es el cambio fundamental de paradigma. Un agente no solo genera texto; **razona, planifica y actúa** sobre su entorno.

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

Sin importar si usás BMAD, LangGraph o CrewAI, el éxito de un agente senior depende de un solo concepto: **La especificación es el código del agente.**

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

### La Solución Senior: Spec antes de código
Obligamos al agente a trabajar sobre un artefacto determinístico:
1.  **Input:** La instrucción del usuario.
2.  **Plan:** El agente genera una `spec` (qué va a hacer, qué archivos toca, qué tests debe pasar).
3.  **Verificación:** El humano valida la `spec` antes de que el agente ejecute.
4.  **Ejecución:** El agente implementa basándose *estrictamente* en la `spec`.

> **Dato con respaldo:** El paper *"Chain of Specification: Enhancing LLM Reasoning"* (2024) demuestra que separar el diseño de la implementación mediante una especificación intermedia reduce errores de lógica en un **38%** vs. prompting directo.

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
[Volver al Inicio](../README.md)


