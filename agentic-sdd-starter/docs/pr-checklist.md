# PR Checklist for Agentic Changes

## Scope

- [ ] El PR referencia una spec o issue claro.
- [ ] El diff toca solo archivos necesarios.
- [ ] No hay refactors oportunistas.
- [ ] No hay dependencias nuevas injustificadas.

## Behavior

- [ ] Los criterios de aceptación están cubiertos.
- [ ] Los casos de borde relevantes están cubiertos.
- [ ] No se rompió compatibilidad sin indicarlo.

## Verification

- [ ] Tests agregados/actualizados.
- [ ] Lint ejecutado.
- [ ] Typecheck ejecutado.
- [ ] Build ejecutado si aplica.

## Security

- [ ] No hay secretos.
- [ ] No se ampliaron permisos sin justificación.
- [ ] No hay nuevos comandos peligrosos.
- [ ] MCP/tool access revisado si aplica.

## Review

- [ ] Summary claro.
- [ ] Riesgos y trade-offs documentados.
- [ ] Follow-ups separados del scope actual.
