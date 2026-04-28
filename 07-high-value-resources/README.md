# 📚 High-Value Resources for AI Engineers

Esta es una lista curada de recursos para desarrolladores que trabajan con sistemas de IA. Se actualiza constantemente con herramientas, metodologías y referencias fundamentales.

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

> **Por qué importa con agentes:** Un archivo `CONTEXT.md` con el lenguaje del proyecto hace que el agente sea más conciso y genere código con nombres consistentes. Puede reducir uso de tokens en 30-50%.

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
*   **[Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook):** Las mejores prácticas para exprimir al máximo a la familia Claude.
*   **[OpenAI Cookbook](https://github.com/openai/openai-cookbook):** Guías exhaustivas para GPT-4o y o1.
*   **[Microsoft GraphRAG](https://github.com/microsoft/graphrag):** Repositorio oficial para implementar RAG basado en grafos.
*   **[Promptfoo](https://github.com/promptfoo/promptfoo):** Herramienta esencial para testeo y evaluación de prompts.
*   **[Matt Pocock Skills](https://github.com/mattpocock/skills):** 34k+ stars. Skills modulares para ingeniería disciplinada con agentes de IA.

## 🤖 Frameworks y Metodologías para Agentes

*   **[BMAD Method](https://bmad.ai/):** Build, Measure, Adjust, Deploy. Framework completo para desarrollo con agentes en ciclo de vida completo.
*   **[Spec-Kit](https://github.com/spec-kit):** Framework para desarrollo basado en especificaciones verificables y modulares.
*   **[SDD Starter](../agentic-sdd-starter/):** Specification-Driven Development. Incluido en este repo con templates de `CLAUDE.md` y `CONTEXT.md`.

## 📰 Newsletters & Blogs Técnicos

Mantenerse actualizado sin ruido:

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
# Project Overview

## What This Project Does
[Descripción en 2-3 líneas del propósito del proyecto]

## Tech Stack
- Language: [e.g., TypeScript]
- Framework: [e.g., Next.js 14]
- Database: [e.g., PostgreSQL + Prisma]
- Testing: [e.g., Vitest]

## Domain Language

**Terms you MUST use:**
- User (NOT customer, client, or account)
- Order (NOT purchase, transaction)
- SKU (NOT product_id)

**Terms you MUST NOT use:**
- Legacy terms from old codebase

## Architecture Decisions

1. **We use Prisma** — Do NOT suggest TypeORM or other ORMs
2. **We use Zod for validation** — Do NOT suggest Joi or Yup
3. **Tests are written in Vitest** — Do NOT use Jest

## Code Style

- Prefer functional components over class components
- Use explicit types, avoid `any`
- Max function length: 50 lines. If longer, refactor.
```

#### CLAUDE.md — Template Avanzado (con Superpowers workflow)

```markdown
# Project Context

## Mission
[1 línea: el problema que resuelve este proyecto]

## Non-Negotiables (Invariants)

1. **TDD is mandatory**: RED → GREEN → REFACTOR. No code without a failing test first.
2. **Complexity budget**: New files > 200 lines trigger a refactor discussion.
3. **Domain Language**: See CONTEXT.md for terminology. Deviations break CI.

## Workflow Phases

This project uses Superpowers methodology:

1. `/brainstorm` — Socratic refinement before any code
2. `/plan` — Break work into 2-5 minute tasks
3. `/implement` — Subagent-driven development with two-stage review
4. `/review` — Code review against spec before merge

## Success Criteria for "Done"

- [ ] All tests pass (including new tests for new features)
- [ ] No TypeScript errors
- [ ] Code reviewed and approved
- [ ] CONTEXT.md updated if architecture changed
- [ ] ADR created for any new tech decision
```

#### CONTEXT.md — Domain Language Template

```markdown
# Domain Context

## Ubiquitous Language

### Core Entities

**User**
- Definition: A person with an authenticated account in the system
- Why this term: Aligns with auth provider terminology
- Do NOT use: customer, client, account holder

**Order**
- Definition: A purchase request submitted by a User
- Lifecycle: draft → confirmed → fulfilled → delivered
- Do NOT use: transaction, purchase, cart

**SKU (Stock Keeping Unit)**
- Definition: Unique identifier for a product variant
- Format: `{CATEGORY}-{ID}` (e.g., "LAPTOP-001")
- Do NOT use: product_id, item_code

## Architecture Constraints

### Database
- ORM: Prisma (reason: type safety + migrations. See ADR-001)
- No raw SQL queries without approval

### Validation
- Library: Zod (reason: runtime + compile-time validation. See ADR-002)
- All API inputs MUST be validated at controller level

### Testing
- Framework: Vitest (reason: faster than Jest. See ADR-003)
- Coverage target: 80% for core business logic

## Decision History

For "why" questions, see `/docs/adr/` (Architecture Decision Records)
```

---

### 2. Workflow Templates

#### TDD Workflow (Superpowers + Matt Pocock Style)

```markdown
# TDD Implementation Checklist

## Phase 1: RED (Write Failing Test)

1. Describe the behavior you want:
   "When user submits invalid email, return 400 with error message"

2. Write the test FIRST:
```typescript
test('should reject invalid email format', () => {
  const result = validateEmail('not-an-email');
  expect(result.success).toBe(false);
  expect(result.error).toContain('Invalid email format');
});
```

3. Run the test → Should FAIL (because validateEmail doesn't exist yet)

## Phase 2: GREEN (Make It Pass)

4. Write minimal code to make test pass:
```typescript
function validateEmail(email: string) {
  if (!email.includes('@')) {
    return { success: false, error: 'Invalid email format' };
  }
  return { success: true };
}
```

5. Run test again → Should PASS

## Phase 3: REFACTOR (Improve Without Breaking)

6. Improve the code quality:
```typescript
function validateEmail(email: string): ValidationResult {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  
  if (!emailRegex.test(email)) {
    return { success: false, error: 'Invalid email format' };
  }
  
  return { success: true };
}
```

7. Run test again → Should STILL PASS

## Commit

8. Commit with descriptive message:
   `feat: add email validation with regex pattern`
```

#### Spec-First Workflow (Spec-Kit 6-Step)

```markdown
# Feature Development Workflow

## Step 1: Constitution
```bash
/speckit.constitution
```
Define project principles (only once per project)

## Step 2: Specify (What)
```bash
/speckit.specify
```
**What to include:**
- User story: "As a [role], I want [feature] so that [benefit]"
- Acceptance criteria (testable)
- Edge cases to handle
- What's explicitly OUT of scope

**Do NOT include:**
- Tech stack choices
- Implementation details
- File names or folder structure

## Step 3: Plan (How)
```bash
/speckit.plan
```
**Now you can be technical:**
- Tech stack (e.g., "Use Zod for validation")
- Architecture approach (e.g., "3-layer: controller → service → repository")
- File structure
- Dependencies to add

## Step 4: Tasks (Breakdown)
```bash
/speckit.tasks
```
Break plan into 2-5 minute tasks. Each task should:
- Have exact file path
- Be independently testable
- Have clear "done" criteria

## Step 5: Implement
```bash
/speckit.implement
```
Agent executes tasks. Human reviews after each batch.

## Step 6: Analyze
```bash
/speckit.analyze
```
Cross-check spec vs. implementation for drift.
```

#### Grilling Session Template (Matt Pocock Style)

```markdown
# Grilling Session Template

## Your Initial Request
"I need to build [vague feature description]"

## Agent's Response (Example)

**Before we start coding, let me understand what you really need:**

### User Experience
1. Who is the end user? (role, technical level)
2. What's their primary goal with this feature?
3. What happens if this feature is unavailable?

### Functionality
4. What's the happy path? (step by step)
5. What are the 3 most common error scenarios?
6. Does this need to work offline?

### Constraints
7. Performance requirements? (response time, throughput)
8. Security concerns? (auth, data sensitivity)
9. Compliance requirements? (GDPR, HIPAA, etc.)

### Integration
10. What existing systems does this interact with?
11. What data format do they expect?
12. What happens if those systems are down?

### Success Metrics
13. How will you know this feature is successful?
14. What metrics will you track?

---

**After answering these, we'll create a spec together.**
```

---

### 3. Documentation Templates

#### ADR (Architecture Decision Record)

```markdown
# ADR-003: Choose Vitest over Jest for Testing

**Status:** Accepted  
**Date:** 2024-03-15  
**Decision Makers:** @yourname, @teammate

## Context

We need a testing framework for our TypeScript codebase. Key requirements:
- Fast test execution (we have 500+ tests)
- Good TypeScript support
- Compatible with Vite (our build tool)

## Decision

We will use **Vitest** as our primary testing framework.

## Rationale

### Why Vitest?
1. **Speed**: 2-3x faster than Jest in our benchmarks (200ms vs 600ms for full suite)
2. **Native ESM**: No configuration hacks needed
3. **Vite Integration**: Reuses our Vite config, no duplication
4. **API Compatibility**: Drop-in replacement for Jest (minimal migration cost)

### Why NOT Jest?
1. Requires extra config for ESM modules
2. Slower test execution
3. Separate config from build tool

### Alternatives Considered

**Node's built-in test runner**
- ❌ Too basic, no snapshot testing
- ❌ Limited assertion library

**uvu**
- ❌ Less mature ecosystem
- ❌ Smaller community

## Consequences

### Positive
- Faster CI/CD pipelines
- Better developer experience (faster feedback loop)
- Single config for build + test

### Negative
- Smaller community than Jest (but growing)
- Some Jest plugins not compatible (mitigated: we don't use obscure plugins)

### Neutral
- Migration effort: 2 hours to update syntax in existing tests

## Review Date

2024-09-15 (6 months) — Re-evaluate if we hit any significant limitations
```

#### Feature Spec Template (Spec-Kit Format)

```markdown
# Feature: Email Validation on User Registration

## User Story

As a **product manager**, I want **to validate email addresses during registration** so that **we reduce fake accounts and improve deliverability**.

## Acceptance Criteria

### Happy Path
1. ✅ User enters valid email (e.g., `test@example.com`)
2. ✅ System validates format using regex
3. ✅ System proceeds to next registration step

### Error Scenarios
1. ❌ User enters email without @ symbol → Show error: "Email must contain @"
2. ❌ User enters email without domain → Show error: "Email must include domain (e.g., @example.com)"
3. ❌ User enters email with spaces → Show error: "Email cannot contain spaces"

## Out of Scope

- ❌ Email verification (sending codes) — separate feature
- ❌ Checking if email is disposable (e.g., tempmail.com)
- ❌ Checking if email exists (DNS/SMTP validation)

## Dependencies

- None (pure validation logic)

## Security Considerations

- No PII logging (email addresses are sensitive)
- Rate limiting handled at API gateway level (not in this feature)

## Metrics

- **Success**: Reduction in bounced welcome emails by 20%
- **Monitor**: Validation rejection rate (baseline: unknown)
```

#### Implementation Plan Template

```markdown
# Implementation Plan: Email Validation

## Tech Stack Decisions

- **Validation Library**: Zod (reason: already used in other endpoints, ADR-002)
- **Regex Pattern**: Standard email regex (no exotic TLDs needed)
- **Error Handling**: Return validation errors in standard format (`{ field, message }`)

## File Structure

```
src/
  validators/
    email.validator.ts      # Core validation logic
    email.validator.test.ts # Unit tests
  api/
    auth/
      register.controller.ts # Calls email validator
```

## Task Breakdown

### Task 1: Create Email Validator (5 min)
- **File**: `src/validators/email.validator.ts`
- **Code**: Zod schema with email validation
- **Test**: Write failing test first (TDD)

### Task 2: Write Tests (8 min)
- **File**: `src/validators/email.validator.test.ts`
- **Cases**: Happy path + 3 error scenarios from spec
- **Coverage**: 100% of validator logic

### Task 3: Integrate with Registration Endpoint (5 min)
- **File**: `src/api/auth/register.controller.ts`
- **Change**: Add `.email()` validation before processing
- **Test**: E2E test for registration flow

### Task 4: Update Error Messages (3 min)
- **File**: `src/api/auth/register.controller.ts`
- **Change**: Map Zod errors to user-friendly messages
- **Test**: Verify error response format

## Verification Steps

- [ ] All unit tests pass
- [ ] E2E tests pass
- [ ] Manual testing in dev environment
- [ ] Code review approved
- [ ] Spec updated if any changes during implementation
```

---

### 4. Skills Template (Superpowers Style)

Si querés crear tus propios skills personalizados:

```markdown
# Custom Skill: API Contract First

## Purpose

Enforce API-first design: define OpenAPI spec before writing any endpoint code.

## Trigger Conditions

- User mentions "new API endpoint"
- User mentions "REST API"
- File path contains `/api/`

## Workflow

1. **Ask for Contract**: "Before we code, let's define the OpenAPI spec for this endpoint."
2. **Generate Spec**: Create YAML with:
   - Path + HTTP method
   - Request body schema
   - Response schemas (success + errors)
   - Authentication requirements
3. **Get Approval**: Show spec to user, iterate until approved
4. **Generate Code**: Use spec as source of truth for types + validation
5. **Generate Tests**: Use spec examples as test cases

## Success Criteria

- [ ] OpenAPI spec exists before code
- [ ] Code types match spec (no drift)
- [ ] Tests cover all response codes in spec

## Anti-Patterns to Avoid

- ❌ Writing code first, spec later ("documentation debt")
- ❌ Spec and code out of sync
- ❌ Spec with no examples (not testable)
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
