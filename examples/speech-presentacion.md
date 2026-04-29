# 🎤 Guion de Presentación — LLM Systems Engineering
### Charla técnica interna · 60 minutos

> **Cómo leer este guion:**
> - `💬` = lo que decís en voz alta
> - `[acción]` = qué hacés en pantalla o cómo te movés
> - `(pausa)` = silencio intencional, dejá que la idea aterrice
> - El texto en *cursiva* son comentarios tuyos fuera del repo — contexto, anécdota, opinión personal

---

## APERTURA — sin slides, de frente (3 min)

💬 *"Antes de empezar, una pregunta directa: ¿alguien acá en el último mes escribió código que después no entendió — ni él mismo, ni el resto del equipo?"*

`(pausa, esperá que alguien asienta o ría)`

💬 *"Bien. Y ahora la pregunta incómoda: ¿cuánto de ese código lo generó un agente de IA?"*

`(pausa)`

💬 *"En los últimos dos años trabajé bastante con estas herramientas — Cursor, Claude Code, Copilot — y llegué a una conclusión que al principio me costó aceptar: el problema no es que los agentes sean malos. El problema es que son muy buenos haciendo exactamente lo que les pedimos. Y nosotros generalmente pedimos cosas vagas.*

*Armé este repositorio para documentar lo que aprendí — incluyendo los errores — y combinarlo con los mejores proyectos que encontré en el ecosistema. Hoy les muestro eso. No es teoría. Es lo que funciona en la práctica."*

---

## BLOQUE 1 — Qué es el repo y por qué existe (7 min)

`[Abrí el repo en GitHub: github.com/amoreno33/llm-systems-engineering]`

💬 *"Esto es el repo. Siete secciones, todas en markdown, todas con ejemplos que se pueden copiar y usar hoy.*

*Antes de que alguien piense 'otro repositorio de prompts': no. Los prompts son lo de menos. Lo que hay acá es arquitectura. Proceso. Decisiones de diseño aplicadas a sistemas con IA."*

`[Mostrá la tabla de navegación en el README]`

💬 *"La estructura va de adentro hacia afuera. Empieza por cómo funcionan los modelos internamente — contexto, memoria, por qué alucina — y termina en cómo lo deployás en producción con seguridad y gobernanza.*

*Hoy no vamos a recorrer todo eso. Vamos a ir directo al hueso: la sección de sistemas agénticos, que es donde está el 80% del valor práctico.*

*Pero primero necesito que todos tengamos el mismo punto de partida filosófico."*

`[Mostrá la sección "Filosofía: Vibe Coding & SDD" del README]`

💬 *"Esta frase: 'El prompt deja de ser el producto. El producto es el sistema.'*

*Qué significa eso concretamente: cuando le pedís a Claude que haga algo, el valor no está en cómo redactaste el mensaje. El valor está en todo lo que el agente ya sabía antes de recibir tu mensaje. El archivo que le dice cómo se llaman las cosas en tu proyecto. Las decisiones de arquitectura que no puede cambiar. Los tests que definen qué es 'correcto'.*

*Si solo tienen ese contexto armado, un prompt mediocre da resultados buenos. Sin ese contexto, el mejor prompt del mundo da resultados inconsistentes.*

*Eso es lo que vamos a construir hoy conceptualmente."*

---

## BLOQUE 2 — El salto que nadie explica (5 min)

`[Abrí 04-agentic-systems, mostrá la tabla Chat vs. Agente]`

💬 *"Hay un salto que la mayoría de los equipos hace sin darse cuenta, y sin entender las implicaciones.*

*De usar Copilot o ChatGPT como asistente de autocompletado, a usar Cursor Agent o Claude Code como un agente que ejecuta cosas por su cuenta.*

*Esta tabla lo resume bien. La diferencia no es de calidad del modelo — es de naturaleza."*

`(Leé en voz alta solo: Acción, Memoria, Riesgo)`

💬 *"Un chat te da texto. Vos decidís qué hacer con ese texto.*

*Un agente toma decisiones. Lee tus archivos. Ejecuta comandos. Puede borrarte código, hacer commits, o entrar en un loop infinito intentando arreglar algo que él mismo rompió.*

*Trabajé con proyectos donde el agente hizo exactamente eso — entró en un loop de debugging que duró media hora y terminó modificando 12 archivos para arreglar un bug que era de una sola línea. Todo porque no había ningún mecanismo de stop.*

*El riesgo real no es que el agente sea malo. Es que sea muy rápido siendo malo."*

---

## BLOQUE 3 — Los 4 patrones de fallo (22 min)

`[Mostrá la sección "Los 4 Patrones de Fallo" en 04-agentic-systems]`

