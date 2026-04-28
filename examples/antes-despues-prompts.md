# ❌ vs ✅ — Antes y Después: Prompts Reales

Estos son ejemplos reales de cómo un cambio pequeño en el prompt 
produce un resultado dramáticamente diferente.

---

## 1. El "Hazme Todo" vs. El Spec-Scoped

### ❌ Lo que hace el 90% de los devs:
```
"Implementá el sistema de autenticación con JWT, refresh tokens, 
registro, login, logout, reset de password y 2FA"
```
**Resultado:** El agente genera 800 líneas de código monolítico, 
inventa nombres de tablas, usa librerías que no tenés en el proyecto 
y mezcla Express con Fastify porque "le pareció mejor".

### ✅ Lo que hace un Senior con Spec-First:
```
"Implementá SOLO el endpoint POST /auth/login según esta spec:

Input: { email: string, password: string }
Output exitoso: { accessToken: string, refreshToken: string }
Output error: { error: string, code: 'INVALID_CREDENTIALS' | 'ACCOUNT_LOCKED' }

Reglas:
- Usar bcrypt para comparar passwords (ya está en package.json)
- JWT con secret de env var JWT_SECRET
- Access token expira en 15 minutos
- Refresh token expira en 7 días
- Guardar refresh token en tabla RefreshToken (ya existe en Prisma schema)
- Si el password falla 5 veces, lockear la cuenta 30 minutos
- Loguear intentos fallidos con winston (ya configurado)

NO hacer: registro, logout, reset de password, 2FA, ni middleware de auth.
Eso viene en otra spec."
```
**Resultado:** El agente genera exactamente lo pedido. 
120 líneas. Sin inventos. Testeable.

---

## 2. El Bug Report Vago vs. El Quirúrgico

### ❌ Típico:
```
"El login no funciona, arreglalo"
```
**Resultado:** El agente reescribe toda la autenticación porque no sabe 
qué parte está rota. Probablemente rompe algo que sí funcionaba.

### ✅ Senior:
```
"El endpoint POST /auth/login devuelve 500 cuando el email no existe en la DB.

Esperado: devolver 401 con { error: 'INVALID_CREDENTIALS' }
Actual: Prisma tira un error 'Record not found' que no se catchea

El error está probablemente en src/services/AuthService.ts, 
método `login()`, alrededor de la línea donde hace 
`prisma.user.findUniqueOrThrow()`.

Fix probable: cambiar a `findUnique()` y checkear null manualmente."
```
**Resultado:** El agente va directo al archivo, cambia 3 líneas, 
agrega el test para el caso null. Listo.

---

## 3. El Stack Trace Completo vs. El Recortado

### ❌ Copiar y pegar 200 líneas de error:
```
"Me sale este error:
Error: Cannot read properties of undefined (reading 'map')
    at Object.<anonymous> (/Users/dev/project/node_modules/...
    at Module._compile (node:internal/modules/cjs/loader:1364:14)
    at Module._extensions..js (node:internal/modules/cjs/loader:...
    at Module.load (node:internal/modules/cjs/loader:1206:32)
    ... (180 líneas más de node internals)
    at processTicksAndRejections (node:internal/process/task_queues:95:5)"
```
**Resultado:** 200 líneas de ruido en tu ventana de contexto. 
El agente se pierde analizando internals de Node.

### ✅ Solo lo relevante:
```
"Error en src/services/PaymentService.ts:47
→ Cannot read properties of undefined (reading 'map')

La línea 47 es: `const items = order.items.map(i => i.toPayment())`

Sospecho que `order.items` es undefined cuando el pedido 
no tiene productos (caso edge de carrito vacío)."
```
**Resultado:** El agente entiende el problema en 3 líneas. 
Fix en 30 segundos.

---

## 4. El "OK" Desperdiciado vs. El "OK" con Contexto

### ❌ Típico:
```
Agente: "¿Procedo con la implementación?"
Tú: "dale"
```
**Resultado:** Desperdiciaste un turno de prompt donde podías 
inyectar contexto valioso.

### ✅ Senior:
```
Agente: "¿Procedo con la implementación?"
Tú: "Sí, avanzá. Tené en cuenta que ese módulo usa 
inyección de dependencias con tsyringe y que los tests 
mockean el PaymentGateway con jest.mock(). 
No uses new PaymentGateway() directo."
```
**Resultado:** Le diste 2 datos cruciales en un mensaje 
que ibas a mandar de todas formas. Sin costo extra. 
Sin gastar un turno adicional.

---

## 5. El Prompt de Code Review

### ❌ "Revisá este PR":
```
"Revisá el código de este PR y decime si está bien"
```
**Resultado:** El agente te dice que "el código se ve bien" 
y te marca 40 cosas irrelevantes de estilo.

### ✅ Review con criterios:
```
"Revisá este diff enfocándote SOLO en:

1. Errores de lógica de negocio (no estilo ni formatting)
2. Posibles null pointer exceptions
3. Queries N+1 de Prisma
4. Secretos hardcodeados
5. Race conditions en operaciones async

Ignorá: naming conventions, imports order, comentarios.
Si no encontrás problemas en esas 5 categorías, decí 
'LGTM - No hay issues críticos' y nada más."
```
**Resultado:** Review enfocado. Encuentra un N+1 real 
que el equipo no vio. Valor inmediato.

---

## Resumen Visual

```
┌──────────────────────────────────────────────┐
│          PROMPT VAGO                         │
│  → Contexto ambiguo                         │
│  → Agente improvisa                         │
│  → Resultado imprevisible                   │
│  → Múltiples idas y vueltas                 │
│  → Ventana de contexto contaminada          │
└──────────────────────────────────────────────┘
                    vs.
┌──────────────────────────────────────────────┐
│          PROMPT SPEC-FIRST                   │
│  → Input/Output definidos                   │
│  → Agente ejecuta                           │
│  → Resultado verificable                    │
│  → 1-2 mensajes                             │
│  → Ventana de contexto limpia               │
└──────────────────────────────────────────────┘
```

> **La diferencia no es "saber más sobre IA".**
> **Es saber formular lo que querés con precisión.**
> Un junior pide features. Un senior escribe specs.
