# CLAUDE.md — Ejemplo Real: API de Pagos (Python + React)

Este es un ejemplo de un `CLAUDE.md` para un proyecto real.
**Copialo, adaptalo a tu stack y ponelo en la raíz de tu repo.**

---

```markdown
# CLAUDE.md

## Proyecto
API de procesamiento de pagos para marketplace. Python 3.12 + FastAPI + SQLAlchemy 2.0 + PostgreSQL 16. Frontend en React 18 + TypeScript + Vite.

## Arquitectura
- Backend: `backend/` (FastAPI) — Frontend: `frontend/` (React)
- API REST con FastAPI (NO usar Django REST Framework, decisión tomada en Sprint 3)
- Queue system: Celery con Redis 7
- Auth: JWT con refresh tokens (NO OAuth, el cliente lo rechazó)

## Convenciones de Código

### Backend (Python)
- Naming: `snake_case` para variables y funciones, `PascalCase` para clases
- Imports: usar imports absolutos desde `backend/`
- Errores: SIEMPRE usar `AppError` de `backend/shared/errors.py`. NUNCA raise Exception genérico.
- Responses: usar `success_response()` y `error_response()` de `backend/shared/responses.py`
- Tipado: SIEMPRE usar type hints. Si no sabés el tipo, usá `Any` con comentario explicativo.

### Frontend (React)
- Componentes: PascalCase, un componente por archivo
- Hooks: prefijo `use`, extraer lógica compleja a hooks custom
- Estado global: Zustand (NO Redux, decidido en Sprint 1)
- Fetching: React Query para server state. NO useState para datos remotos.
- Estilos: Tailwind CSS. NO crear CSS modules extra.

## Comandos

### Backend
- `uvicorn backend.main:app --reload` — Inicia el servidor (puerto 8000)
- `pytest` — Tests con coverage
- `pytest --watch` — Tests en modo watch (con pytest-watch)
- `alembic upgrade head` — Aplicar migraciones
- `alembic revision --autogenerate -m "descripcion"` — Crear migración
- `python -m backend.scripts.seed` — Seed de datos de prueba

### Frontend
- `npm run dev` — Inicia Vite en modo dev (puerto 5173)
- `npm run test` — Vitest con coverage
- `npm run build` — Build de producción
- `npm run lint` — ESLint + Prettier check

## Base de Datos
- Modelos en `backend/models/`
- Migraciones en `alembic/versions/`
- IMPORTANTE: Nunca borrar migraciones existentes. Crear nuevas para cambios.
- Relaciones: Un `User` tiene muchos `Payments`. Un `Payment` tiene un `PaymentMethod`.

## Errores Comunes (NO repetir)
- El middleware de auth está en `backend/middleware/auth.py`, NO crear otro
- La validación de montos usa `Decimal` de Python, NO usar `float` para dinero
- Redis connection string va en `REDIS_URL`, no en `REDIS_HOST` + `REDIS_PORT`
- El worker de refunds tiene un delay de 5 minutos por design (no es un bug)
- El proxy de Vite ya está configurado en `vite.config.ts` para `/api` → puerto 8000

## Testing
- Mocks de SQLAlchemy en `tests/conftest.py` (ya configurado con fixtures)
- Para tests de integración: usar `testcontainers` con PostgreSQL
- Coverage mínimo: 80% en líneas, 70% en branches
- Frontend: Vitest + React Testing Library. NO usar Enzyme.

## Seguridad
- NUNCA loguear tarjetas de crédito, ni parcialmente
- Los tokens de pago de Stripe van en `STRIPE_SECRET_KEY` (env var)
- Rate limiting: 100 requests/min por IP (configurado en `backend/middleware/rate_limit.py`)

## Memoria de Proyecto
- Mantené un log de decisiones técnicas en `workflow.md`
- Antes de proponer un cambio de arquitectura, consultá `workflow.md`
```

---

## ¿Por qué este CLAUDE.md es efectivo?

1. **"NO usar Django REST Framework"** → Le ahorra al agente proponer algo que ya fue descartado.
2. **"El worker de refunds tiene un delay de 5 minutos"** → Evita que el agente lo "arregle" como si fuera un bug.
3. **"`Decimal` de Python para dinero"** → Previene un error clásico con `float` en contextos financieros.
4. **"NO Redux"** → Evita que el agente agregue complejidad innecesaria al estado.
5. **Comandos exactos para backend y frontend** → El agente puede correr tests sin adivinar.

> **Tip:** Este archivo se cachea automáticamente por Anthropic (Prompt Caching). 
> Si pesa menos de 1024 tokens, se procesa en la zona de alta atención del Transformer.
> Cada sesión nueva lo lee primero → **el agente siempre arranca orientado**.
