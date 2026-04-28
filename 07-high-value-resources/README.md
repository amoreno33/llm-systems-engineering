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
[Volver al Inicio](../README.md)