💬 *"Esta sección está basada en el trabajo de Matt Pocock — 34 mil estrellas en GitHub — y en experiencia propia. Son los cuatro problemas que vas a encontrar, sin excepción, cuando empezás a trabajar en serio con agentes.*

*Los cuatro. Si ya trabajaste con agentes y me decís que no te pasó ninguno, o no los estás viendo, o no los estás poniendo en producción."*

---

### PATRÓN 1 — "El agente no hizo lo que quería" (5 min)

💬 *"El número uno. Lejos el más común.*

*Yo lo llamo el problema del teléfono roto. Le explicás algo al agente, el agente interpreta, genera, vos ves el resultado, y la mitad no tiene nada que ver con lo que pediste.*

*El problema no es el agente. Es que nosotros pedimos cosas vagas porque asumimos que el contexto está implícito. 'Arreglame el bug del login' — ¿cuál bug? ¿en qué condiciones? ¿qué se espera que pase?"*

`[Mostrá el ejemplo ❌ vs ✅ del bloque 1]`

💬 *"Miren la diferencia. 'Arreglá el bug del login' vs. el prompt estructurado que describe exactamente el caso que falla, el archivo, la función, y cómo se llama al éxito.*

*La solución se llama Grilling Session. Técnica donde, antes de que el agente empiece a codear, te interroga. Te pregunta todo lo que no le dijiste explícitamente.*

*¿Suena a pérdida de tiempo? No lo es. Dos minutos de preguntas te ahorran dos horas de reescritura. Y con las herramientas actuales — hay un comando `/grill-me` en Matt Pocock Skills que hace esto automático — el agente conduce la sesión solo.*

*Personalmente lo que más me cambió el flujo fue simplemente acostumbrarme a no empezar a codear hasta no tener esas preguntas respondidas. Con o sin IA."*

---

### PATRÓN 2 — "El agente es verboso" (5 min)

💬 *"El segundo patrón parece menor pero tiene consecuencias reales.*

*El agente usa veinte palabras donde una alcanza. Dice 'el identificador único del producto en la base de datos' cuando debería decir 'SKU'. Llama 'usuario autenticado' a lo que en tu sistema se llama simplemente 'User'.*

*El problema no es estético. Cuando el agente usa un término inconsistente, genera código con nombres inconsistentes. Y ese código se mezcla con código tuyo que usa otros nombres. En tres semanas el proyecto es una ensalada de terminología y nadie sabe cuál es canónico."*

`[Mostrá el ejemplo de CONTEXT.md del patrón 2]`

💬 *"La solución viene de un libro de 2003. Domain-Driven Design, de Eric Evans. Concepto: crear un lenguaje compartido — Ubiquitous Language — que todos usan siempre. Desarrolladores, negocio, y ahora: el agente.*

*En la práctica: un archivo CONTEXT.md en la raíz del proyecto. Le decís qué términos usar, cuáles no usar, qué decisiones de arquitectura no se discuten.*

*Miren este ejemplo — 'No uses TypeORM. Usamos Prisma. No uses Jest. Usamos Vitest.' El agente lee esto al inicio de cada sesión y lo respeta. Punto final.*

*¿Cuánto cuesta? Un archivo de texto con veinte líneas. ¿Qué ganás? Código consistente desde el día uno y — según mediciones — entre un 30 y 50% menos de tokens por sesión. Menos tokens es menos costo y menos ruido en el contexto."*

---

### PATRÓN 3 — "El código no funciona" (6 min)

💬 *"El tercero. El agente generó algo. Parece bien. Ejecutás y explota.*

*La causa raíz: el agente no tiene forma de saber si lo que generó funciona. Está escribiendo código en un vacío. No tiene compilador, no tiene runtime, no tiene tests que le digan si rompió algo.*

*Y ahí es donde el desarrollo con IA sin disciplina se convierte en lo peor de dos mundos: rápido generando código que después tardás el doble en debuggear.*

*La solución es darle feedback loops. Y la más poderosa, la que más cambia la ecuación, es TDD."*

`(pausa)`

💬 *"Antes de que alguien cierre la laptop: TDD no es una religión. Es una técnica. Y con agentes se vuelve trivial de implementar porque el agente escribe los tests por vos.*

*El ciclo es: el agente escribe un test que falla primero — eso es el RED. Después escribe el código mínimo para que pase — GREEN. Después limpia sin romper — REFACTOR.*

*Lo que antes requería disciplina personal ahora lo impone el proceso."*

`[Mostrá el ejemplo TDD del bloque 3 — validación de emails]`

💬 *"Este ejemplo es deliberadamente simple para que sea claro. Una función que valida emails. Primero el test que falla. Después el código que lo hace pasar. Después la mejora.*

