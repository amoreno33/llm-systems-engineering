# Specs

Cada cambio funcional no trivial debe partir de una spec.

## Cuándo crear spec

Crear spec para:

- features nuevas
- cambios de contrato
- cambios de comportamiento
- migraciones
- cambios de seguridad/auth/permisos
- integraciones externas
- flujos multi-archivo

No hace falta spec para:

- typo trivial
- actualización de copy menor
- comentario/documentación simple
- cambio mecánico ya especificado en issue

## Flujo

```bash
./scripts/new-spec.sh feature-name
```

Luego completar:

- problema
- contexto
- alcance
- no-alcance
- criterios de aceptación
- tests
- riesgos
- plan de implementación

## Regla

Si la spec no permite escribir tests claros, todavía no está lista.
