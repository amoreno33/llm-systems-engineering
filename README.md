# 🧠 LLM Systems Engineering: Production AI Guide

Bienvenido al repositorio central de conocimiento para ingenieros de IA y desarrolladores. Este no es un curso básico de prompting; es un **hub de ingeniería** diseñado para equipos que construyen sistemas de producción escalables, seguros y eficientes.

Como partners de **AWS** y **Microsoft**, nuestra misión es dominar las abstracciones de alto nivel sin perder de vista los fundamentos técnicos y la gobernanza corporativa.

---

## 🗺️ Mapa de Navegación

| Sección | Core Focus | Valor para Ingeniería de IA |
| :--- | :--- | :--- |
| **[01. Foundations](./01-foundations/README.md)** | Modern Core | Optimización de costos (tokens) y control de determinismo. |
| **[02. LLM Engineering](./02-llm-engineering/README.md)** | Intelligence Layer | Mitigación de alucinaciones y dominio de la RAM del agente. |
| **[03. Advanced RAG](./03-advanced-rag/README.md)** | Expert Retrieval | Precisión quirúrgica en datos corporativos vs. "Naive RAG". |
| **[04. Agentic Systems](./04-agentic-systems/README.md)** | Action & Reasoning | Orquestación de flujos de trabajo autónomos verificables. |
| **[05. Cloud](./05-cloud-architectures/README.md)** | AWS & Azure | Escalabilidad, gobernanza y estrategia multi-nube. |
| **[06. Ops & Security](./06-llmops-security/README.md)** | Governance | Seguro contra ciberataques y observabilidad en producción. |

### [07. High-Value Resources](./07-high-value-resources/README.md)
*   Listado curado de papers, repositorios de referencia y herramientas "State of the Art".

---

## 🚀 Filosofía de Trabajo: Vibe Coding & SDD

Este repositorio acompaña la mentalidad de **Specification Driven Development (SDD)**. No pedimos código; damos especificaciones. No usamos IA como un chat, la usamos como un **runtime de ejecución**.

> **Principio Clave:** El prompt deja de ser el producto. El producto es el sistema: contexto, herramientas, reglas y verificación.

Para ver cómo aplicamos esto en el día a día, consulta el [Agentic SDD Starter](./agentic-sdd-starter/README.md).

---

## 🚀 Getting Started

Esta sección está diseñada para ayudar a nuevos usuarios y equipos a integrar este proyecto en sus flujos de trabajo de manera eficiente.

### 1. Requisitos Previos
Antes de comenzar, asegúrate de tener lo siguiente:
- **Entorno de desarrollo**: Node.js (v16 o superior) y Python (v3.9 o superior).
- **Dependencias**: Instala las dependencias necesarias ejecutando `npm install` y configurando el entorno virtual de Python.
- **Acceso a herramientas**: Asegúrate de tener acceso a las herramientas mencionadas en las secciones específicas (por ejemplo, OpenAI API, bases de datos vectoriales).

### 2. Configuración Inicial
1. Clona este repositorio:
   ```bash
   git clone https://github.com/tu-usuario/tu-repositorio.git
   cd tu-repositorio
   ```
2. Configura las variables de entorno necesarias:
   - Copia el archivo `.env.example` y renómbralo a `.env`.
   - Llena las variables requeridas, como claves de API y configuraciones específicas.

3. Ejecuta los scripts de inicialización:
   ```bash
   npm run setup
   ```

### 3. Ejecución de Ejemplos
- **Ejemplo 1**: Integración de un flujo de trabajo básico con prompts optimizados.
  ```bash
  python examples/semantic_cache_example.py
  ```
- **Ejemplo 2**: Uso de especificaciones para agentes autónomos.
  ```bash
  npm run agent-example
  ```

---

## 📝 Model Card

### Descripción General
Este proyecto está diseñado para quienes trabajan con sistemas de IA avanzados. Proporciona herramientas y guías para construir sistemas escalables, seguros y eficientes.

### Características Clave
- **Optimización de costos**: Técnicas para reducir el uso de tokens y mejorar la eficiencia.
- **Seguridad**: Estrategias para proteger sistemas de IA en producción.
- **Adopción empresarial**: Guías prácticas para integrar IA en flujos de trabajo corporativos.

### Limitaciones
- **Dependencia de herramientas externas**: Algunas funcionalidades requieren acceso a APIs de terceros.
- **Curva de aprendizaje**: El contenido está diseñado para usuarios con experiencia técnica avanzada.

### Casos de Uso
1. **Optimización de Prompts**: Mejora de prompts para tareas específicas como generación de texto o clasificación.
2. **RAG Avanzado**: Implementación de técnicas de recuperación de datos para mejorar la precisión en sistemas empresariales.
3. **Agentes Autónomos**: Creación de agentes que pueden razonar, planificar y ejecutar tareas de manera autónoma.

---

## 📂 Ejemplos Prácticos (Copy-Paste Ready)

| Ejemplo | Qué vas a encontrar |
| :--- | :--- |
| **[CLAUDE.md para un proyecto real](./examples/claude-md-real-project.md)** | Un `CLAUDE.md` completo para una API de pagos (Node.js/TypeScript). Copialo y adaptalo. |
| **[Decision Log (workflow.md)](./examples/workflow-md-decision-log.md)** | Cómo se ve un log de decisiones después de 2 semanas de desarrollo. Con antes/después. |
| **[Obsidian como Second Brain](./examples/obsidian-second-brain.md)** | Estructura de vault, notas con links bidireccionales, Graph View y plugins de IA. |
| **[Antes vs Después: Prompts Reales](./examples/antes-despues-prompts.md)** | 5 escenarios reales: el prompt vago vs. el prompt optimizado. La diferencia es brutal. |

---

## 🛠️ Contribución

Este es un repositorio vivo. Esperamos contribuciones que suban el nivel técnico:
1.  Nuevos patrones de RAG probados en producción.
2.  Benchmarks de modelos en tareas específicas de nuestra industria.
3.  Scripts de automatización y hooks de seguridad.

---
*© 2024-2025 AI Engineering Team | Partner de AWS & Microsoft*
