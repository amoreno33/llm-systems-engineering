---
paths:
  - "src/api/**"
  - "app/api/**"
  - "server/**"
  - "tests/api/**"
description: Reglas para diseño e implementación de APIs.
---

# API Design Rules

## Contrato

- Validar inputs en el borde.
- Responder errores con formato consistente.
- No cambiar status codes ni response shape sin spec.
- Mantener compatibilidad hacia atrás salvo indicación contraria.

## Implementación

- Mantener handlers pequeños.
- Separar parsing/validación de lógica de dominio.
- No introducir side effects ocultos.
- Agregar tests para:
  - input válido
  - input inválido
  - auth/permisos si aplica
  - errores de dominio
