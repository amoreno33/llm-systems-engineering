# 🚀 Agentic SDD Starter (Specification Driven Development)

El desarrollo se organiza alrededor de especificaciones explícitas.

Cada especificación define el comportamiento esperado del sistema de forma concreta: qué debe hacer, bajo qué condiciones y con qué criterios de validación.

Estas especificaciones no actúan como documentación pasiva. Son **artefactos operativos** que:

- guían la implementación
- restringen el espacio de soluciones
- permiten validar resultados de forma consistente

Los agentes no operan sobre prompts aislados ni contexto implícito. Ejecutan tareas definidas por especificaciones, dentro de un marco donde las reglas, supuestos y resultados esperados están previamente definidos.

Esto elimina la dependencia de iteraciones ad hoc y reduce la ambigüedad en el proceso de desarrollo.

> **Principio clave:** sin especificación, no hay implementación.


## Qué incluye

```txt
.
├── CLAUDE.md
├── CLAUDE.local.example.md
├── .claude/
│   ├── CLAUDE.md
│   ├── settings.json
│   ├── rules/
│   │   ├── api-design.md
│   │   ├── architecture.md
│   │   ├── security.md
│   │   ├── testing.md
│   │   └── typescript.md
│   └── hooks/
│       ├── block-dangerous-bash.sh
│       ├── check-scope.sh
│       ├── require-spec.sh
│       └── summarize-session.sh
├── specs/
│   ├── README.md
│   ├── _template.md
│   └── examples/email-validation.md
├── docs/
│   ├── agent-workflow.md
│   ├── adoption-playbook.md
│   ├── claude-md-guide.md
│   ├── mcp-security.md
│   └── pr-checklist.md
├── .github/
│   └── pull_request_template.md
├── scripts/
│   ├── verify.sh
│   └── new-spec.sh
└── package.json
```

## Filosofía

Este repo está diseñado para equipos técnicos con experiencia. No busca “enseñar prompting básico”, sino convertir el uso de agentes en un sistema repetible:

1. **Spec antes que código**
2. **Criterios verificables antes que implementación**
3. **Cambios mínimos y localizados**
4. **Hooks para controles determinísticos**
5. **MCP con permisos mínimos y revisión de seguridad**
6. **PRs auditables**

## Flujo recomendado

```txt
1. Crear spec
   ./scripts/new-spec.sh nombre-feature

2. Completar spec:
   - problema
   - alcance
   - no-alcance
   - criterios de aceptación
   - tests esperados
   - riesgos

3. Pedir al agente:
   "Implementá specs/nombre-feature.md siguiendo CLAUDE.md"

4. El agente:
   - lee la spec
   - identifica ambigüedades
   - pregunta si falta información crítica
   - implementa el cambio mínimo
   - agrega/actualiza tests
   - corre verificación

5. Abrir PR con checklist
```

## Instalación sugerida

```bash
chmod +x .claude/hooks/*.sh scripts/*.sh
./scripts/verify.sh
```

## Qué personalizar primero

1. `CLAUDE.md`: descripción real del repo, comandos y arquitectura.
2. `.claude/rules/*.md`: reglas por stack.
3. `.claude/settings.json`: hooks y permisos.
4. `specs/_template.md`: formato de spec del equipo.
5. `.github/pull_request_template.md`: criterios de revisión.

## Principio clave

> Un agente sin spec improvisa. Un agente con spec ejecuta.

---

## 📚 Documentación adicional

| Doc | Qué explica |
| :--- | :--- |
| **[Agent Workflow](./docs/agent-workflow.md)** | Flujo completo de trabajo con el agente. |
| **[Adoption Playbook](./docs/adoption-playbook.md)** | Cómo adoptar SDD en equipo. |
| **[CLAUDE.md Guide](./docs/claude-md-guide.md)** | Cómo escribir un CLAUDE.md efectivo. |
| **[MCP Security](./docs/mcp-security.md)** | Seguridad en servidores MCP. |
| **[PR Checklist](./docs/pr-checklist.md)** | Checklist para pull requests con agentes. |
