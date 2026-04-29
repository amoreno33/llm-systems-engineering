# 🔍 Advanced RAG: Beyond the Basics

El RAG (Retrieval-Augmented Generation) es el patrón más común para conectar LLMs con datos privados o actualizados. Sin embargo, el "Naive RAG" (vector search directo) suele dar resultados imprecisos porque pierde contexto en el proceso de chunking.

> **Conexión con vibe coding:** Cuando usás Cursor o Copilot con tu codebase, ya están aplicando RAG internamente: indexan tus archivos, buscan los fragmentos más relevantes y solo los pasan al modelo. Si el agente "no entiende" tu proyecto, no es un problema del modelo — es un problema de RAG.

---

## 🏗️ Evolución de la Arquitectura RAG

| Nivel | Flujo | Problema típico |
| :--- | :--- | :--- |
| **Naive RAG** | PDF → Chunk → Vector DB → Search → Prompt | Chunks sin contexto, resultados irrelevantes |
| **Advanced RAG** | + Query Transform + Reranking + Parent Docs | Mayor precisión, menos alucinaciones |
| **GraphRAG** | + Knowledge Graph + Multihop Reasoning | Razonamiento complejo entre conceptos conectados |

### 1. Naive RAG
- **Flujo:** PDF -> Chunking -> Vector DB -> Search -> Prompt.
- **Problema:** Los chunks suelen ser demasiado pequeños (pierden contexto) o demasiado grandes (ruido).

> **Tip memorable:** El Naive RAG es como buscar en Google solo con una palabra. Advanced RAG es como buscar con una frase completa + filtros + revisar los resultados antes de leerlos.

### 2. Advanced RAG Techniques
*   **Query Transformation:**
    *   **HyDE (Hypothetical Document Embeddings):** El modelo genera una respuesta hipotética a la pregunta y usa *esa respuesta* para buscar en la base de datos — en vez de buscar con la pregunta original. Funciona porque las respuestas y los documentos comparten vocabulario, las preguntas no siempre.
    *   **Multi-Query:** Genera 3-5 variaciones de la misma pregunta en paralelo y combina los resultados. Captura documentos que una sola formulación habría perdido.

*   **Hierarchical Retrieval (Parent-Document Retrieval):**
    *   Indexa chunks pequeños (para mayor precisión de búsqueda), pero cuando los encuentra, devuelve al modelo el chunk "padre" más grande. Así el modelo tiene contexto suficiente para responder bien.

*   **Reranking:**
    *   El vector search devuelve los "más parecidos", no los "más relevantes". Un Cross-Encoder (como `BGE-Reranker`) hace una segunda pasada y reordena por relevancia real. Es el equivalente a tener un experto que revisa los resultados de búsqueda antes de presentarlos.

### 3. Hybrid Search
La búsqueda semántica (vectores) es mala con acrónimos, IDs de productos o términos muy específicos.
- **Dense Search (Vectors):** Captura el significado semántico ("cómo se llama eso que...").
- **Sparse Search (BM25/Keyword):** Captura coincidencia exacta ("SKU-4521", "error 403").
- **RRF (Reciprocal Rank Fusion):** El algoritmo estándar para combinar ambos rankings en uno solo.

> **Tip memorable:** Si tu RAG falla con nombres de productos, códigos de error o siglas internas, necesitás Hybrid Search. La búsqueda vectorial sola es ciega ante la exactitud.

---

## 🔑 ¿Cuándo usar RAG vs. Fine-tuning vs. Contexto Largo?

Esta es la pregunta que más surge en proyectos reales:

| Situación | Solución recomendada | Por qué |
| :--- | :--- | :--- |
| Conocimiento externo que cambia frecuentemente | **RAG** | Actualizar embeddings es mucho más barato que re-entrenar |
| Datos privados que no pueden salir al cloud | **RAG local** (Ollama + ChromaDB) | Control total sobre los datos |
| Adaptar el estilo o tono del modelo | **Fine-tuning** | RAG no cambia cómo escribe el modelo |
| Documentos de hasta ~500 páginas | **Contexto largo** (Gemini 1.5 Pro) | Más simple, sin pipeline de chunks |
| Razonamiento complejo entre muchos documentos | **GraphRAG** | Los chunks inconexos no capturan relaciones |

