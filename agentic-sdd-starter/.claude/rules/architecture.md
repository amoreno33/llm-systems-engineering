---
description: Reglas de arquitectura general del repositorio.
---

# Architecture Rules

Aplicar cuando el cambio toque estructura, módulos, dependencias, boundaries o contratos públicos.

## Reglas

- Mantener boundaries existentes entre módulos.
- No introducir nuevas capas sin una razón vinculada a la spec.
- Preferir composición simple sobre patrones complejos.
- No mover archivos o cambiar nombres públicos salvo que la spec lo pida.
- Si un cambio requiere tocar más de 3 áreas del sistema, detenerse y explicar el plan.

## Preguntas obligatorias ante ambigüedad

- ¿Cuál es el contrato público afectado?
- ¿Qué consumidores dependen de este comportamiento?
- ¿Existe una forma local de resolverlo sin cambiar arquitectura?