*Lo que importa no es el ejemplo — es el principio: el agente nunca genera código sin que haya un test esperándolo. Eso elimina el problema del 'parece que funciona'.*

*Hay una línea en Superpowers — el proyecto con 171 mil estrellas — que me pareció perfecta para describir esto: 'Hacé el plan lo suficientemente claro para que un junior entusiasta, con mal gusto y sin contexto del proyecto, lo pueda seguir'. Eso es exactamente lo que le pedís al agente. Claridad explícita, no implícita."*

---

### PATRÓN 4 — "La Bola de Barro" (6 min)

💬 *"El cuarto. El más traicionero porque tarda meses en aparecer.*

*Los tres anteriores son problemas inmediatos: el agente hizo algo mal, lo ves, lo corregís. Este no.*

*Este pasa así: el equipo adopta IA para desarrollo, el agente genera features rápido, todo parece bien, los deadlines se cumplen. Y entonces un día — puede ser seis semanas después, puede ser tres meses — alguien intenta hacer un cambio y descubre que nadie entiende el proyecto. Ni el equipo humano, ni el agente. Hay código duplicado en cuatro archivos distintos. Funciones de 400 líneas. Módulos que dependen de todo. Es imposible tocar algo sin romper otra cosa.*

*Se llama Ball of Mud. Anti-patrón de arquitectura documentado desde los noventa. El agente lo acelera porque puede generar entropía diez veces más rápido que un humano."*

`(pausa)`

`[Mostrá la cita de Kent Beck]`

💬 *"'Invest in the design of the system every day.' Kent Beck. El tipo que inventó Extreme Programming en los anos 90.*

*Esto no cambió con la IA. Si acaso, se volvió más urgente.*

*Y acá necesito ser muy directo: esto pasa usando Spec-Kit. Esto pasa usando BMAD. Esto pasa usando cualquier framework que elijan. Ninguna herramienta te salva del caos si no tomás decisiones de diseño todos los días. El framework te da estructura de proceso — no te da buen diseño automáticamente.*

*Las prácticas concretas están en el repo — módulos profundos, refactoring frecuente, pedir al agente que explique cómo encaja un módulo antes de escribirlo. Pero la mentalidad es esta: con agentes, el costo de no pensar en diseño no es lineal. Se multiplica."*

---

## BLOQUE 4 — El ecosistema real (8 min)

`[Mostrá la tabla de Frameworks en 04-agentic-systems]`

💬 *"Quiero hablar del ecosistema con honestidad, porque hay mucho ruido.*

*Cada semana hay un framework nuevo de agentes con 10 mil estrellas. La mayoría son wrappers de LangChain con otro nombre. Hay tres proyectos que vale la pena conocer porque tienen tracción real, filosofía sólida y llevan tiempo en el mercado."*

**Spec-Kit:**

💬 *"91 mil estrellas. Proyecto oficial de GitHub. Implementa Specification-Driven Development — lo que vimos antes como filosofía — con un workflow de seis pasos concretos.*

*Lo que lo diferencia: las specs no son documentación. Las specs ejecutan código directamente. Escribís la especificación, el framework genera el plan, el plan genera las tareas, las tareas se ejecutan. Es literalmente el proceso que describí antes, automatizado como herramienta.*

*Tiene más de cien extensiones comunitarias — para Jira, para ADRs automáticos, para revisiones de seguridad, para integración con Azure DevOps. Está vivo."*

**Superpowers:**

💬 *"171 mil estrellas. El más popular de los tres. Lo construyó Jesse Vincent, de Prime Radiant.*

*Es una metodología completa que se instala como plugin — funciona en Cursor, Claude Code, GitHub Copilot CLI, Gemini CLI. Lo que hace es imponer el workflow antes de que puedas ignorarlo: cuando le decís 'quiero construir X', no arranca a codear. Arranca con brainstorming. Te interroga. Genera un plan con tareas de dos a cinco minutos. Ejecuta con subagentes y hace dos revisiones por tarea — primero compliance con la spec, después calidad del código.*

*Es opinionado. Eso puede incomodar al principio. Pero esa opinión es exactamente lo que le falta a la mayoría de los equipos cuando adoptan IA."*

**Matt Pocock Skills:**

💬 *"34 mil estrellas. El más modular. Son skills individuales que activás según necesitás — `/grill-me`, `/tdd`, `/diagnose`. Ideal para adopción gradual sin cambiar todo el flujo de golpe.*

*Si el equipo no está listo para adoptar un framework completo, empiecen por acá. Un skill por semana. En un mes ya tienen el workflow cambiado sin que haya dolido."*

