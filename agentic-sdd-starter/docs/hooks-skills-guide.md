# 🪝 Hooks & Skills: Dónde Vive Cada Concepto

## La confusión más común

Una cosa es **declarar el hook**. Otra muy distinta es **escribir el script que el hook ejecuta**.

Este documento aclara exactamente dónde se aplica cada concepto según la capa en la que estés trabajando: editor (Claude Code), framework propio en Python, o metodología (BMAD / Spec Kit).

---

## 1. La Regla Central

> **Un LLM puro no tiene hooks ni skills. El modelo recibe texto y devuelve texto o tool calls.**

Los hooks y las skills existen en el **runtime que rodea al modelo**: Claude Code, Cursor, un framework propio en Python, Spec Kit, BMAD, LangGraph, AutoGen, etc.

Dicho de otro modo:

```
❌ Incorrecto: "El agente tiene un hook que bloquea comandos peligrosos"
✅ Correcto:   "Claude Code ejecuta un hook que bloquea comandos peligrosos
               antes de que el agente pueda usar la tool Bash"
```

---

## 2. Las Tres Capas

| Capa | Quién define los hooks | Dónde vive la lógica | Ejemplo |
| :--- | :--- | :--- | :--- |
| **Claude Code / Editor** | `settings.json` | Scripts Python/Shell en `.claude/hooks/` | Bloquear `rm -rf` antes de ejecutar |
| **Framework Python propio** | Código de la clase `AgentRuntime` | Funciones Python registradas en el runtime | Validar spec antes de implementar |
| **BMAD / Spec Kit** | Metodología + workflows | El editor/runtime subyacente ejecuta los hooks | BMAD define el rol; Claude Code ejecuta el control |

---

## 3. Capa 1: Claude Code (Editor)

### Dónde se declara el hook

```
repo/
├── .claude/
│   ├── settings.json          ← acá DECLARÁS cuándo corre el hook
│   └── hooks/
│       ├── block_dangerous.py ← acá ESCRIBÍS la lógica del hook
│       ├── check_scope.py
│       └── run_tests.py
```

`settings.json` dice: "cuando pase X evento, ejecutá Y script".  
El script Python dice: "qué hago con ese evento".

### Eventos disponibles en Claude Code

| Evento | Cuándo corre |
| :--- | :--- |
| `PreToolUse` | Antes de usar una tool. Puede bloquear la acción. |
| `PostToolUse` | Después de usar una tool. Puede agregar contexto. |
| `UserPromptSubmit` | Cuando el usuario envía un prompt. |
| `Stop` | Cuando el agente termina su turno. |

Los **matchers** filtran por tool: `Bash`, `Edit`, `Write`, tools MCP, etc.

### Ejemplo real: bloquear comandos peligrosos

**.claude/settings.json**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "python .claude/hooks/block_dangerous_commands.py"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "python .claude/hooks/check_scope.py"
          }
        ]
      }
    ]
  }
}
```

**.claude/hooks/block_dangerous_commands.py**
```python
#!/usr/bin/env python3

import json
import re
import sys


def deny(reason: str) -> None:
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "deny",
            "permissionDecisionReason": reason,
        }
    }))
    sys.exit(0)


def main() -> None:
    payload = json.load(sys.stdin)

    tool_name = payload.get("tool_name")
    tool_input = payload.get("tool_input", {})
    command = tool_input.get("command", "")

    if tool_name != "Bash":
        return

    dangerous_patterns = [
        r"\brm\s+-rf\b",
        r"\bsudo\b",
        r"\bchmod\s+-R\s+777\b",
        r"\bgit\s+push\s+--force\b",
        r"\bdrop\s+database\b",
    ]

    for pattern in dangerous_patterns:
        if re.search(pattern, command, re.IGNORECASE):
            deny(f"Comando bloqueado por política del proyecto: {command}")

    sys.exit(0)


if __name__ == "__main__":
    main()
