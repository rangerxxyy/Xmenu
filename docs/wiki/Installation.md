# 📦 Установка Xmenu

[◆ Wiki Xmenu](../WIKI.md) · [Читать целиком](Full-guide.md) · [README](../../README.md)

### Установить стабильный релиз

Подключись к Entware по SSH и выполни:

```sh
mkdir -p /opt/bin && curl -fL --retry 3 'https://github.com/rangerxxyy/Xmenu/releases/latest/download/xmenu-v1.0.sh' -o /tmp/xmenu.sh && sh -n /tmp/xmenu.sh && { [ ! -f /opt/bin/xmenu ] || cp -p /opt/bin/xmenu "/opt/bin/xmenu.bak.$(date +%Y%m%d-%H%M%S)"; } && cp /tmp/xmenu.sh /opt/bin/.xmenu-new && chmod 700 /opt/bin/.xmenu-new && mv -f /opt/bin/.xmenu-new /opt/bin/xmenu && xmenu
```

Далее для запуска достаточно:

```sh
xmenu
```

<details>
<summary><b>Другие способы загрузки: wget, GitHub Raw и зеркало</b></summary>

Через `wget`:

```sh
mkdir -p /opt/bin && wget -O /tmp/xmenu.sh 'https://github.com/rangerxxyy/Xmenu/releases/latest/download/xmenu-v1.0.sh' && sh -n /tmp/xmenu.sh && { [ ! -f /opt/bin/xmenu ] || cp -p /opt/bin/xmenu "/opt/bin/xmenu.bak.$(date +%Y%m%d-%H%M%S)"; } && cp /tmp/xmenu.sh /opt/bin/.xmenu-new && chmod 700 /opt/bin/.xmenu-new && mv -f /opt/bin/.xmenu-new /opt/bin/xmenu && xmenu
```

Текущая версия ветки `main`:

```sh
mkdir -p /opt/bin && curl -fL --retry 3 'https://raw.githubusercontent.com/rangerxxyy/Xmenu/main/xmenu-v1.0.sh' -o /tmp/xmenu.sh && sh -n /tmp/xmenu.sh && { [ ! -f /opt/bin/xmenu ] || cp -p /opt/bin/xmenu "/opt/bin/xmenu.bak.$(date +%Y%m%d-%H%M%S)"; } && cp /tmp/xmenu.sh /opt/bin/.xmenu-new && chmod 700 /opt/bin/.xmenu-new && mv -f /opt/bin/.xmenu-new /opt/bin/xmenu && xmenu
```

Зеркало GitHub:

```sh
mkdir -p /opt/bin && curl -fL --retry 3 'https://cdn.jsdelivr.net/gh/rangerxxyy/Xmenu@main/xmenu-v1.0.sh' -o /tmp/xmenu.sh && sh -n /tmp/xmenu.sh && { [ ! -f /opt/bin/xmenu ] || cp -p /opt/bin/xmenu "/opt/bin/xmenu.bak.$(date +%Y%m%d-%H%M%S)"; } && cp /tmp/xmenu.sh /opt/bin/.xmenu-new && chmod 700 /opt/bin/.xmenu-new && mv -f /opt/bin/.xmenu-new /opt/bin/xmenu && xmenu
```

Каждая команда загружает файл, проверяет синтаксис, сохраняет установленную копию и запускает Xmenu. Ветка `main` может содержать изменения, добавленные после последнего релиза.

Если загрузчиков нет:

```sh
opkg update && opkg install curl wget-ssl ca-certificates
```

</details>

<details>
<summary><b>Проверка файла по SHA-256</b></summary>

У релиза есть файл `SHA256SUMS`. Скачай его и скрипт в один каталог:

```sh
mkdir -p /tmp/xmenu-release && cd /tmp/xmenu-release && curl -fLO 'https://github.com/rangerxxyy/Xmenu/releases/latest/download/xmenu-v1.0.sh' && curl -fLO 'https://github.com/rangerxxyy/Xmenu/releases/latest/download/SHA256SUMS' && sha256sum -c SHA256SUMS && sh -n xmenu-v1.0.sh
```

Ожидаемый результат: `xmenu-v1.0.sh: OK`. Контрольная сумма проверяет соответствие файла релизному артефакту.

</details>

---

[Что умеет Xmenu →](Overview.md)