`[Mostrá brevemente la parte de MCP]`

💬 *"Un último tema que no puedo no mencionar: MCP, Model Context Protocol. Es el estándar de Anthropic para conectar agentes a sistemas externos — bases de datos, GitHub, Jira, sistemas internos.*

*Hoy es técnico de configurar. En seis meses va a ser infraestructura estándar en cualquier proyecto de IA empresarial. La única advertencia urgente: antes de conectar cualquier servidor MCP, revisad los permisos. Un server mal configurado puede darle al agente acceso de escritura a recursos que no debería tocar. Está documentado en el repo con ejemplos específicos."*

---

## BLOQUE 5 — Lo que se pueden llevar hoy (5 min)

`[Mostrá la sección Templates & Starter Kits en 07-high-value-resources]`

💬 *"Terminamos con lo práctico. Esta sección son archivos. No conceptos — archivos.*

*Hay un problema con el contenido técnico sobre IA: mucho habla de lo que hay que hacer y muy poco muestra exactamente cómo hacerlo. Esta sección intenta cerrar esa brecha.*

*Hay templates de CLAUDE.md — básico y avanzado. Templates de CONTEXT.md con lenguaje del dominio. Templates de ADR, de Feature Specs, de Implementation Plans. Y un template de skill personalizado si quieren extender el workflow con sus propias reglas.*

*La mentalidad con estos templates es esta: no son documentación que escribís para los humanos del equipo. Son inputs que le das al agente. Si el agente los ignora o los sobrescribe, es señal de que no son suficientemente específicos todavía. Los refinás hasta que el agente los respete consistentemente.*

*Eso, dicho de otra forma, es el trabajo real de ingeniería con IA hoy: no encontrar el prompt perfecto. Construir el sistema de contexto que hace que el agente se comporte como un integrante del equipo."*

---

## CIERRE (3 min)

`[Mostrá el README principal, scroll lento]`

💬 *"Para cerrar.*

*El ecosistema de IA para desarrollo cambió más en dieciocho meses que en los diez años anteriores. Y va a seguir cambiando. Las herramientas que están en este repo hoy no son las que vamos a usar en dos años.*

*Pero los principios que vimos no van a cambiar. Especificaciones antes de código. Tests como ciudadanos de primera clase. Diseño intencional todos los días. Lenguaje compartido en el equipo. Eso tiene cuarenta años y sigue siendo verdad.*

*Lo único nuevo es que ahora hay que aplicarlo también con el agente. Porque el agente no es un dev senior que entiende el contexto implícito. Es un dev muy capaz que necesita estructura explícita para no convertir tu proyecto en caos.*

*El repo está público. Se actualiza. Si tienen algo para aportar — un patrón que encontraron, un tool que no está, un error en la documentación — bienvenido.*

*(pausa)*

*Preguntas."*

---

## Preguntas que van a salir — y cómo responderlas

**"¿Cuál herramienta empezamos?"**
> *"Depende de cuánto dolor están dispuestos a tomar al principio. Spec-Kit si quieren el proceso completo desde cero. Superpowers si ya usan Claude Code o Cursor y quieren imponer workflow sin mucho cambio. Matt Pocock Skills si quieren gradual. Los tres están en el repo con links directos."*

**"¿Vale la pena si los modelos van a mejorar solos?"**
> *"Los modelos mejoran. La entropía arquitectónica no se resuelve sola. El modelo más inteligente del mundo va a generar código inconsistente si no tiene contexto del proyecto. El contexto no lo reemplaza el modelo — lo necesita."*

**"¿Y si trabajo solo?"**
> *"Especialmente si trabajás solo. Sin documentación de contexto, cada sesión empieza desde cero. Con CLAUDE.md y CONTEXT.md el agente recuerda las decisiones del proyecto. Es la diferencia entre tener un colaborador que aprendió cómo trabajás y uno que conociste hoy."*

**"¿Seguridad con MCP?"**
> *"El repo tiene una sección completa en Ops & Security. Lo urgente: nunca conectes un servidor MCP con acceso de escritura a producción sin Human-in-the-Loop. El agente propone, el humano aprueba. Eso no es opcional en entornos empresariales."*

**"¿Cuánto tiempo lleva implementar esto?"**
> *"El CLAUDE.md básico: media hora. El CONTEXT.md: una hora la primera vez. El workflow completo con TDD y specs: dos semanas de adaptación del equipo. No es costo — es inversión. La alternativa es reescribir el proyecto en tres meses."*


---

## ⏱️ Estructura General (60 min)