```

Ese hook no vive "en el modelo". Vive en el repo. Claude Code lo ejecuta cuando el agente intenta usar Bash.

---

### Ejemplo: evitar que el agente toque demasiados archivos

**.claude/settings.json**
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python .claude/hooks/check_diff_size.py"
          }
        ]
      }
    ]
  }
}
```

**.claude/hooks/check_diff_size.py**
```python
#!/usr/bin/env python3

import subprocess
import sys


MAX_CHANGED_FILES = 6


def changed_files() -> list[str]:
    result = subprocess.run(
        ["git", "diff", "--name-only"],
        capture_output=True,
        text=True,
        check=False,
    )
    return [line.strip() for line in result.stdout.splitlines() if line.strip()]


def main() -> None:
    files = changed_files()

    if len(files) > MAX_CHANGED_FILES:
        message = (
            f"El agente modificó {len(files)} archivos. "
            f"Máximo permitido: {MAX_CHANGED_FILES}. "
            "Revisar si el cambio sigue siendo quirúrgico."
        )
        print(message, file=sys.stderr)
        sys.exit(2)

    sys.exit(0)


if __name__ == "__main__":
    main()
```

### Hooks para SDD: convertir disciplina cultural en regla técnica

El hook más útil para SDD no genera specs. Las **enforza**.

**.claude/hooks/require_spec_for_implementation.py**
```python
#!/usr/bin/env python3

import json
import sys
from pathlib import Path


IMPLEMENTATION_WORDS = [
    "implementa", "implement", "codea",
    "crea el endpoint", "fix", "arregla", "modifica",
]


def is_implementation_request(prompt: str) -> bool:
    prompt = prompt.lower()
    return any(word in prompt for word in IMPLEMENTATION_WORDS)


def has_active_spec() -> bool:
    specs_dir = Path("specs")
    if not specs_dir.exists():
        return False
    return any(specs_dir.glob("*/spec.md")) or any(specs_dir.glob("*.md"))


def main() -> None:
    payload = json.load(sys.stdin)
    prompt = payload.get("prompt", "")

    if is_implementation_request(prompt) and not has_active_spec():
        print(
            "Antes de implementar, crear una spec en /specs. "
            "Formato mínimo: contexto, objetivo, criterios de aceptación, edge cases y tests.",
            file=sys.stderr,
        )
        sys.exit(2)

    sys.exit(0)


if __name__ == "__main__":
    main()
```

> **Punto clave:** Este hook convierte una práctica cultural en una regla técnica. El repo no puede avanzar si no hay spec.

### ¿Los hooks se crean cuando se define la spec?

No. **Los hooks son infraestructura del repo. Las specs son artefactos por feature.**

```
Hooks = se definen una vez, viven siempre en el repo
Specs = se crean por feature, describen el trabajo a hacer
```

Estructura esperada:

```
.claude/
├── settings.json
└── hooks/
    ├── require_spec_for_implementation.py  ← infraestructura
    ├── block_dangerous_commands.py         ← infraestructura
    ├── check_scope.py                      ← infraestructura
    └── run_quality_checks.py               ← infraestructura

specs/
└── email-validation/
    ├── spec.md    ← artefacto de la feature
    ├── plan.md
    └── tasks.md
```

Después, cada nueva spec pasa por ese sistema de hooks.

---

## 4. Capa 2: Framework Python propio

Si construís tu propio agente, el hook system lo programás vos. El flujo es:

```
user prompt
     ↓
before_prompt_hooks()
     ↓
LLM call
     ↓
tool call proposed
     ↓
pre_tool_hooks()
     ↓
execute tool
     ↓
post_tool_hooks()
     ↓
final response
     ↓
stop_hooks()
```

### Runtime mínimo

