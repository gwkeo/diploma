# Установка `tick` для ноутбука

## Почему установка может падать

Для `tick` недостаточно только `pip`. Пакет собирает C++ расширения, поэтому нужны:

- `Python 3.11` или `3.12`
- C++ компилятор
- `cmake`
- системные заголовки Python

Если в логе есть ошибка вида:

```text
Could not find the compiler specified in the environment variable CXX:
x86_64-linux-gnu-g++
```

это значит, что сборка не нашла установленный `g++` или у вас выставлены конфликтующие переменные окружения `CC` / `CXX`.

## Ubuntu 22.04/24.04

```bash
sudo apt-get update
sudo apt-get install -y \
  build-essential \
  cmake \
  ninja-build \
  git \
  python3-dev \
  python3-venv
```

Если у вас явно нужен `Python 3.12`, а системный `python3` другой, используйте соответствующие пакеты:

```bash
sudo apt-get install -y python3.12 python3.12-dev python3.12-venv
```

## Создание окружения

### Вариант A: системный `venv`

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -U pip setuptools wheel
unset CC CXX
python -m pip install -r requirements.txt
```

### Вариант B: conda

```bash
conda create -n hawkes-diploma python=3.12 -y
conda activate hawkes-diploma
pip install -U pip setuptools wheel
unset CC CXX
pip install -r requirements.txt
```

## Проверка

```bash
python -c "import tick; print('tick ok')"
```

## Если установка всё ещё падает

Проверьте:

```bash
python --version
which g++
g++ --version
echo "${CC:-<empty>}"
echo "${CXX:-<empty>}"
```

Нормальный путь для Ubuntu amd64 обычно содержит:

```text
/usr/bin/g++
```

или

```text
/usr/bin/x86_64-linux-gnu-g++
```

Если `CC`/`CXX` указывают на несуществующий компилятор, просто сбросьте их:

```bash
unset CC CXX
```
