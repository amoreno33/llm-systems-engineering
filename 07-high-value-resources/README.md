# 📚 High-Value Resources for AI Engineers

Lista de referencia de herramientas, frameworks y recursos con links verificados.

---

## 📖 Conceptos Fundamentales

**→ Lee esta sección primero si ves términos desconocidos en el resto del repo.**

Antes de profundizar en herramientas, es importante entender estos conceptos que se mencionan frecuentemente en desarrollo con IA:

### TDD (Test-Driven Development)
Metodología de desarrollo donde escribís **tests antes del código**. El ciclo es:
1. **RED**: Escribir un test que falle
2. **GREEN**: Escribir el código mínimo para que pase
3. **REFACTOR**: Mejorar el código sin romper el test

> **Por qué importa con agentes:** Sin tests, el agente no tiene feedback sobre si su código funciona. El TDD le da un loop de validación automático.

**Lectura recomendada:** *Test Driven Development: By Example* — Kent Beck

---

### Domain-Driven Design (DDD)
Enfoque de desarrollo que prioriza crear un **lenguaje compartido** entre desarrolladores y expertos del dominio. En lugar de decir "usuario", "cliente", "account holder" indistintamente, el equipo acuerda un solo término.

> **Por qué importa con agentes:** Un archivo `CONTEXT.md` con el lenguaje del proyecto hace que el agente genere código con nombres consistentes y reduzca ambigüedades.

**Lectura recomendada:** *Domain-Driven Design* — Eric Evans

---

### ADR (Architecture Decision Record)
Documento que registra **decisiones técnicas importantes** y su contexto. Por ejemplo: "¿Por qué usamos Zod en lugar de Joi para validación?"

> **Por qué importa con agentes:** En lugar de explicar la misma decisión 20 veces, le decís al agente "lee ADR 003". Es tu memoria de largo plazo.