```python
from dataclasses import dataclass
from typing import Callable, Any


@dataclass
class HookContext:
    event: str
    payload: dict[str, Any]


Hook = Callable[[HookContext], None]


class AgentRuntime:
    def __init__(self) -> None:
        self.hooks: dict[str, list[Hook]] = {
            "before_prompt": [],
            "pre_tool": [],
            "post_tool": [],
            "stop": [],
        }

    def register_hook(self, event: str, hook: Hook) -> None:
        self.hooks.setdefault(event, []).append(hook)

    def run_hooks(self, event: str, payload: dict[str, Any]) -> None:
        context = HookContext(event=event, payload=payload)
        for hook in self.hooks.get(event, []):
            hook(context)

    def run(self, prompt: str) -> str:
        self.run_hooks("before_prompt", {"prompt": prompt})

        # llamada al LLM
        llm_response = "tool_call: edit_file"

        self.run_hooks("pre_tool", {"tool": "edit_file", "args": {"path": "src/app.py"}})

        # ejecución de la tool real
        result = "file edited"

        self.run_hooks("post_tool", {"tool": "edit_file", "result": result})
        self.run_hooks("stop", {"response": llm_response})

        return llm_response
```

### Hooks Python de ejemplo

```python
def require_spec(context: HookContext) -> None:
    prompt = context.payload["prompt"].lower()
    implementation_terms = ["implement", "fix", "modifica", "crea", "codea"]

    if any(term in prompt for term in implementation_terms):
        if "spec:" not in prompt:
            raise RuntimeError(
                "Solicitud de implementación sin spec. "
                "Crear spec antes de pedir código."
            )


def block_large_scope(context: HookContext) -> None:
    args = context.payload.get("args", {})
    path = args.get("path", "")

    if path.startswith("legacy/"):
        raise RuntimeError(f"No se permite modificar legacy sin aprobación: {path}")
```

### Registro

```python
runtime = AgentRuntime()

runtime.register_hook("before_prompt", require_spec)
runtime.register_hook("pre_tool", block_large_scope)

runtime.run("implementa validación de email")
```

Esto es exactamente lo que hacen los entornos agénticos (LangGraph, AutoGen, etc.), pero con más eventos, permisos, tools y estado.

### Skills en un framework Python propio

Una skill es **contexto seleccionable**. No lógica de ejecución.

```
.skills/
├── api_validation.md
├── code_review.md
└── sdd_spec.md
```

**.skills/api_validation.md**
```markdown
---
name: api-validation
description: Use when implementing or modifying API endpoints that require input validation,
             schema checks, error responses, or edge-case handling.
---

# Rules

- Validate inputs explicitly.
- Return consistent error shapes.
- Add tests for invalid inputs.
- Do not refactor unrelated handlers.
```

**Loader simple: todas las skills**

```python
from pathlib import Path


def load_skills() -> str:
    chunks = []
    for path in Path(".skills").glob("*.md"):
        chunks.append(f"\n\n--- Skill: {path.name} ---\n{path.read_text()}")
    return "\n".join(chunks)


system_prompt = f"""
You are a coding agent.

Use the following skills when relevant:

{load_skills()}
"""
```

**Router por keyword (más preciso)**

```python
def select_skills(prompt: str) -> list[str]:
    prompt = prompt.lower()
    selected = []

    if "api" in prompt or "endpoint" in prompt or "validación" in prompt:
        selected.append(Path(".skills/api_validation.md").read_text())

    if "spec" in prompt or "criterios de aceptación" in prompt:
        selected.append(Path(".skills/sdd_spec.md").read_text())

    return selected
```

Más avanzado: seleccionar skills por embedding semántico o LLM router.

---

## 5. Capa 3: BMAD y Spec Kit

### Spec Kit

Spec Kit no es un hook system en sí. Es un **workflow SDD** que organiza el proceso con comandos:

```
/specify → genera spec
/plan    → genera plan técnico
/tasks   → genera tareas accionables
           agente ejecuta tareas
```

El flujo estándar:

```
constitution → specify → plan → tasks → implement → analyze
```

Los hooks en Spec Kit aparecen como guardrails **alrededor** del workflow, no como el mecanismo principal:

```yaml
pre-commit:
  - validar que exista spec.md
  - validar que exista plan.md
  - validar que tasks.md tenga trazabilidad
  - bloquear cambios de código sin spec asociada
```

