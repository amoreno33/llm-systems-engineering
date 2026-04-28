# ☁️ Cloud AI Architectures: AWS & Microsoft Partners

Como partners de las dos nubes líderes, debemos conocer cómo estas ofrecen IA a nivel empresarial. La elección no suele ser por el modelo (ambas ofrecen acceso a modelos SOTA), sino por la infraestructura, gobernanza y servicios adjuntos.

> **Conexión con vibe coding:** Cuando prototipás con Cursor o Claude Code en tu máquina, usás la API directamente. Cuando ese prototipo pasa a producción en un cliente enterprise, necesitás estas plataformas: gobernanza, SLAs, compliance y facturación centralizada.

---

## 🟠 AWS Bedrock: Serverless Speed

Bedrock es el servicio de IA generativa de AWS que permite acceder a modelos de Anthropic, Meta, Mistral, Stability AI y la propia Amazon (Titan) vía API — sin gestionar infraestructura de servidores.

### Servicios Clave:

| Servicio | Qué hace | Cuándo usarlo |
| :--- | :--- | :--- |
| **Knowledge Bases** | RAG end-to-end sin gestionar vectores | Necesitás RAG rápido sobre documentos S3 |
| **Agents for Bedrock** | Orquestación de agentes con Lambda | Agentes que actúan sobre sistemas AWS |
| **Guardrails** | Filtrado de contenido + detección de PII en infraestructura | Compliance obligatorio en el cliente |
| **Model Evaluation** | Compara modelos con benchmarks automáticos o humanos | Antes de elegir qué modelo desplegar |

**Ideal para:** Clientes que ya viven en AWS y necesitan modelos Anthropic (Claude) con integración nativa con Lambda, S3 e IAM.

> **Tip memorable:** Bedrock es como el "App Store" de modelos de IA dentro de AWS. No gestionás servidores — solo elegís el modelo, configurás el acceso y pagás por token.

---

## 🔵 Azure AI Foundry (ex AI Studio): The Enterprise Powerhouse

Azure ofrece acceso exclusivo a los modelos de OpenAI (GPT-4o, o1) integrados en la seguridad y cumplimiento de la nube de Microsoft.

### Servicios Clave:

| Servicio | Qué hace | Cuándo usarlo |
| :--- | :--- | :--- |
| **Azure OpenAI Service** | Modelos OpenAI en instancia privada con SLA | Cuando el cliente exige datos dentro de su tenant |
| **Prompt Flow** | Orquestación visual + código de flujos de IA | Prototipado rápido → producción sin reescribir |
| **Content Safety** | Detección de jailbreak, inyecciones y contenido ofensivo | Apps públicas o con usuarios no controlados |
| **Azure AI Search** | Búsqueda híbrida (semántica + keyword) enterprise | RAG sobre grandes volúmenes de documentos |

**Ideal para:** Clientes con ecosistema Microsoft (M365, SharePoint, Teams) que necesitan los modelos más avanzados de OpenAI con gobernanza corporativa.

> **Tip memorable:** Si el cliente ya usa Copilot for Microsoft 365, Azure AI Foundry es la extensión natural para construir sus propios agentes sobre los mismos datos y políticas de seguridad que ya tiene.

---

## ⚖️ Comparativa Estratégica: ¿Cómo Elegir?

| Característica | AWS Bedrock | Azure AI Foundry |
| :--- | :--- | :--- |
| **Modelo estrella** | Claude 3.5 Sonnet (Anthropic) | GPT-4o / o1 (OpenAI) |
| **Orquestación** | Agents for Bedrock | Prompt Flow / Semantic Kernel |
| **RAG** | Bedrock Knowledge Bases | Azure AI Search (Hybrid) |
| **Gobernanza** | IAM + Guardrails | Entra ID + Content Safety |
| **Dónde viven los datos** | S3 / DynamoDB | SharePoint / OneDrive / Blob |
| **Mejor argumento de venta** | Ecosistema AWS + modelo Anthropic | Integración M365 + OpenAI exclusivo |

> **Regla de oro para partners:** La decisión técnica la toma el dato, no el modelo. Si los documentos del cliente viven en SharePoint → Azure. Si viven en S3 → Bedrock. Cambiar dónde vive el dato es más caro que cualquier diferencia entre modelos.

---

## 🤖 ¿Y dónde entra el ecosistema Copilot?

