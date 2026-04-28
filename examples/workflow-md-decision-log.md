# workflow.md — Ejemplo Real: Decision Log en Acción

Este archivo muestra cómo se ve un `workflow.md` después de 2 semanas de desarrollo.
**No es perfecto ni bonito. Es útil.**

---

```markdown
# Workflow — API Pagos Marketplace

## Decisiones de Arquitectura

### 2025-04-14 — Refunds como Worker Async
**Contexto:** El endpoint de refunds tardaba 8-12 segundos porque Stripe procesa lento.
**Decisión:** Mover refunds a un BullMQ worker con delay de 5 minutos.
**Razón:** El cliente no necesita confirmación inmediata; recibe email cuando completa.
**Impacto:** El endpoint ahora responde en <200ms con status 202 (Accepted).

### 2025-04-16 — Decimal.js para montos
**Contexto:** Encontramos un bug donde $19.99 * 3 = $59.96999... con floats.
**Decisión:** Usar Decimal.js para TODOS los cálculos monetarios.
**Impacto:** Refactorizar PaymentService y CartService. Tests actualizados.

### 2025-04-21 — NO migrar a Fastify
**Contexto:** El equipo propuso migrar de Express a Fastify por performance.
**Decisión:** Rechazado. El bottleneck es Stripe/DB, no el framework HTTP.
**Razón:** El costo de migración (2 sprints) no justifica la mejora (~15ms por request).

### 2025-04-23 — Retry strategy para webhooks
**Contexto:** Stripe envía webhooks que a veces fallan por timeout de nuestra DB.
**Decisión:** Implementar idempotency key + 3 retries con exponential backoff.
**Patrón:** Guardar `stripe_event_id` en tabla `processed_events` antes de procesar.

### 2025-04-28 — Cache de productos en Redis
**Contexto:** La página de checkout hacía 6 queries al catálogo por cada render.
**Decisión:** Cache de productos en Redis con TTL de 5 minutos.
**Caveat:** Invalidar cache manual cuando el admin actualiza precios (evento `product.updated`).
```

---

## ¿Por qué este archivo vale oro?

### Sin workflow.md (Sesión típica):
```
Tú: "Agregá un endpoint de refund"
Agente: *Crea un endpoint síncrono que llama a Stripe y espera 12 segundos*
Tú: "No, eso ya lo probamos y es muy lento"
Agente: "Ok, lo hago async"
Tú: "Usá BullMQ, ya tenemos Redis"
Agente: *Lo implementa pero usa floats para el monto*
Tú: "No! Usá Decimal.js!"
→ 6 mensajes desperdiciados. Contexto contaminado.
```

### Con workflow.md (Sesión con memoria):
```
Tú: "Agregá un endpoint de partial refund"
Agente: *Lee workflow.md y CLAUDE.md*
Agente: "Veo que los refunds son async con BullMQ (decisión 2025-04-14)
         y los montos usan Decimal.js (decisión 2025-04-16).
         Voy a crear el endpoint con status 202 y el worker
         con la misma estrategia. ¿Procedo?"
Tú: "Sí"
→ 2 mensajes. Contexto limpio. Resultado correcto.
```

> **El ahorro real:** 4 mensajes menos = menos ruido en la ventana de contexto = agente más preciso.
> En una sesión de 20 mensajes, eso es un 20% menos de piso de ruido.
