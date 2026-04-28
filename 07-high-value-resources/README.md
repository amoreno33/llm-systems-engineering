# 📚 High-Value Resources for AI Engineers

Esta es una lista curada de recursos "top-tier" que todo ingeniero de IA debería tener en sus marcadores. Se actualiza constantemente con lo mejor del ecosistema.

> **¿Por dónde empezar si llegás frío?** Seguí este orden:
> 1. Instalá **Cursor** y hacé tu primer proyecto con vibe coding.
> 2. Suscribite a **The Batch** para el contexto semanal de la industria.
> 3. Hacé el curso corto de **AI Agents in LangGraph** (2-3 horas).
> 4. Agregá **Anthropic Cookbook** y **OpenAI Cookbook** a favoritos — los vas a necesitar cuando construyas algo real.
> 5. Los papers son para después, cuando quieras entender el "por qué" de lo que ya usás.

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
*   **[The Batch (DeepLearning.AI)](https://www.deeplearning.ai/the-batch/):** Resumen semanal de Andrew Ng sobre la industria.
*   **[Lilian Weng's Blog](https://lilianweng.github.io/posts/):** Análisis profundos de arquitecturas (LLM Powered Assistants, RLHF, etc.).
*   **[The Sequence](https://thesequence.substack.com/):** Un desglose técnico de los últimos papers y herramientas.
*   **[Anthropic News](https://www.anthropic.com/news):** Imprescindible para estar al día con Claude y seguridad en IA.

## 🎓 Cursos de Alto Nivel
*   **[DeepLearning.AI - AI Agents in LangGraph](https://www.deeplearning.ai/short-courses/ai-agents-in-langgraph/):** Curso corto y técnico sobre agentes modernos.
*   **[AWS Skill Builder - Bedrock Path](https://explore.skillbuilder.aws/):** Formación oficial para partners de Amazon.
*   **[Microsoft Learn - AI Engineer Associate](https://learn.microsoft.com/en-us/credentials/certifications/azure-ai-engineer/):** Certificación oficial de Azure.

## 🔬 Papers Fundamentales
*   **[Attention Is All You Need (2017)](https://arxiv.org/abs/1706.03762):** El inicio de todo.
*   **[Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks (2020)](https://arxiv.org/abs/2005.11401):** El origen del RAG.
*   **[Chain-of-Thought Prompting Elicits Reasoning in Large Language Models (2022)](https://arxiv.org/abs/2201.11903):** Por qué pedirle al modelo que piense funciona.

## 🛠️ Herramientas "Game Changers"
*   **[Cursor](https://cursor.sh/):** El IDE que está redefiniendo el desarrollo asistido por IA.
*   **[Ollama](https://ollama.com/):** Ejecuta LLMs potentes en tu máquina local con una sola línea de comando.
*   **[LiteLLM](https://github.com/BerriAI/litellm):** Una interfaz unificada para llamar a 100+ LLMs con formato OpenAI.

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