| Bloque | Tema | Tiempo |
| :--- | :--- | :--- |
| 0 | Intro: De qué va esto (y de qué NO va) | 5 min |
| 1 | Recorrida del repo: estructura y filosofía | 8 min |
| 2 | El problema real: vibe coding sin estructura | 5 min |
| 3 | Los 4 patrones de fallo + soluciones (core) | 20 min |
| 4 | Ecosistema de herramientas y frameworks | 8 min |
| 5 | Templates y cómo usarlos mañana | 7 min |
| 6 | Cierre y preguntas | 7 min |

---

## BLOQUE 0 — Intro (5 min)

> 👁️ **Mostrás:** El inicio del repo en GitHub (`github.com/amoreno33/llm-systems-engineering`)

---

💬 **Decís:**

*"Voy a arrancar con lo que esto NO es, para que nadie se lleve una desilusión.*

*Esto NO es un tutorial de 'cómo hacer mejores prompts'. Hay miles de esos y la mayoría está desactualizado en 3 meses.*

*Lo que armé acá es algo diferente: es una recopilación de **experiencia directa** trabajando con agentes en proyectos reales, combinada con los aportes de proyectos que hoy tienen entre 34 mil y 171 mil estrellas en GitHub. Gente que lleva años pensando en estos problemas.*

*La pregunta central de este repo es una sola: **¿Cómo construís un sistema con IA que no se convierta en un caos con el tiempo?***

*Y spoiler: la respuesta no es un modelo nuevo, ni una herramienta nueva. Es disciplina de ingeniería aplicada a un contexto nuevo."*

---

## BLOQUE 1 — Recorrida del Repo (8 min)

> 👁️ **Mostrás:** `README.md` → Mapa de Navegación (tabla de secciones)

---

💬 **Decís:**

*"El repo tiene 7 módulos. Hoy no vamos a cubrir todo en profundidad — nos vamos a enfocar en lo que creo que más impacto tiene en el día a día.*

*Pero quiero que noten la estructura: no arranqué por herramientas. Arranqué por fundamentos. Porque el error más común que veo es que la gente instala Cursor, empieza a 'vibear' código, y en dos semanas tiene un proyecto que ya nadie entiende — incluyendo el agente.*

*La lógica del repo es esta:"*

*(Mostrá tabla. Leé en voz alta solo las columnas "Core Focus" y "Valor").*

*"Foundations. LLM Engineering. Advanced RAG. Agentic Systems — que es donde vamos a poner la mayor parte del tiempo hoy. Cloud. Ops & Security. Y Resources.*

*Pero antes de entrar al contenido, necesito hablarles de la filosofía que atraviesa todo esto."*

> 👁️ **Mostrás:** Sección `Filosofía de Trabajo: Vibe Coding & SDD`

💬 **Decís:**

*"El concepto clave es este: el prompt deja de ser el producto. El producto es el sistema.*

*¿Qué significa eso? Que cuando le pedís a un agente que haga algo, el valor no está en el mensaje que le mandaste. El valor está en **el contexto que ya tenía** cuando ejecutó. El CLAUDE.md que le dijiste qué no hacer. El CONTEXT.md con el lenguaje del proyecto. Los tests que definían qué era 'correcto'.*

*Esto es lo que llamamos Specification Driven Development. No es nuevo — es ingeniería de software aplicada a IA. Separar el diseño de la implementación no es magia. Es proceso."*

---

## BLOQUE 2 — El Problema Real (5 min)

> 👁️ **Mostrás:** Sección del README `Chat vs. Agente` en `04-agentic-systems`

---

💬 **Decís:**

*"Antes de las soluciones, necesito que todos tengamos claro cuál es el problema.*

*¿Cuántos acá usaron Copilot, Cursor, o ChatGPT para escribir código este mes?* (pausa)

*Bien. ¿Y cuántos tuvieron que reescribir algo que el agente generó porque no hacía exactamente lo que necesitaban?* (pausa)

*Eso es el problema. No es que los agentes sean malos. Es que **la brecha entre lo que pedimos y lo que necesitamos** es enorme cuando no tenemos un proceso.*

*Esta tabla lo muestra bien:"*

*(Mostrá la tabla Chat vs. Agente. Lee las filas: Acción, Memoria, Riesgo.)*

*"Un chat te da un plano. Un agente **construye la casa**. Y si la casa tiene errores de arquitectura desde el día 1, con un agente los vas a multiplicar 10 veces más rápido.*

*El riesgo no es que el agente sea malo. El riesgo es que sea **muy rápido siendo malo**."*

---

## BLOQUE 3 — Los 4 Patrones de Fallo (20 min — core de la presentación)

> 👁️ **Mostrás:** `04-agentic-systems/README.md` → sección Los 4 Patrones de Fallo

