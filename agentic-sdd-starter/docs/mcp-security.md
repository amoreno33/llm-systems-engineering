# MCP Security Guide

MCP permite conectar agentes a herramientas y datos externos. Eso aumenta capacidad y también riesgo.

## Principios

- Least privilege.
- Read-only por defecto.
- Allowlist de herramientas.
- Confirmación humana para acciones destructivas.
- Separar contenido externo de instrucciones confiables.
- Auditar llamadas a herramientas.
- No exponer secretos al contexto del modelo.

## Riesgos comunes

- Prompt injection desde contenido externo.
- Tool injection.
- Exfiltración de datos.
- Acciones destructivas por permisos amplios.
- Supply chain de MCP servers.
- Credenciales estáticas o mal rotadas.

## Reglas para el equipo

- Todo MCP server debe tener owner.
- Todo scope write debe justificarse.
- Toda herramienta destructiva debe requerir confirmación.
- Logs no deben incluir secretos.
- Dependencias MCP deben revisarse como dependencias productivas.

## Checklist antes de habilitar un MCP

- [ ] ¿Qué datos puede leer?
- [ ] ¿Qué acciones puede ejecutar?
- [ ] ¿Tiene permisos write?
- [ ] ¿Puede borrar, publicar, enviar o modificar recursos?
- [ ] ¿Cómo se audita?
- [ ] ¿Cómo se revoca acceso?
- [ ] ¿Qué pasa si el contenido externo intenta instruir al agente?
