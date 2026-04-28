# Project Agent Instructions

Este archivo define el contrato operativo para agentes de coding en este repositorio.

Debe mantenerse **corto, específico y accionable**. Las reglas extensas o específicas por stack deben vivir en `.claude/rules/`.

## 1. Working Agreement

Antes de modificar código:

- Releer la solicitud y convertirla en un objetivo concreto.
- Identificar ambigüedades, supuestos y riesgos.
- Si falta información crítica, preguntar antes de implementar.
- Si la tarea menciona una spec, seguir la spec como fuente de verdad.
- Si no existe spec para un cambio no trivial, proponer crear una antes de codear.

Durante la implementación:

- Hacer el cambio mínimo que cumple la spec o el requerimiento.
- No agregar abstracciones, flags, frameworks, dependencias ni flexibilidad futura salvo que la spec lo requiera.
- No refactorizar, renombrar, reformatear ni reorganizar código no relacionado.
- Editar solo archivos necesarios para el objetivo.
- Si parece necesario ampliar el scope, explicar por qué antes de hacerlo.

Antes de finalizar:

- Ejecutar checks relevantes: lint, typecheck, tests, build.
- Si un check no puede ejecutarse, explicar la razón y dejar el comando exacto.
- Resumir archivos modificados, decisiones, riesgos y cómo verificar.
- Nunca afirmar que algo fue probado si no se ejecutó realmente.

## 2. Specification Driven Development

Para cambios funcionales, usar SDD:

1. **Spec**
   - Problema
   - Alcance
   - No-alcance
   - Contrato esperado
   - Casos de borde
   - Criterios de aceptación
   - Tests esperados

2. **Plan**
   - Archivos a modificar
   - Tests a crear/actualizar
   - Riesgos conocidos
   - Decisiones pendientes

3. **Implementación**
   - Cambio mínimo
   - Tests primero o en paralelo
   - Sin refactors oportunistas

4. **Verificación**
   - Tests relevantes
   - Typecheck/lint/build
   - Validación explícita contra criterios de aceptación

## 3. Scope Control

Reglas estrictas:

- No modificar archivos fuera del alcance sin justificarlo.
- No tocar configuración global, CI/CD, permisos, auth o seguridad salvo que la tarea lo pida.
- No cambiar contratos públicos sin spec o aprobación explícita.
- No introducir migraciones, cambios destructivos o scripts de datos sin plan de rollback.

## 4. Commands

Personalizar para cada repo.

```bash
npm run lint
npm run typecheck
npm test
npm run build
```

Comando integrado:

```bash
./scripts/verify.sh
```

## 5. PR Output

Al terminar, entregar:

```md
## Summary
- Qué cambió y por qué.

## Files changed
- Lista breve de archivos relevantes.

## Verification
- Comandos ejecutados y resultado.
## Memoria de Contexto Persistente
- Mantén un log de decisiones críticas en `workflow.md`. 
- Si hay un cambio en la arquitectura o una decisión de diseño importante, documéntala allí antes de finalizar la tarea.
- Usa ese archivo para sincronizar el contexto entre sesiones largas.

## Risks
- Riesgos, trade-offs o supuestos.

## Follow-ups
- Tareas no incluidas en este cambio.
```

## 6. Anti-patterns

Evitar explícitamente:

- Asumir requisitos.
- “Ya que estoy” refactorizar.
- Agregar arquitectura futura no pedida.
- Cambiar muchos archivos para una tarea pequeña.
- Entregar sin tests o sin explicar por qué no aplican.
- Ocultar incertidumbre.
