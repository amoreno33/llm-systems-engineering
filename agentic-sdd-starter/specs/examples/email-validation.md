# Spec: Email validation

Estado: Ready  
Owner: Platform Team  
Fecha: 2026-04-27  
Issue/Link: N/A

## 1. Problema

El sistema acepta emails inválidos en formularios internos, generando errores posteriores en notificaciones y soporte.

## 2. Objetivo

Agregar una función de validación reutilizable que determine si un email tiene formato aceptable para nuestro dominio de uso.

## 3. Alcance

Incluye:

- Validar string de email.
- Rechazar valores vacíos, nulos o sin dominio.
- Rechazar dominios descartables configurados.
- Agregar tests unitarios.

## 4. No-alcance

No incluye:

- Enviar emails de prueba.
- Validar existencia real del dominio vía DNS.
- Cambiar formularios existentes.
- Agregar dependencia externa.

## 5. Contrato / comportamiento esperado

### Inputs

- `email: string | null | undefined`

### Outputs

- `boolean`

### Reglas

- Debe contener exactamente una parte local y una parte de dominio.
- Debe contener `@`.
- El dominio debe tener al menos un punto.
- No debe permitir espacios.
- Debe rechazar dominios presentes en `DISPOSABLE_EMAIL_DOMAINS`.

### Casos de borde

- `""` → `false`
- `null` → `false`
- `"invalid"` → `false`
- `"test@example.com"` → `true`
- `"a@b"` → `false`

## 6. Criterios de aceptación

- [ ] La función retorna `true` para emails válidos.
- [ ] La función retorna `false` para entradas vacías o nulas.
- [ ] La función retorna `false` para emails sin dominio válido.
- [ ] La función retorna `false` para dominios descartables.
- [ ] Existen tests unitarios para los casos anteriores.

## 7. Tests esperados

- [ ] Caso feliz.
- [ ] Inputs nulos/vacíos.
- [ ] Formato inválido.
- [ ] Dominio descartable.

## 8. Impacto técnico

Archivos o módulos probablemente afectados:

- `src/lib/validation/email.ts`
- `tests/lib/validation/email.test.ts`

Dependencias nuevas:

- Ninguna.

Migraciones:

- No.

## 9. Riesgos y trade-offs

- No se valida existencia real del dominio. Se acepta porque no queremos I/O en esta función.
- Validación de email completa por RFC es innecesaria para este caso.

## 10. Plan de implementación

1. Crear función pura `isValidEmail`.
2. Agregar lista local de dominios descartables.
3. Agregar tests unitarios.
4. Correr verificación.

## 11. Validación

```bash
npm test
npm run typecheck
```

## 12. Notas para el agente

- No agregar librerías.
- No modificar formularios.
- No refactorizar validaciones existentes.
