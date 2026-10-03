#show link: underline

#set document(
  title: [ЛР2],
)

#let img(imagePath, caption, supplement: [Рисунок]) = {
  align(center)[
    #figure(image(imagePath), caption: caption, supplement: supplement)
  ]
}


#set page(
  paper: "a4",
  numbering: "1",
)

#set par(
  justify: true,
  first-line-indent: (
    amount: 1.25cm,
    all: true,
  ),
  spacing: 0.65em,
)

#set text(
  lang: "ru",
  font: "Times New Roman",
  size: 14pt,
)

#set page(footer: context {
  if counter(page).get().first() > 1 [
    #align(center)[
      #counter(page).display("1")
    ]
  ]
  if counter(page).get().first() == 1 [
    #align(center)[
      Санкт-Петербург \ 2026
    ]
  ]
})

#set page(header: context {
  if counter(page).get().first() == 1 [
    #align(center)[
      *Министерство науки и высшего образования Российской Федерации* \
    ]
  ]
})

#show raw: set text(font: "Consolas")
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)

// title

#align(center)[
  ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ АВТОНОМНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ВЫСШЕГО ОБРАЗОВАНИЯ
]

#align(center)[
  #text(size: 12pt)[
    \ *НАЦИОНАЛЬНЫЙ ИССЛЕДОВАТЕЛЬСКИЙ УНИВЕРСИТЕТ ИТМО*
  ]
]

#align(center)[
  \ *ITMO University*
]


#for _ in range(5) { linebreak() }

#align(center)[*ЛАБОРАТОРНАЯ 2*]

#table(
  stroke: white,
  columns: 1,
  inset: 10pt,

  [*По дисциплине* Контейнеризация и оркестрация приложений],
  [*Тема работы* Знакомство с экосистемой Docker: от базовых команд к диагностике сервиса],
  [*Обучающийся* Дощенников Никита Андреевич],
  [*Факультет* Прикладной информатики],
  [*Группа* К3321],
  [*Направление подготовки* 11.03.02 Инфокоммуникационные технологии и системы связи],
  [*Образовательная программа* Программирование в инфокоммуникационных системах],
  [],
)