---

💬 **Intro del bloque:**

*"Esta es la sección más importante del repo y de la presentación. Cuatro patrones de fallo que vas a reconocer si trabajaste con agentes. Cuatro con soluciones concretas, no teóricas."*

---

### PATRÓN 1: "El Agente No Hizo Lo Que Quería" (5 min)

> 👁️ **Mostrás:** El bloque del patrón 1 con los dos ejemplos de código (❌ y ✅)

💬 **Decís:**

*"El número uno. Y es el número uno por lejos.*

*El problema se llama desalineamiento. Y existe desde siempre en ingeniería de software — el cliente pide algo, el dev entiende otra cosa, tres semanas después hay una reunión muy incómoda.*

*Con IA el ciclo es más corto. Puede pasar en minutos. Le pedís algo, el agente interpreta, genera 300 líneas, y cuando ves el resultado decís 'no, no era eso'.*

*La solución se llama Grilling Session. En lugar de que vos le des instrucciones, el agente te interroga primero.*

*(Mostrá el ejemplo ❌ / ✅)*

*Mirá la diferencia. En el ejemplo malo, le decís 'haceme un sistema de pagos' y el agente arranca a codear. En el ejemplo bueno, primero te pregunta: ¿es recurrente o único? ¿qué monedas? ¿tenés webhooks configurados?*

*Dos minutos de preguntas te ahorran dos horas de reescritura. Y esto no es solo una buena práctica — está implementado en herramientas reales: el comando `/grill-me` de Matt Pocock Skills hace esto automáticamente."*

---

### PATRÓN 2: "El Agente Es Demasiado Verboso" (5 min)

> 👁️ **Mostrás:** El bloque del patrón 2 con el ejemplo de `CONTEXT.md`

💬 **Decís:**

*"El segundo patrón. Menos dramático que el primero, pero igualmente costoso.*

*El agente usa 20 palabras donde 1 es suficiente. Dice 'el identificador único del producto en la base de datos' cuando debería decir 'SKU'. Esto no es solo un problema estético. Consume el contexto del modelo, genera código inconsistente, y hace que cada sesión empiece desde cero.*

*La solución viene de un libro de 2003: Domain-Driven Design de Eric Evans. La idea es simple: acordar un lenguaje común. En código.*

*(Mostrá el ejemplo de CONTEXT.md)*

*Este archivo — un CONTEXT.md en la raíz del proyecto — es el vocabulario del agente. Le decís qué términos usar, qué no usar, qué decisiones de arquitectura no puede cuestionar.*

*¿Por qué importa? Dos razones concretas: primero, el código generado va a ser consistente desde el día 1. Segundo, según mediciones propias y de otros equipos, reduce el uso de tokens en 30 a 50%. Menos tokens es menos costo y menos ruido en el contexto.*

*Es literalmente un archivo de texto plano con 20 líneas. Y hace una diferencia enorme."*

---

### PATRÓN 3: "El Código No Funciona" (5 min)

> 👁️ **Mostrás:** El bloque del patrón 3 con el ejemplo TDD (RED/GREEN/REFACTOR)

💬 **Decís:**

*"El tercero. El agente generó código. Parece correcto. Y cuando ejecutás, explota.*

*La causa es que el agente no tiene feedback automático. Está escribiendo código en un notepad sin compilador. No sabe si lo que generó funciona hasta que vos se lo decís — o hasta que el sistema falla en producción.*

*La solución es darle feedback loops. Y la más poderosa es TDD — Test Driven Development.*

*Antes de que alguien salga por la puerta: esto no es nuevo, no es complicado, y con agentes se vuelve trivial de implementar.*

*(Mostrá el ejemplo TDD con el agente)*

*El ciclo es este: primero el agente escribe un test que falla — eso es el RED. Después escribe el código mínimo para que pase — eso es el GREEN. Después mejora el código sin romper el test — eso es el REFACTOR.*

*Lo que antes requería que vos escribieras los tests manualmente, ahora el agente los escribe por vos. El agente asume el rol del dev disciplinado. Vos te limitás a revisar y aprobar.*

*Hay una línea en el repo de Superpowers — 171 mil estrellas en GitHub — que me parece perfecta: 'Escribe el plan lo suficientemente claro para que un junior entusiasta con mal gusto, sin juicio y sin contexto del proyecto lo pueda seguir'. Eso es exactamente lo que le pedís al agente."*

---

### PATRÓN 4: "La Bola de Barro" (5 min)

> 👁️ **Mostrás:** El bloque del patrón 4 con la cita de Kent Beck y el ejemplo de Módulo Profundo

💬 **Decís:**

*"El cuarto patrón. Y este es el más traicionero porque no lo ves venir.*

