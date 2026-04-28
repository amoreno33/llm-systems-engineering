# Adoption Playbook

## Fase 1: Piloto

Elegir 1 equipo y 1 tipo de tarea repetible:

- validaciones
- endpoints pequeños
- bugs con reproducción clara
- refactors mecánicos acotados
- documentación técnica

Evitar al inicio:

- auth compleja
- migraciones destructivas
- cambios multi-servicio
- incident response
- código legacy sin tests

## Fase 2: Estandarización

- Ajustar `CLAUDE.md`.
- Crear reglas en `.claude/rules/`.
- Crear 3–5 specs de ejemplo.
- Definir hooks obligatorios.
- Agregar PR checklist.

## Fase 3: Medición

Métricas útiles:

- tamaño del diff
- cantidad de archivos tocados
- tests agregados
- rework en review
- defectos post-merge
- tiempo issue → PR
- cantidad de preguntas aclaratorias correctas

## Fase 4: Escalado

- Crear managed instructions globales.
- Mantener reglas por stack.
- Revisar permisos MCP.
- Auditar hooks y settings.
- Entrenar al equipo con ejemplos reales.