#table(
  stroke: white,
  columns: 4,
  inset: 10pt,

  table.cell(align: top)[*Обучающийся*],

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 10pt, fill: white)[.]],
    [#line(length: 100pt)],
  ),

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 11pt, fill: white)[.]],
    [#line(length: 100pt)],
  ),

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 10pt)[Дощенников Н.А.]],
    [#line(length: 100pt)],
  ),

  [],
  table.cell(align: center)[#text(size: 10pt)[(дата)]],
  table.cell(align: center)[#text(size: 10pt)[(подпись)]],
  table.cell(align: center)[#text(size: 10pt)[(Ф.И.О.)]],

  table.cell(align: top)[*Руководитель*],

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 10pt, fill: white)[.]],
    [#line(length: 100pt)],
  ),

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 11pt, fill: white)[.]],
    [#line(length: 100pt)],
  ),

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 10pt)[Аминов Н.С.]],
    [#line(length: 100pt)],
  ),

  [],
  table.cell(align: center)[#text(size: 10pt)[(дата)]],
  table.cell(align: center)[#text(size: 10pt)[(подпись)]],
  table.cell(align: center)[#text(size: 10pt)[(Ф.И.О.)]],
)


#pagebreak()

#outline(title: [Содержание])

#pagebreak()
= Персональные параметры

#align(center)[
  #figure(
    table(
      columns: 2,
      inset: 10pt,
      align: horizon + center,
      fill: (x, y) => if (y == 0) { gray },
      table.header([*Параметр*], [*Значение*]),
      [Номер ИСУ], [_465797_],
      [Персональный порт], [_#(5430 + 97)_],
      [Персональный префикс], [_doschennikov_],
      [Секретный ключ], [_secret97doschennikov_],
    ),
    caption: [Персональные параметры],
  )
]

#pagebreak()
= Этап 1. Первый рабочий образ

Я склонировал репозиторий с приложением:

```sh
git clone https://github.com/FilBTi/assist-py
```

#img("assets/1.png", [Клонирование репозитория])

== Задание 1.1

Я создал `Dockerfile` в корне проекта:

```Dockerfile
FROM python:3.11-slim

LABEL maintainer="doschennikov@lab.local"
LABEL version="1.0"

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app/

EXPOSE 5527

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "5527"]
```

#img("assets/2.png", [Созданный `Dockerfile`])

== Задание 1.2

Я собрал образ:

```sh
docker build -t doschennikov-assistant:v1 .
```

#img("assets/3.png", [Собранный образ])

== Задание 1.3

Затем я запустил контейнер с переменными окружения:

```sh
docker run -d \
  --name doschennikov-assistant-1 \
  -p 5527:5527 \
  -e APP_OWNER=doschennikov \
  -e APP_SECRET=secret97doschennikov \
  doschennikov-assistant:v1
```

#img("assets/4.png", [Запущенный контейнер])

== Задание 1.4

Затем я проверил работоспособность:

- Проверка главной страницы:
  ```sh
  curl http://localhost:5527/
  ```
  #img("assets/5.png", [Проверка главной страницы])

- Проверка персонализации:
  ```sh
  curl http://localhost:5527/me
  ```
  #img("assets/6.png", [Проверка персонализации])

- Тест заметок:
  ```sh
  curl -X POST http://localhost:5527/notes \
    -H "Content-Type: application/json" \
    -d '{"text": "ЛР2: сборка образа"}'

  curl http://localhost:5527/notes
  ```
  #img("assets/7.png", [Тест заметок])

- Тест секретного эндпоинта
  ```sh
  curl http://localhost:5527/secret/secret97doschennikov
  ```
  #img("assets/8.png", [Тест секретного эндпоинта])

#pagebreak()
= Этап 2. Оптимизация образа

== Задание 2.1

Я разбил Dockerfile на стадию сборки и получения финального образа:

```Dockerfile
FROM python:3.11 AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /install /usr/local
COPY app/ ./app/
EXPOSE 5527
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "5527"]
```

== Задание 2.2

Я собрал оптимизированный образ:

```sh
docker build -t doschennikov-assistant:v2 -f Dockerfile.optimized .
```

#img("assets/9.png", [Результат сборки образа])

И сравнил их размеры:

```sh
docker images | grep doschennikov-assistant
```

#img("assets/10.png", [Результат сравнения размера образов])

// Размер образа уменьшился на #(255 - 239)MB. Копирование `requirements.txt` отдельно от кода ускоряет повторные сборки при изменении бизнес-логики, так как при каждом изменении кода нет необходимости повторно копировать `requirements.txt`, а можно просто сделать это один раз. Это показывает принцип раздельной сборки.
// INSERTED START
Размер образа уменьшился на #(255 - 239)MB (с 255MB до 239MB). Уменьшение даёт multi-stage сборка: зависимости устанавливаются в полном образе `python:3.11` (стадия `builder`), а в финальный образ на основе `python:3.11-slim` копируются только уже установленные пакеты, без инструментов сборки. Эффект небольшой, потому что первая версия образа уже была собрана на `slim`.

Копирование `requirements.txt` отдельно от кода ускоряет повторные сборки, потому что Docker кэширует каждый слой образа. Пока файл `requirements.txt` не изменился, слой с `pip install` берётся из кэша, и при правке бизнес-логики пересобирается только слой `COPY app/`. Если бы код копировался до установки зависимостей, то любое его изменение сбрасывало бы кэш, и все зависимости устанавливались бы заново.
// INSERTED END

#pagebreak()
= Этап 3. `.dockerignore` --- чистота в образе

== Задание 3.1

В корне проекта я создал файл `.dockerignore` со следующим содержимым:

```exclude
__pycache__/
*.pyc
*.pyo
.git
.gitignore
.venv/
venv/
.env
*.log
Dockerfile*
README.md
```

== Задание 3.2

Я пересобрал образ командой:

```sh
docker build -t doschennikov-assistant:v3 .
```

#img("assets/11.png", [Пересобранный образ])

Без `.dockerignore` весь каталог проекта попадает в контекст сборки, и при инструкциях вроде `COPY . .`, а также при `COPY app/`, если файлы лежат внутри `app/`, в образ могли бы попасть все файлы, которые сейчас перечислены в нём: кэш python (`__pycache__/`, `*.pyc`, `*.pyo`), история Git (`.git`, `.gitignore`), локальные виртуальные окружения (`.venv/`, `venv/`), файл с переменными окружения `.env`, логи (`*.log`), а также `Dockerfile*` и `README.md`. Всё это увеличивает размер образа, ухудшает кэширование, так как любое изменение лишнего файла сбрасывает слой `COPY`, и может раскрыть лишнюю информацию.

Наличие директории `.git` в образе является потенциальной уязвимостью, так как в ней хранится вся история проекта, включая старые версии кода, адреса удалённых репозиториев, а также секреты (пароли, токены, ключи), которые когда-либо были закоммичены, даже если потом их удалили из текущей версии файлов. Любой, у кого есть доступ к образу, может запустить его, извлечь `.git` и восстановить эти данные командами `git log` и `git checkout`. Аналогично файл `.env` обычно содержит секреты в открытом виде.

Образ `v3` получил тот же идентификатор, что и `v2` (`7672f18c710f`), и все шаги были взяты из кэша (`Using cache`). Это ожидаемо, так как `.dockerignore` не затрагивает файлы, которые копируются в образ (`requirements.txt` и `app/`), поэтому содержимое слоёв не изменилось.

#pagebreak()
= Этап 4. Healthcheck --- готовность к оркестрации

== Задание 4.1

В конец `Dockerfile.optimized` я добавил:

```sh
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:5527/health || exit 1
```

== Задание 4.2

Я собрал финальную версию:

```sh
docker build -t doschennikov-assistant:final -f Dockerfile.optimized .
```

#img("assets/12.png", [Сборка финальной версии])

== Задание 4.3

Я проверил статус здоровья. Запустил контейнер:

```sh
docker run -d \
  --name doschennikov-assistant-final \
  -p 5527:5527 \
  -e APP_OWNER=doschennikov \
  -e APP_SECRET=secret97doschennikov \
  doschennikov-assistant:final
```

#img("assets/13.png", [Запуск контейнера])

И проверил статус:

```sh
docker ps --filter "name=doschennikov-assistant-final" --format "table {{.Names}}\t{{.Status}}"
```

После первого запуска контейнер получил статус `unhealthy`, хотя приложение работало и отвечало на запросы. Эндпоинт `/health` с хоста отвечал корректно:

```sh
curl http://localhost:5527/health
```

Ответ: `{"status":"healthy","owner":"doschennikov"}`. Я проверил, что делает проверка внутри контейнера:

```sh
docker exec doschennikov-assistant-final which curl
docker inspect --format='{{json .State.Health}}' doschennikov-assistant-final
```

Команда `which curl` ничего не вернула, а в поле `Output` каждой проверки было `/bin/sh: 1: curl: not found`, при этом `FailingStreak` постоянно рос. Причина в том, что в образе `python:3.11-slim` нет утилиты `curl`.

Для исправления я добавил в финальную стадию `Dockerfile.optimized` установку утилиты `curl`:

```sh
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*
```

После этого я пересобрал образ и запустил контейнер заново. Размер образа вырос с 239MB до 258MB из-за `curl`:

```sh
docker rm -f doschennikov-assistant-final
docker build -t doschennikov-assistant:final -f Dockerfile.optimized .
docker run -d \
  --name doschennikov-assistant-final \
  -p 5527:5527 \
  -e APP_OWNER=doschennikov \
  -e APP_SECRET=secret97doschennikov \
  doschennikov-assistant:final
sleep 10
```

После запуска статус контейнера стал `healthy`:

#img("assets/14.png", [Проверка статуса контейнера])

#pagebreak()
= Этап 5. Финальный артефакт и тегирование

== Задание 5.1

Добавлен тег с версией:

```sh
docker tag doschennikov-assistant:final doschennikov-assistant:1.0.0
```

#img("assets/15.png", [Тег с версией])

Добавлен тег с датой сборки:

```sh
docker tag doschennikov-assistant:final doschennikov-assistant:$(date +%Y%m%d)
```

#img("assets/16.png", [Тег с датой сборки])

== Задание 5.2

Артефакт выполнения:

```sh
echo "========================================" && \
echo "Сборка завершена: $(date '+%d.%m.%Y %H:%M:%S')" && \
echo "Студент: $(whoami)@$(hostname)" && \
echo "Образ: doschennikov-assistant" && \
echo "========================================" && \
docker images | grep doschennikov-assistant | awk '{print $1, $2, $7}'
```

#img("assets/17.png", [Артефакт выполнения])

#pagebreak()
= Приложение

== `Dockerfile.optimized`:

```Dockerfile
FROM python:3.11 AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.11-slim

LABEL maintainer="doschennikov@lab.local"
LABEL version="1.0"

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /install /usr/local

COPY app/ ./app/

EXPOSE 5527

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "5527"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:5527/health || exit 1
```

#pagebreak()
== `.dockerignore`:

```exclude
__pycache__/
*.pyc
*.pyo
.git
.gitignore
.venv/
venv/
.env
*.log
Dockerfile*
README.md
```