*Con los tres anteriores, el problema es inmediato: el agente hizo algo mal, lo ves, lo arreglas. Con este, el problema tarda meses en aparecer. El agente generó código rápido durante semanas. Todo funcionaba. Y después, un día, nadie entiende el proyecto. Ni vos, ni el agente, ni el próximo dev.*

*Esto se llama Ball of Mud. Un anti-patrón de arquitectura tan viejo como la disciplina. El agente lo acelera porque puede generar entropía 10 veces más rápido que un humano.*

*(Pausa. Mostrá la cita de Kent Beck)*

*'Invest in the design of the system every day.' Kent Beck, el creador de XP — Extreme Programming.*

*Esto no cambió con los agentes. Si acaso, se volvió más urgente.*

*Y acá hay algo que quiero que quede claro: esto pasa usando BMAD. Esto pasa usando Spec-Kit. Esto pasa usando cualquier framework que elijan. Ninguna herramienta te salva del caos arquitectónico si no tomás decisiones de diseño activas todos los días.*

*(Mostrá el ejemplo de Módulo Profundo ❌ / ✅)*

*La práctica concreta se llama Módulos Profundos: interfaz simple, mucha funcionalidad interna. El ejemplo es perfecto — `saveUser(user)` que internamente maneja validación, encriptación, transacciones y logs. Para el que llama, es una sola función. Por dentro, es un sistema.*

*El pedido al agente tiene que incluir esto. No 'generame una función de validación'. Sino 'generame una función `saveUser` que sea el único punto de entrada para crear usuarios, que internamente maneje todo, y que exponga la mínima interfaz posible'."*

---

## BLOQUE 4 — Ecosistema de Herramientas (8 min)

> 👁️ **Mostrás:** `04-agentic-systems/README.md` → tabla Frameworks de Workflow

---

💬 **Decís:**

*"Ahora que tenemos el problema claro, hablemos de las herramientas. Y voy a ser honesto: en este ecosistema, las herramientas cambian cada semana. Lo que no cambia son los principios que acabo de mostrar.*

*Dicho eso, hay tres proyectos que vale la pena conocer porque llevan ventaja tanto en adopción como en calidad.*

*(Mostrá la tabla)*

**Spec-Kit:**
*91 mil estrellas. Es el proyecto oficial de GitHub. Implementa Specification-Driven Development con un workflow de 6 pasos: constitution, specify, plan, tasks, implement, analyze. La clave es que las specs no Son documentación — ejecutan código directamente. Si van a adoptar un solo framework hoy, empiecen por acá.*

**Superpowers:**
*171 mil estrellas — el más popular de los tres. Es una metodología completa que se instala como plugin en Cursor, Claude Code, GitHub Copilot CLI. Lo que hace es imponer el workflow automáticamente: antes de codear, brainstorming. Antes de ejecutar, plan. Durante la ejecución, TDD forzado. Es opinionado, y eso es bueno — saca las decisiones de proceso de tu cabeza.*

**Matt Pocock Skills:**
*34 mil estrellas. Más modular que los anteriores. Son skills individuales que podés activar según necesitás: `/grill-me` para la grilling session, `/tdd` para test driven, `/diagnose` para debugging. Ideal si querés adoptar gradualmente sin cambiar todo el flujo de golpe.*

*En el repo hay una tabla de cuándo usar cada uno. El mensaje principal es: no hay uno correcto. Depende de tu proyecto, tu equipo, y tu nivel de adopción de IA.*"

> 👁️ **Mostrás:** Sección MCP en el mismo archivo

💬 **Decís:**

*"Algo que vale mencionar rápido porque es infraestructura del futuro próximo: MCP, Model Context Protocol. Es el estándar de Anthropic para conectar agentes a herramientas externas — bases de datos, GitHub, Jira, sistemas internos — con una sola integración reutilizable.*

*Hoy todavía es relativamente técnico de configurar, pero en 6 meses no va a haber proyecto de IA empresarial que no lo use. Está en el repo con los servidores más útiles y una advertencia importante de seguridad: revisad los permisos antes de conectar cualquier servidor MCP a un agente. Un server mal configurado puede darle al agente acceso que no debería tener."*

---

## BLOQUE 5 — Templates y Uso Práctico (7 min)

> 👁️ **Mostrás:** `07-high-value-resources/README.md` → sección Templates & Starter Kits

---

💬 **Decís:**

*"La sección que más me interesa que se lleven de acá.*

*Todo lo que vimos hasta ahora son conceptos. Esta sección son archivos. Archivos que pueden copiar hoy, adaptar en 10 minutos, y empezar a usar mañana.*

