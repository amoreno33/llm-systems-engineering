# 🚀 Agentic SDD Starter (Specification Driven Development)

Este repositorio no es un competidor de BMAD, es su **motor de ejecución técnica**. Mientras que BMAD orquesta el "quién" y el "cuándo" (visión estratégica), SDD orquesta el **"cómo" se escribe código verificable** que sigue las reglas del repo.

> **Principio Clave:** El agente no improvisa código. El agente ejecuta una especificación verificable contra reglas operativas rígidas.


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