> **Tip para vibe coding:** Si tu agente en Cursor "se olvida" de cómo está estructurado tu proyecto después de pocas sesiones, la solución es un `CLAUDE.md` bien escrito (RAG manual) o un MCP server que indexe tu repo.

---

## 📐 Tip: Tamaño óptimo de chunks

El tamaño de chunk es una de las decisiones más impactantes y menos documentadas:

- **Chunks muy pequeños (<200 tokens):** Alta precisión de búsqueda, pero el modelo recibe fragmentos sin contexto suficiente.
- **Chunks muy grandes (>1000 tokens):** El modelo tiene contexto pero la búsqueda se vuelve imprecisa (mucho ruido).
- **Sweet spot de referencia: 300-500 tokens con 10-15% de overlap** entre chunks consecutivos para no perder continuidad.

```
Documento largo
│
├── Chunk 1 (tokens 1-400)
├── Chunk 2 (tokens 360-760)  ← overlap del 10%
├── Chunk 3 (tokens 720-1120) ← overlap del 10%
└── ...
```

---

## 🕸️ GraphRAG (The Microsoft Approach)

En lugar de trozos inconexos de texto, GraphRAG extrae entidades y relaciones para construir un **Grafo de Conocimiento**. Esto permite razonamiento que el RAG tradicional no puede hacer.

**Caso de uso real:** Base de conocimiento jurídica de una empresa.
- Con RAG normal: busca "contratos de confidencialidad" → encuentra chunks sueltos.
- Con GraphRAG: entiende que *Cliente A → firmó → Contrato NDA-2023 → cubre → Proyecto B → involucra → Proveedor C*. Puede responder "¿qué contratos de confidencialidad cubren al Proveedor C?" saltando entre nodos.

**Ideal para:**
- Documentación legal o de compliance interconectada.
- Bases de conocimiento corporativo con muchas entidades relacionadas.
- Análisis de código donde las dependencias entre módulos importan.

> **Herramienta:** [Microsoft GraphRAG](https://github.com/microsoft/graphrag) es open-source y production-ready.

---

## 📊 Evaluación: ¿Cómo sabemos que funciona?

No se puede mejorar lo que no se mide. La mayoría de los equipos descubren que su RAG "funciona más o menos" pero nunca lo miden formalmente — hasta que llega un cliente con un caso que falla.

El framework **RAGAS** evalúa tres dimensiones:

| Métrica | Pregunta que responde | Cómo detectar el problema |
| :--- | :--- | :--- |
| **Faithfulness** | ¿La respuesta se deriva realmente de los documentos? | Si el modelo inventa datos que no están en los chunks |
| **Answer Relevance** | ¿Responde a lo que el usuario preguntó? | Si la respuesta es correcta pero no útil para la pregunta |
| **Context Precision** | ¿Los documentos recuperados eran los correctos? | Si los chunks devueltos no tienen relación con la respuesta |

> **Tip de producción:** Arma un "golden dataset" de 20-30 pares pregunta/respuesta correcta antes de lanzar. Usalo como benchmark cada vez que cambies el pipeline de RAG. Sin esto, no sabés si mejoró o empeoró.

---

## ☁️ RAG en AWS y Azure

### 🟠 AWS Bedrock Knowledge Bases
Solución completamente gestionada: sube tus documentos (S3), configura el chunking y los embeddings, y Bedrock orquesta todo el pipeline de RAG sin gestionar infraestructura.
- Soporta **Hybrid Search** nativo desde 2024.
- Integración directa con modelos Claude (Anthropic) vía API.
- **Ideal para:** Equipos que ya viven en AWS y quieren tiempo-a-producción rápido.

### 🔵 Azure AI Search
El servicio más maduro del mercado para búsqueda híbrida empresarial.
- Líder en **Hybrid Search** (Dense + Sparse + Semantic Reranking en una sola llamada).
- Integración nativa con Azure OpenAI Service y Prompt Flow.
- **Ideal para:** Clientes con grandes volúmenes de documentos que ya usan el ecosistema Microsoft.

> **Tip para partners:** En proyectos de clientes enterprise, la elección entre Bedrock y Azure AI Search rara vez es técnica — depende de dónde ya está el dato. Si los documentos viven en SharePoint → Azure AI Search. Si viven en S3 → Bedrock Knowledge Bases.

---
[Volver al Inicio](../README.md)