*(Scroll lento por la sección).*

*Hay cuatro tipos de templates.*

*El primero es el CLAUDE.md básico. Dos versiones: una para empezar, una para cuando ya tenés el workflow más claro. El archivo define tech stack, lenguaje del dominio, decisiones de arquitectura que el agente no puede cuestionar. Si solo adoptan una cosa de esta presentación, que sea tener un CLAUDE.md en cada proyecto.*

*El segundo es el CONTEXT.md. Lenguaje del dominio, restricciones técnicas, historia de decisiones. La diferencia entre tener esto y no tenerlo es que el agente empiece cada sesión como un dev nuevo versus uno que ya conoce el proyecto.*

*El tercero es el template de ADR — Architecture Decision Record. Para documentar por qué tomaron una decisión técnica. No para el equipo humano: para el agente. En lugar de explicarle 20 veces por qué usamos Vitest en lugar de Jest, el agente lee el ADR-003 y lo sabe.*

*El cuarto es el template de Feature Spec en formato Spec-Kit: user story, acceptance criteria, qué está fuera del scope, métricas de éxito. Esto es lo que el agente necesita antes de tocar una línea de código.*

*(Mostrá el tip final al final de la sección)*

*Hay un tip al final de la sección que quiero cerrar con esto: 'Estos templates no son documentación muerta. Son inputs para el agente. Si el agente los ignora, significa que no son suficientemente específicos. Refiná hasta que los respete.'*

*Eso resume bien el trabajo real: no es encontrar el prompt perfecto. Es construir el sistema de contexto que hace que el agente se comporte como un integrante del equipo."*

---

## BLOQUE 6 — Cierre y Preguntas (7 min)

> 👁️ **Mostrás:** `README.md` → sección principal (top)

---

💬 **Decís:**

*"Para cerrar, lo que quiero que se lleven es esto:*

*El ecosistema de IA para desarrollo cambió en los últimos 18 meses más de lo que cambió en los 10 años anteriores. Las herramientas que usamos hoy no son las mismas que vamos a usar en un año. Eso es realidad.*

*Pero la ingeniería de software tiene 40 años de aprendizajes que siguen vigentes: especificaciones antes de código, tests como ciudadanos de primera clase, diseño intencional todos los días, lenguaje compartido en el equipo. Nada de esto cambió. Lo que cambió es que ahora tenés que aplicarlo también con el agente.*

*El agente no es un dev senior que entiende implícitamente el contexto. Es un dev muy capaz que necesita estructura explícita para no convertir tu proyecto en caos. Dársela es tu trabajo.*

*El repo está en [github.com/amoreno33/llm-systems-engineering](https://github.com/amoreno33/llm-systems-engineering). Es público, es vivo — se actualiza. Si tienen algo para aportar, bienvenido.*"

---

### Preguntas frecuentes anticipadas

**"¿Cuál herramienta recomendás empezar?"**
> *"Spec-Kit si querés adoptar SDD completo. Superpowers si ya usás Claude Code o Cursor y querés imponer un workflow. Matt Pocock Skills si preferís empezar gradual. Los tres están documentados con links en el repo."*

**"¿Vale la pena invertir en esto si los modelos van a mejorar solos?"**
> *"Los modelos mejoran. La entropía arquitectónica no se soluciona sola. El agente más inteligente del mundo va a generar código inconsistente si no tiene contexto. El CONTEXT.md no lo reemplaza el modelo — lo alimenta."*

**"¿Esto aplica si trabajo solo y no en equipo?"**
> *"Especialmente si trabajás solo. El agente es tu 'equipo'. Sin documentación de contexto, cada sesión arranca desde cero. Con CLAUDE.md y CONTEXT.md, el agente recuerda las decisiones del proyecto."*

**"¿Y la seguridad? Mencionaste MCP..."**
> *"El repo tiene una sección completa en 06-Ops & Security. El punto urgente es MCP: antes de conectar cualquier servidor MCP, revisá los permisos. Y nunca conectes herramientas con acceso de escritura a producción sin HITL — Human in the Loop. El agente propone, el humano aprueba."*

---

## 📌 Notas para el Presentador

- **Los bloques 3 y 5** son los más densos. Si sentís que la audiencia está saturada, podés cortar el bloque 4 a la mitad y usar ese tiempo para preguntas anticipadas.
- **El bloque 3** (patrones de fallo) es el corazón. Si el tiempo aprieta, no lo cortés — cortá los otros.
- **Para la parte práctica** que mencionaste que faltaría: una demo en vivo de cómo crear un CLAUDE.md real con Claude Code o Cursor sería el complemento natural. Tiempo estimado: 10-15 min adicionales.