> La instalación oficial empieza con `specify init`. Los comandos principales son `/specify`, `/plan` y `/tasks`.

### BMAD

BMAD es una metodología y sistema de agentes que puede correr sobre Claude Code, Cursor o Codex CLI. La documentación indica explícitamente que funciona con cualquier AI coding assistant que soporte custom system prompts o project context.

```
BMAD define:                  El editor/runtime define:
├─ roles de agentes           ├─ hooks reales
├─ workflows                  ├─ permisos
├─ tareas                     ├─ comandos
├─ prompts                    └─ integración con tools
└─ artefactos
```

Dicho simple: **BMAD te dice cómo organizar el trabajo. Claude Code / Cursor / tu runtime decide cómo ejecutar los hooks.**

Si usás BMAD sobre Claude Code, los hooks prácticos siguen viviendo en:

```
.claude/settings.json
.claude/hooks/*.py
```

BMAD puede traer skills, agentes o workflows, pero el "hook que bloquea `rm -rf`" lo ejecuta el runtime, no BMAD.

---

## 6. Estructura recomendada del repo

Aplicando las tres capas juntas el repo debería verse así:

```
agentic-sdd-starter/
├── CLAUDE.md
├── .claude/
│   ├── settings.json                          ← declara los hooks
│   ├── hooks/
│   │   ├── block_dangerous_commands.py        ← infraestructura permanente
│   │   ├── require_spec_for_implementation.py ← infraestructura permanente
│   │   ├── check_scope.py                     ← infraestructura permanente
│   │   ├── run_quality_checks.py              ← infraestructura permanente
│   │   └── validate_spec_traceability.py      ← infraestructura permanente
│   └── rules/
│       ├── sdd.md
│       ├── security.md
│       ├── api-design.md
│       └── testing.md
├── .skills/
│   ├── sdd-spec-writing.md                    ← contexto seleccionable
│   ├── api-validation.md
│   ├── code-review.md
│   └── secure-mcp-usage.md
├── specs/
│   └── _template/
│       ├── spec.md                            ← artefacto por feature
│       ├── plan.md
│       └── tasks.md
└── scripts/
    ├── new_spec.py
    └── verify.py
```

---

## 7. Resumen: dónde aplica cada concepto

| Concepto | Dónde se declara | Dónde vive la lógica | Quién lo ejecuta |
| :--- | :--- | :--- | :--- |
| **Hook PreToolUse** | `settings.json` | `.claude/hooks/*.py` | Claude Code |
| **Hook PostToolUse** | `settings.json` | `.claude/hooks/*.py` | Claude Code |
| **Hook UserPromptSubmit** | `settings.json` | `.claude/hooks/*.py` | Claude Code |
| **Hook Stop** | `settings.json` | `.claude/hooks/*.py` | Claude Code |
| **Hook en Python propio** | `runtime.register_hook()` | Función Python | Tu `AgentRuntime` |
| **Skill (Claude Code)** | `.claude/rules/*.md` o CLAUDE.md | Archivo Markdown | El modelo lo lee como contexto |
| **Skill (Python propio)** | `.skills/*.md` | Archivo Markdown | Tu loader inyecta en el system prompt |
| **Spec** | `/specs/feature/spec.md` | Markdown por feature | El agente la ejecuta como contrato |
| **Workflow BMAD** | Archivos BMAD | Agentes y prompts de BMAD | Claude Code / Cursor / tu runtime |
| **Workflow Spec Kit** | `/specify`, `/plan`, `/tasks` | Artefactos por feature | Claude Code con commands |

---

## 8. Mensaje clave

```
Los hooks no nacen de la spec.
Los hooks son infraestructura del repo.
La spec es el input de cada feature.
El agente ejecuta dentro de ese marco.
```

Los hooks se definen **antes** de crear la primera spec. Las specs se crean **por feature**. Cada spec pasa por el sistema de hooks que ya existe.
