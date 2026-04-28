# Agent Workflow

## Objetivo

Estandarizar cómo un agente trabaja sobre este repo.

## Flujo

```txt
Request / Issue
   ↓
Spec SDD
   ↓
Clarifying questions
   ↓
Implementation plan
   ↓
Minimal code change
   ↓
Tests / validation
   ↓
PR summary
```

## Prompts recomendados

### Crear spec

```txt
A partir de este issue, generá una spec en specs/<nombre>.md usando specs/_template.md.
No implementes código todavía. Si hay ambigüedad, listá preguntas.
```

### Implementar spec

```txt
Implementá specs/<nombre>.md siguiendo CLAUDE.md.
Antes de editar, resumí objetivo, alcance, archivos probables y tests.
Si algo es ambiguo, preguntá.
```

### Revisar PR

```txt
Revisá este diff contra la spec.
Buscá cambios fuera de scope, over-engineering, tests faltantes y riesgos.
No propongas refactors no relacionados.
```

## Definition of Done agentic

- La spec está completa.
- El cambio es mínimo.
- Hay tests relevantes.
- Pasan checks.
- El PR explica riesgos y verificación.
