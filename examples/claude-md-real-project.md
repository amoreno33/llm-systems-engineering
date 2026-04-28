# CLAUDE.md — Ejemplo Real: API de Pagos (Node.js + TypeScript)

Este es un ejemplo de un `CLAUDE.md` para un proyecto real.
**Copialo, adaptalo a tu stack y ponelo en la raíz de tu repo.**

---

```markdown
# CLAUDE.md

## Proyecto
API de procesamiento de pagos para marketplace. Node.js 20 + TypeScript 5.4 + Prisma ORM + PostgreSQL 16.

## Arquitectura
- Monorepo con Turborepo: `packages/api`, `packages/shared`, `packages/workers`
- API REST con Express.js (NO usar Fastify, decisión tomada en Sprint 3)
- Queue system: BullMQ con Redis 7
- Auth: JWT con refresh tokens (NO OAuth, el cliente lo rechazó)

## Convenciones de Código
- Naming: camelCase para variables, PascalCase para tipos/interfaces
- Imports: usar `@/` como alias para `src/`
- Errores: SIEMPRE usar `AppError` de `@/shared/errors`. NUNCA throw Error genérico.
- Responses: usar `ApiResponse.success()` y `ApiResponse.error()` de `@/shared/responses`
- NO usar `any`. Si no sabés el tipo, usá `unknown` y hacé type narrowing.

## Comandos
- `npm run dev` — Inicia el servidor en modo watch (puerto 3001)
- `npm run test` — Jest con coverage
- `npm run test:watch` — Jest en modo watch
- `npm run db:migrate` — Prisma migrate dev
- `npm run db:seed` — Seed de datos de prueba
- `npm run lint` — ESLint + Prettier check

## Base de Datos
- Esquema en `prisma/schema.prisma`
- Migraciones en `prisma/migrations/`
- IMPORTANTE: Nunca borrar migraciones existentes. Crear nuevas para cambios.
- Relaciones: Un `User` tiene muchos `Payments`. Un `Payment` tiene un `PaymentMethod`.

## Errores Comunes (NO repetir)
- El middleware de auth está en `src/middleware/auth.ts`, NO crear otro
- La validación de montos usa `Decimal.js`, NO usar `parseFloat` para dinero
- Redis connection string va en `REDIS_URL`, no en `REDIS_HOST` + `REDIS_PORT`
- El worker de refunds tiene un delay de 5 minutos por design (no es un bug)

## Testing
- Mocks de Prisma en `__mocks__/prisma.ts` (ya configurado)
- Para tests de integración: usar `testcontainers` con PostgreSQL
- Coverage mínimo: 80% en líneas, 70% en branches

## Seguridad
- NUNCA loguear tarjetas de crédito, ni parcialmente
- Los tokens de pago de Stripe van en `STRIPE_SECRET_KEY` (env var)
- Rate limiting: 100 requests/min por IP en producción

## Memoria de Proyecto
- Mantené un log de decisiones técnicas en `workflow.md`
- Antes de proponer un cambio de arquitectura, consultá `workflow.md`
```

---

## ¿Por qué este CLAUDE.md es efectivo?

1. **"NO usar Fastify"** → Le ahorra al agente proponer algo que ya fue descartado.
2. **"El worker de refunds tiene un delay de 5 minutos"** → Evita que el agente lo "arregle" como si fuera un bug.
3. **"`Decimal.js` para dinero"** → Previene un error clásico de alucinación financiera.
4. **Comandos exactos** → El agente puede correr tests sin adivinar.

> **Tip:** Este archivo se cachea automáticamente por Anthropic (Prompt Caching). 
> Si pesa menos de 1024 tokens, se procesa en la zona de alta atención del Transformer.
> Cada sesión nueva lo lee primero → **el agente siempre arranca orientado**.