**Template recomendado:** [adr/madr](https://github.com/adr/madr)

---

### Grilling Session
Técnica donde, en lugar de darle instrucciones directas al agente, hacés que **te interrogue primero** sobre lo que realmente querés construir. Reduce desalineamiento.

> **Por qué importa con agentes:** Nadie sabe exactamente lo que quiere hasta que lo articula. La grilling session te obliga a pensar antes de que el agente genere código que después tenés que tirar.

**Ejemplo:**
```
❌ "Haceme un sistema de pagos"
✅ "Necesito pagos. Antes de empezar, preguntame sobre:
    casos de uso, monedas, recurrencia, webhooks, etc."
```

**Referencia:** Matt Pocock Skills — `/grill-me`

---

## 🌟 Repositorios de Referencia
*   **[LangGraph Garden](https://github.com/langchain-ai/langgraph):** Ejemplos avanzados de arquitecturas de agentes cíclicos.
*   **[Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook):** Ejemplos y mejores prácticas para la API de Claude.
*   **[OpenAI Cookbook](https://github.com/openai/openai-cookbook):** Ejemplos y guías para GPT-4o y o1.
*   **[Microsoft GraphRAG](https://github.com/microsoft/graphrag):** Repositorio oficial para implementar RAG basado en grafos.
*   **[Promptfoo](https://github.com/promptfoo/promptfoo):** Testing y evaluación de prompts.
*   **[Matt Pocock Skills](https://github.com/mattpocock/skills):** Skills modulares para ingeniería con agentes de IA.

## 🤖 Frameworks y Metodologías para Agentes

*   **[BMAD Method](https://bmad.ai/):** Build, Measure, Adjust, Deploy. Framework completo para desarrollo con agentes en ciclo de vida completo.
*   **[Spec-Kit](https://github.com/spec-kit):** Framework para desarrollo basado en especificaciones verificables y modulares.
*   **[SDD Starter](../agentic-sdd-starter/):** Specification-Driven Development. Incluido en este repo con templates de `CLAUDE.md` y `CONTEXT.md`.

## 📰 Newsletters & Blogs Técnicos

*   **[The Batch (DeepLearning.AI)](https://www.deeplearning.ai/the-batch/):** Newsletter semanal de Andrew Ng. Resume los avances más importantes en IA de forma accesible. **Gratis.**
*   **[Lilian Weng's Blog](https://lilianweng.github.io/posts/):** Análisis técnicos profundos de arquitecturas de IA (LLM Agents, RLHF, prompting). Escrito por VP of Research en OpenAI.
*   **[The Sequence](https://thesequence.substack.com/):** Desglose técnico semanal de papers y herramientas nuevas. Para quienes quieren estar al día con la investigación.
*   **[Anthropic News](https://www.anthropic.com/news):** Blog oficial de Anthropic (Claude). Imprescindible si usás Claude en producción.

## 🎓 Cursos de Alto Nivel
*   **[DeepLearning.AI - AI Agents in LangGraph](https://www.deeplearning.ai/short-courses/ai-agents-in-langgraph/):** Curso corto y técnico sobre agentes modernos.
*   **[AWS Skill Builder - Bedrock Path](https://explore.skillbuilder.aws/):** Formación oficial para partners de Amazon.
*   **[Microsoft Learn - AI Engineer Associate](https://learn.microsoft.com/en-us/credentials/certifications/azure-ai-engineer/):** Certificación oficial de Azure.

## 🔬 Papers Fundamentales
*   **[Attention Is All You Need (2017)](https://arxiv.org/abs/1706.03762):** El inicio de todo.
*   **[Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks (2020)](https://arxiv.org/abs/2005.11401):** El origen del RAG.
*   **[Chain-of-Thought Prompting Elicits Reasoning in Large Language Models (2022)](https://arxiv.org/abs/2201.11903):** Por qué pedirle al modelo que piense funciona.

## 🛠️ Herramientas de Desarrollo con IA

### IDEs y Editores con IA
*   **[Cursor](https://cursor.sh/):** Editor basado en VS Code con agente de IA integrado. Puede leer toda tu codebase y ejecutar cambios multi-archivo. Alternativa: GitHub Copilot en VS Code.
*   **[Windsurf](https://codeium.com/windsurf):** Editor similar a Cursor, pero con enfoque en privacidad y modelos locales.

### LLMs Locales
*   **[Ollama](https://ollama.com/):** Ejecuta modelos como Llama 3, Mistral y otros en tu máquina sin enviar código a la nube. Ideal para empresas con políticas de privacidad estrictas.
*   **[LM Studio](https://lmstudio.ai/):** Interfaz gráfica para ejecutar LLMs localmente con soporte para GPU.

### Testing y Evaluación
*   **[Promptfoo](https://github.com/promptfoo/promptfoo):** Framework para testear y evaluar prompts. Permite comparar outputs de diferentes modelos y versiones.

### Interoperabilidad
*   **[LiteLLM](https://github.com/BerriAI/litellm):** Interfaz unificada para llamar a 100+ LLMs (OpenAI, Anthropic, Azure, local) con el mismo código. Útil para no quedar atado a un proveedor.

---

## 📓 Obsidian como Herramienta de Trabajo con IA

[Obsidian](https://obsidian.md/) no es solo un gestor de notas — es una forma de estructurar conocimiento que se integra naturalmente con IA.

**¿Por qué encaja con vibe coding?**
1. **Relaciones de Primer Clase:** Los `[[links]]` entre notas definen relaciones que una DB vectorial tradicional ignora — base natural para GraphRAG.
2. **Estructura Local:** Tus decisiones de arquitectura, prompts y specs no salen de tu máquina.
3. **Graph View:** Visualizá qué módulos de tu proyecto están huérfanos o demasiado acoplados antes de que el agente te lo diga.

**Tip Pro: Canvas de Arquitectura → Código**
Usá el **Obsidian Canvas** para mapear flujos agénticos visualmente. Luego pasale una captura de pantalla a un modelo multimodal (Claude 3.5 Vision) y pedile:
> *"Basado en este diagrama de arquitectura, generá el código de LangGraph correspondiente."

Es la forma más rápida de pasar de idea a código estructurado.

---

## 📋 Templates & Starter Kits

Plantillas listas para usar en tus proyectos con agentes de IA. Copialas, adaptálas, y mejorá tu flujo de trabajo.

### 1. Agent Configuration Files

#### CLAUDE.md / AGENTS.md — Template Básico

```markdown
# Descripción del Proyecto

## Qué hace este proyecto
[Descripción en 2-3 líneas del propósito del proyecto]

## Stack Tecnológico
- Lenguaje: [ej. TypeScript]
- Framework: [ej. Next.js 14]
- Base de datos: [ej. PostgreSQL + Prisma]
- Testing: [ej. Vitest]

## Lenguaje del Dominio

**Términos que DEBÉS usar:**
- Usuario (NO cliente, account, ni customer)
- Pedido (NO compra, transacción)
- SKU (NO product_id)

**Términos que NO debés usar:**
- Términos del codebase anterior

## Decisiones de Arquitectura

1. **Usamos Prisma** — NO sugerir TypeORM ni otros ORMs
2. **Usamos Zod para validación** — NO sugerir Joi ni Yup
3. **Los tests están en Vitest** — NO usar Jest

## Estilo de Código

- Preferir componentes funcionales sobre clases
- Usar tipos explícitos, evitar `any`
- Máximo 50 líneas por función. Si es más largo, refactorizar.
```

#### CLAUDE.md — Template Avanzado

```markdown
# Contexto del Proyecto

## Misión
[1 línea: el problema que resuelve este proyecto]

## Reglas no negociables

1. **TDD obligatorio**: ROJO → VERDE → REFACTOR. Sin tests no hay código.
2. **Presupuesto de complejidad**: Archivos nuevos > 200 líneas disparan una discusión de refactor.
3. **Lenguaje del dominio**: Ver CONTEXT.md para terminología. Las desviaciones rompen el CI.

## Fases del Workflow

1. `/brainstorm` — Refinamiento socrático antes de cualquier código
2. `/plan` — Dividir el trabajo en tareas de 2-5 minutos
3. `/implement` — Desarrollo con subagentes y revisión en dos etapas
4. `/review` — Code review contra la spec antes de mergear

## Criterios de "Terminado"

- [ ] Todos los tests pasan (incluyendo los nuevos)
- [ ] Sin errores de TypeScript
- [ ] Code review aprobado
- [ ] CONTEXT.md actualizado si cambió la arquitectura
- [ ] ADR creado para cualquier nueva decisión técnica
```

#### CONTEXT.md — Lenguaje del Dominio

```markdown
# Contexto del Dominio

## Lenguaje Ubicuo

### Entidades Principales

**Usuario**
- Definición: Persona con cuenta autenticada en el sistema
- Por qué este término: Alinea con la terminología del proveedor de auth
- NO usar: cliente, customer, account holder

**Pedido**
- Definición: Solicitud de compra enviada por un Usuario
- Ciclo de vida: borrador → confirmado → procesado → entregado
- NO usar: transacción, compra, carrito

**SKU (Stock Keeping Unit)**
- Definición: Identificador único de una variante de producto
- Formato: `{CATEGORIA}-{ID}` (ej. "LAPTOP-001")
- NO usar: product_id, item_code

## Restricciones de Arquitectura

### Base de Datos
- ORM: Prisma (razón: type safety + migraciones. Ver ADR-001)
- Sin queries SQL crudas sin aprobación

### Validación
- Librería: Zod (razón: validación en runtime y compile-time. Ver ADR-002)
- Todos los inputs de la API DEBEN validarse a nivel de controlador

### Testing
- Framework: Vitest (razón: más rápido que Jest. Ver ADR-003)
- Cobertura objetivo: 80% para lógica de negocio core

## Historial de Decisiones

Para preguntas de "por qué", ver `/docs/adr/` (Architecture Decision Records)
```

---

### 2. Workflow Templates

#### TDD Workflow

```markdown
# Checklist de Implementación TDD

## Fase 1: ROJO (Escribir test que falla)

1. Describí el comportamiento que querés:
   "Cuando el usuario envía un email inválido, devolver 400 con mensaje de error"

2. Escribí el test PRIMERO:
```typescript
test('debería rechazar formato de email inválido', () => {
  const result = validateEmail('no-es-un-email');
  expect(result.success).toBe(false);
  expect(result.error).toContain('Formato de email inválido');
});
```

3. Ejecutá el test → Debe FALLAR (porque validateEmail todavía no existe)

## Fase 2: VERDE (Hacerlo pasar)

4. Escribí el código mínimo para que el test pase:
```typescript
function validateEmail(email: string) {
  if (!email.includes('@')) {
    return { success: false, error: 'Formato de email inválido' };
  }
  return { success: true };
}
```

5. Ejecutá el test de nuevo → Debe PASAR

## Fase 3: REFACTOR (Mejorar sin romper)

6. Mejorá la calidad del código:
```typescript
function validateEmail(email: string): ValidationResult {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  
  if (!emailRegex.test(email)) {
    return { success: false, error: 'Formato de email inválido' };
  }
  
  return { success: true };
}
```

7. Ejecutá el test de nuevo → Debe SEGUIR PASANDO

## Commit

8. Commit con mensaje descriptivo:
   `feat: add email validation with regex pattern`
```

#### Workflow Spec-First (6 Pasos)

```markdown
# Workflow de Desarrollo de Features

## Paso 1: Constitución
```bash
/speckit.constitution
```
Definí los principios del proyecto (solo una vez por proyecto)

## Paso 2: Especificar (Qué)
```bash
/speckit.specify
```
- Historia de usuario: "Como [rol], quiero [feature] para [beneficio]"
- Criterios de aceptación (testeables)
- Casos borde a manejar
- Qué está explícitamente FUERA del alcance

## Paso 3: Planificar (Cómo)
```bash
/speckit.plan
```
**Acá sí puede ser técnico:**
- Stack (ej. "Usar Zod para validación")
- Enfoque de arquitectura (ej. "3 capas: controller → service → repository")
- Estructura de archivos
- Dependencias a agregar

## Paso 4: Tareas (Desglose)
```bash
/speckit.tasks
```
Desglosá el plan en tareas de 2-5 minutos. Cada tarea debe:
- Tener el path exacto del archivo
- Ser testeable de forma independiente
- Tener un criterio claro de "terminado"

## Paso 5: Implementar
```bash
/speckit.implement
```
El agente ejecuta las tareas. El humano revisa después de cada batch.

## Paso 6: Analizar
```bash
/speckit.analyze
```
Verificación cruzada entre spec e implementación para detectar desvíos.
```

#### Template de Sesión de Interrogación

```markdown
# Template de Sesión de Interrogación

## Tu solicitud inicial
"Necesito construir [descripción vaga de una feature]"

## Respuesta del Agente (Ejemplo)

**Antes de empezar a codear, necesito entender qué necesitás realmente:**

### Experiencia del Usuario
1. ¿Quién es el usuario final? (rol, nivel técnico)
2. ¿Cuál es su objetivo principal con esta feature?
3. ¿Qué pasa si esta feature no está disponible?

### Funcionalidad
4. ¿Cuál es el happy path? (paso a paso)
5. ¿Cuáles son los 3 escenarios de error más comunes?
6. ¿Esto necesita funcionar offline?

### Restricciones
7. ¿Requisitos de performance? (tiempo de respuesta, throughput)
8. ¿Preocupaciones de seguridad? (auth, sensibilidad de datos)
9. ¿Requisitos de compliance? (GDPR, HIPAA, etc.)

### Integración
10. ¿Con qué sistemas existentes interactúa?
11. ¿Qué formato de datos esperan?
12. ¿Qué pasa si esos sistemas están caídos?

### Métricas de Éxito
13. ¿Cómo vas a saber que esta feature fue exitosa?
14. ¿Qué métricas vas a trackear?

---

**Después de responder estas preguntas, creamos la spec juntos.**
```

---

### 3. Documentation Templates

#### ADR (Architecture Decision Record)

```markdown
# ADR-003: Elegir Vitest en lugar de Jest para Testing

**Estado:** Aceptado  
**Fecha:** 2024-03-15  
**Decisores:** @tu-usuario, @compañero

## Contexto

Necesitamos un framework de testing para nuestra base de código TypeScript. Requisitos clave:
- Ejecución rápida de tests (tenemos 500+ tests)
- Buen soporte para TypeScript
- Compatible con Vite (nuestra herramienta de build)

## Decisión

Vamos a usar **Vitest** como framework principal de testing.

## Justificación

### ¿Por qué Vitest?
1. **Velocidad**: 2-3x más rápido que Jest en nuestros benchmarks (200ms vs 600ms para el suite completo)
2. **ESM nativo**: Sin hacks de configuración
3. **Integración con Vite**: Reutiliza nuestra config de Vite, sin duplicación
4. **Compatibilidad de API**: Reemplazo directo de Jest (costo mínimo de migración)

### ¿Por qué NO Jest?
1. Requiere configuración extra para módulos ESM
2. Ejecución de tests más lenta
3. Config separada de la herramienta de build

### Alternativas consideradas

**Test runner nativo de Node**
- ❌ Demasiado básico, sin snapshot testing
- ❌ Librería de assertions limitada

**uvu**
- ❌ Ecosistema menos maduro
- ❌ Comunidad más pequeña

## Consecuencias

### Positivas
- Pipelines de CI/CD más rápidos
- Mejor experiencia del desarrollador (feedback loop más rápido)
- Una sola config para build + test

### Negativas
- Comunidad más pequeña que Jest (pero en crecimiento)
- Algunos plugins de Jest no son compatibles (mitigado: no usamos plugins poco comunes)

### Neutrales
- Esfuerzo de migración: 2 horas para actualizar la sintaxis en los tests existentes

## Fecha de Revisión

2024-09-15 (6 meses) — Re-evaluar si encontramos limitaciones significativas
```

#### Template de Feature Spec

```markdown
# Feature: Validación de Email en el Registro de Usuarios

## Historia de Usuario

Como **product manager**, quiero **validar direcciones de email durante el registro** para **reducir cuentas falsas y mejorar la entregabilidad**.

## Criterios de Aceptación

### Happy Path
1. ✅ El usuario ingresa un email válido (ej. `test@example.com`)
2. ✅ El sistema valida el formato usando regex
3. ✅ El sistema avanza al siguiente paso del registro

### Escenarios de Error
1. ❌ El usuario ingresa un email sin @ → Mostrar error: "El email debe contener @"
2. ❌ El usuario ingresa un email sin dominio → Mostrar error: "El email debe incluir dominio (ej. @example.com)"
3. ❌ El usuario ingresa un email con espacios → Mostrar error: "El email no puede contener espacios"

## Fuera del Alcance

- ❌ Verificación de email (envío de códigos) — feature separada
- ❌ Chequeo de emails desechables (ej. tempmail.com)
- ❌ Verificación de existencia del email (validación DNS/SMTP)

## Dependencias

- Ninguna (lógica de validación pura)

## Consideraciones de Seguridad

- Sin logging de PII (las direcciones de email son datos sensibles)
- Rate limiting manejado a nivel de API gateway (no en esta feature)

## Métricas

- **Éxito**: Reducción en emails de bienvenida rebotados en un 20%
- **Monitorear**: Tasa de rechazo de validación (baseline: desconocido)
```

#### Template de Plan de Implementación

```markdown
# Plan de Implementación: Validación de Email

## Decisiones de Stack

- **Librería de Validación**: Zod (razón: ya se usa en otros endpoints, ADR-002)
- **Patrón Regex**: Regex estándar para email (no se necesitan TLDs exóticos)
- **Manejo de Errores**: Devolver errores de validación en formato estándar (`{ field, message }`)

## Estructura de Archivos

```
src/
  validators/
    email.validator.ts      # Lógica de validación principal
    email.validator.test.ts # Unit tests
  api/
    auth/
      register.controller.ts # Llama al email validator
```

## Desglose de Tareas

### Tarea 1: Crear Email Validator (5 min)
- **Archivo**: `src/validators/email.validator.ts`
- **Código**: Schema de Zod con validación de email
- **Test**: Escribir test que falla primero (TDD)

### Tarea 2: Escribir Tests (8 min)
- **Archivo**: `src/validators/email.validator.test.ts`
- **Casos**: Happy path + 3 escenarios de error de la spec
- **Cobertura**: 100% de la lógica del validator

### Tarea 3: Integrar con el Endpoint de Registro (5 min)
- **Archivo**: `src/api/auth/register.controller.ts`
- **Cambio**: Agregar validación `.email()` antes de procesar
- **Test**: Test E2E para el flujo de registro

### Tarea 4: Actualizar Mensajes de Error (3 min)
- **Archivo**: `src/api/auth/register.controller.ts`
- **Cambio**: Mapear errores de Zod a mensajes amigables para el usuario
- **Test**: Verificar formato de la respuesta de error

## Pasos de Verificación

- [ ] Todos los unit tests pasan
- [ ] Tests E2E pasan
- [ ] Testing manual en entorno de dev
- [ ] Code review aprobado
- [ ] Spec actualizada si hubo cambios durante la implementación
```

---

### 4. Template de Skill Personalizado

Si querés crear tus propios skills personalizados:

```markdown
# Skill Personalizado: API Contract First

## Propósito

Forzar el diseño API-first: definir la spec OpenAPI antes de escribir cualquier código de endpoint.

## Condiciones de Activación

- El usuario menciona "nuevo endpoint de API"
- El usuario menciona "REST API"
- El path del archivo contiene `/api/`

## Workflow

1. **Pedir el Contrato**: "Antes de codear, definamos la spec OpenAPI para este endpoint."
2. **Generar la Spec**: Crear YAML con:
   - Path + método HTTP
   - Schema del body del request
   - Schemas de respuesta (éxito + errores)
   - Requisitos de autenticación
3. **Obtener Aprobación**: Mostrar la spec al usuario, iterar hasta aprobar
4. **Generar Código**: Usar la spec como fuente de verdad para types + validación
5. **Generar Tests**: Usar los ejemplos de la spec como casos de test

## Criterios de "Terminado"

- [ ] La spec OpenAPI existe antes del código
- [ ] Los types del código coinciden con la spec (sin drift)
- [ ] Los tests cubren todos los códigos de respuesta en la spec

## Anti-Patrones a Evitar

- ❌ Escribir código primero, spec después ("deuda de documentación")
- ❌ Spec y código desincronizados
- ❌ Spec sin ejemplos (no testeable)
```

---

## 🎯 Cómo Usar Estos Templates

1. **Copiá el template** que necesites
2. **Reemplazá los placeholders** con tu información real
3. **Adaptá a tu contexto**: No todos los proyectos necesitan todo
4. **Iterá**: Los templates mejoran con el uso

> **Tip final:** Estos templates NO son documentación muerta. Son **inputs para el agente**. Si el agente los ignora, significa que no son lo suficientemente específicos. Refiná hasta que el agente los respete consistentemente.

---
[Volver al Inicio](../README.md)
