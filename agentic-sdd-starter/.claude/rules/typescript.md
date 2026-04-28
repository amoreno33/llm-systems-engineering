---
paths:
  - "**/*.ts"
  - "**/*.tsx"
description: Reglas para TypeScript.
---

# TypeScript Rules

- No usar `any` salvo que exista justificación explícita.
- Preferir tipos derivados de contratos existentes antes que duplicar shapes.
- Evitar type assertions (`as`) para ocultar errores.
- No cambiar `tsconfig` sin spec.
- Mantener imports ordenados según convención del proyecto.
- Ejecutar typecheck antes de terminar.