Esta es una de las preguntas más frecuentes cuando se mezclan estos temas. Copilot **no compite** con esta arquitectura — ocupa capas distintas:

| Producto Copilot | Para quién es | Qué rol tiene |
| :--- | :--- | :--- |
| **GitHub Copilot** | Vos, el desarrollador | Tu herramienta de vibe coding para construir estas soluciones más rápido |
| **Microsoft 365 Copilot** | Los empleados del cliente | IA integrada en Word, Teams, Outlook — consume la infraestructura Azure del cliente |
| **Copilot Studio** | El cliente sin equipo técnico propio | Plataforma low-code para crear agentes custom sobre el ecosistema M365 |
| **GitHub Copilot Extensions** | Vos o el cliente dev | Permite construir agentes que viven *dentro* de GitHub Copilot usando tu propia lógica |

### ¿Cómo se relacionan con la arquitectura?

```
Capa de usuario (lo que ve el empleado del cliente)
    Microsoft 365 Copilot / Copilot Studio
                    │
                    ▼
Capa de infraestructura (lo que vos construís / configurás)
    Azure AI Foundry ──── Azure OpenAI ──── Azure AI Search
                    │
                    ▼
Capa de datos (donde viven los documentos del cliente)
    SharePoint / OneDrive / Blob Storage
```

> **Tip clave para partners:** Microsoft 365 Copilot ya está desplegado en muchos clientes enterprise. Si el cliente te pregunta "¿podemos hacer que Copilot use nuestros documentos internos?", la respuesta técnica es **Copilot Studio + Azure AI Search + SharePoint**. Vos configurás la infraestructura — ellos usan la misma interfaz de Copilot que ya conocen.

> **GitHub Copilot en tu workflow:** Mientras diseñás todas estas arquitecturas, GitHub Copilot (o Cursor) es la herramienta con la que escribís el código de implementación. Son capas distintas: una es para vos como ingeniero, la otra es lo que entregás al cliente.

---

## 🏗️ Patrón de Arquitectura Recomendado: La Capa de Abstracción de IA

> **¿Esto es para vibe coding o para construir aplicaciones?**
> Esta arquitectura **no es para vibe coding** — es para lo que construís *con* vibe coding. La diferencia:
> - **Vibe coding:** Usás Cursor o Claude Code para escribir rápido el código de tu aplicación.
> - **Esta arquitectura:** Es el diseño de esa aplicación cuando pasa a producción enterprise.
>
> Dicho de otro modo: el diagrama de abajo es lo que tu cliente tiene que desplegar. Vos lo construís más rápido gracias al vibe coding.

Para empresas grandes que usan ambas nubes (o que pueden migrar en el futuro), proponemos una arquitectura con capa de abstracción:

```
                    [Tu app / producto final]
                    (construida con vibe coding)
                            │
                            ▼
          ┌───────────────────────────────┐
          │         AI Gateway            │  ← Kong / AWS API GW / Azure APIM
          │  Rate limiting · Auth · Logs  │    Un solo punto de entrada
          └───────────────┬───────────────┘
                          │
                   ┌──────▼──────┐
                   │ Model Router │  ← simple → barato / complejo → caro
                   └──┬────────┬─┘
                      │        │
                      ▼        ▼
               AWS Bedrock   Azure AI
               (Claude)      (GPT-4o)
                      │        │
                      └────────┘
                           │
          ┌────────────────▼──────────────┐
          │        Observability          │  ← LangSmith / Phoenix / CloudWatch
          │  Trazabilidad · Costos · Audit│
          └───────────────────────────────┘
```

**Los 3 componentes no negociables en producción:**
1. **AI Gateway:** Centraliza autenticación, rate limiting y facturación por proyecto/equipo. Sin esto, cualquier desarrollador puede generar costos descontrolados.
2. **Model Router:** Enruta tareas simples al modelo barato y complejas al modelo caro — sin que la app tenga que saberlo.
3. **Observability unificada:** Auditás cada llamada desde un solo lugar. En enterprise, si no podés demostrar qué le preguntaron al modelo y qué respondió, no podés hacer compliance.

> **Tip de venta:** Este patrón evita el vendor lock-in. El cliente puede cambiar de Claude a GPT-4o mañana sin tocar su aplicación — solo cambia el router. Ese argumento solo cierra conversaciones con CTOs.

---
[Volver al Inicio](../README.md)
