# CLAUDE.md Guide

## Niveles

### Global / managed

Para reglas de organización:

- seguridad
- compliance
- límites de datos
- estilo operativo
- restricciones de herramientas

### `~/.claude/CLAUDE.md`

Para preferencias personales:

- tono de respuestas
- comandos favoritos
- preferencias de explicación

No usar para reglas del equipo.

### `./CLAUDE.md`

Para reglas versionadas del proyecto:

- arquitectura
- comandos
- estándares de PR
- principios de ejecución
- Definition of Done

### `.claude/rules/*.md`

Para reglas modulares:

- por stack
- por path
- por dominio
- por tipo de cambio

### `CLAUDE.local.md`

Para notas locales no compartidas.

Nunca secretos.

## Qué hace bueno a un CLAUDE.md

Bueno:

```md
Si la tarea cambia comportamiento, agregá o actualizá tests.
No modifiques archivos fuera del scope sin justificarlo.
```

Malo:

```md
Escribí buen código.
Sé cuidadoso.
Usá mejores prácticas.
```

## Checklist

- [ ] ¿Es específico?
- [ ] ¿Es accionable?
- [ ] ¿Es corto?
- [ ] ¿Evita reglas obvias?
- [ ] ¿Incluye comandos reales?
- [ ] ¿Separa reglas globales de reglas del repo?
