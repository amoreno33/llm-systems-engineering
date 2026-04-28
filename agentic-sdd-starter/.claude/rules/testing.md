---
description: Reglas para pruebas y verificación.
---

# Testing Rules

Aplicar cuando el cambio altere comportamiento, contratos, errores, validaciones, cálculos o integraciones.

## Reglas

- Cada cambio de comportamiento requiere test nuevo o actualizado.
- Tests deben cubrir casos felices, errores y bordes relevantes.
- No borrar tests para hacer pasar la suite.
- No relajar asserts sin justificarlo.
- Si no se agregan tests, explicar por qué no aplican.

## Estilo

- Tests legibles antes que ultra-DRY.
- Nombres de tests con comportamiento observable.
- Evitar mocks excesivos cuando una prueba de integración simple sea más útil.
