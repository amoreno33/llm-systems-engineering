# 🧠 Obsidian como memoria persistente para sesiones con agentes

## El problema en una línea

**El agente no recuerda nada entre sesiones.** Cada vez que abrís una sesión nueva, arranca sin contexto: no sabe qué decidiste, qué descartaste, ni cómo está estructurado tu sistema.

## La solución

Obsidian es una aplicación de notas que guarda todo en archivos `.md` en tu disco. Eso significa que el agente puede leerlos directamente — sin APIs, sin exportaciones, sin configuración especial.

Usás Obsidian para guardar las decisiones, patrones y restricciones de tu proyecto. Al empezar cada sesión, le pasás las notas relevantes al agente como contexto. El agente ejecuta con información real del proyecto, no improvisa.

> **El agente es stateless. Obsidian le da estado.**

---

## Antes y después

**Sin Obsidian — sesión 4 de un proyecto:**

Le pedís al agente que agregue un módulo de descuentos. El agente genera:
- cálculos con `float` (vos usás `Decimal` para dinero — ya lo habías decidido)
- sugiere Google OAuth (el cliente lo rechazó en Sprint 2)
- guarda el carrito en PostgreSQL (está en Redis — decisión de arquitectura)

Perdiste tiempo corrigiendo cosas que ya estaban resueltas.

**Con Obsidian — misma sesión:**

Antes de pedirle al agente, le pasás:
- `decisiones/manejo-precios.md` → "Usar Decimal. Float tiene errores de precisión en dinero."
- `decisiones/auth.md` → "NO Google OAuth. Solo JWT. Decisión del cliente en Sprint 2."
- `arquitectura/carrito.md` → "El carrito vive en Redis, no en la base de datos."

El agente genera código consistente con el proyecto desde el primer intento.

---

## Cómo funciona: los links bidireccionales

La diferencia con un simple carpeta de archivos son los **links bidireccionales**: podés referenciar una nota desde otra con `[[nombre-nota]]`.

Ejemplo — nota `patrones/retry-con-backoff.md`:

```markdown
# Retry con Exponential Backoff

Cuando una llamada externa falla (Stripe, AWS), reintentar con delays crecientes.

## Dónde lo usamos
- [[api-pagos]] → Webhooks de Stripe
- [[mobile-app]] → Push notifications con Firebase

## NO hacer
- ❌ Reintentar errores 4xx (cliente equivocado, reintentar no cambia nada)
- ❌ Reintentar sin jitter (thundering herd — todos los workers reintentan juntos)

## Ver también
- [[idempotency-keys]] — Combinar con retry para evitar duplicados
```

Cuando tenés 20+ notas conectadas así, el Graph View de Obsidian muestra visualmente qué partes del sistema se relacionan entre sí. Eso también le da contexto al agente sobre el impacto de un cambio.

---

## Estructura de vault recomendada

```
📁 mi-vault/
├── 📁 decisiones/          ← ADRs: qué se decidió y por qué
│   ├── no-fastify.md
│   ├── decimal-para-precios.md
│   └── redis-para-carrito.md
├── 📁 arquitectura/        ← Patrones y diagramas del sistema
│   ├── retry-con-backoff.md
│   └── idempotency-keys.md
├── 📁 runbooks/            ← Procedimientos operativos
│   └── deploy-produccion.md
└── 📁 contexto-agente/     ← Lo que le pasás al agente cada sesión
    ├── stack.md
    ├── restricciones.md
    └── estado-actual.md
```

La carpeta `contexto-agente/` es la más práctica: es un resumen del estado actual del proyecto para pasarle al agente al inicio de cada sesión.

---

## Plugins útiles para integración con IA

| Plugin | Qué hace |
| :--- | :--- |
| **[Copilot](https://github.com/logancyang/obsidian-copilot)** | Chat con IA dentro de Obsidian usando tus notas como contexto |
| **[Smart Connections](https://github.com/brianpetro/obsidian-smart-connections)** | Encuentra notas relacionadas semánticamente, no solo por link |
| **[Templater](https://github.com/SilentVoid13/Templater)** | Templates dinámicos para crear decisiones y specs con estructura consistente |

---

## Por qué Obsidian y no Notion o Confluence

Los archivos `.md` son locales y legibles por cualquier herramienta. Notion y Confluence requieren API o exportación para que un agente los lea. Obsidian no requiere nada — el agente lee los archivos directamente desde el disco.

---

## Configurar tu vault (10 min)

1. Descargá [Obsidian](https://obsidian.md/) (gratis)
2. Creá un vault nuevo en la raíz de tu proyecto o en una carpeta compartida del equipo
3. Creá las carpetas `decisiones/`, `arquitectura/`, `contexto-agente/`
4. Escribí las 3-5 decisiones más importantes del proyecto actual
5. Conectalas con `[[links]]` donde corresponda

