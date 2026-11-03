<div align="center">

# ◆ Xmenu

**Keenetic · Netcraze · Entware**

Установка компонентов, управление NFQWS и XKeen, настройка DNS и диагностика сети в одном меню.

[![Version](https://img.shields.io/badge/version-1.4.6-22d3ee?style=for-the-badge)](https://github.com/rangerxxyy/Xmenu/releases/latest) [![License](https://img.shields.io/badge/license-MIT-10b981?style=for-the-badge)](LICENSE)

[Скачать релиз](https://github.com/rangerxxyy/Xmenu/releases/latest) · [Сообщить об ошибке](https://github.com/rangerxxyy/Xmenu/issues)

</div>

## Установка

Нужен роутер с установленным Entware. Подключитесь к нему по SSH и выполните команду установки последнего стабильного релиза:

```sh
mkdir -p /opt/bin && curl -fL --retry 3 'https://github.com/rangerxxyy/Xmenu/releases/latest/download/xmenu-v1.0.sh' -o /tmp/xmenu.sh && sh -n /tmp/xmenu.sh && { [ ! -f /opt/bin/xmenu ] || cp -p /opt/bin/xmenu "/opt/bin/xmenu.bak.$(date +%Y%m%d-%H%M%S)"; } && cp /tmp/xmenu.sh /opt/bin/.xmenu-new && chmod 700 /opt/bin/.xmenu-new && mv -f /opt/bin/.xmenu-new /opt/bin/xmenu && xmenu
```

Команда проверяет синтаксис загруженного файла, сохраняет копию установленного Xmenu и запускает меню. Для последующих запусков:

```sh
xmenu
```

Обновление доступно по кнопке **U** в главном меню.

## Возможности

| Раздел | Что можно сделать |
| --- | --- |
| 📦 Установка компонентов | Установить или обновить XKeen, NFQWS v1/v2, Xray, Mihomo и веб-панели. |
| ⚙️ Управление XKeen | Выбрать канал Stable / Dev и обновить установленный XKeen. |
| 🧩 Стратегии NFQWS | Выбрать основной или дополнительный конфиг, загрузить blobs и списки, сохранить резервную копию. |
| 🌐 DNS | Посмотреть текущие DNS, добавить DoT/DoH, привязать домены к серверу и обновить hosts. |
| 🔎 Диагностика | Проверить сайт, DNS-серверы и доступность VPS: TCP, TLS, SNI, QUIC и обрыв передачи. |
| 🛠 Сервис | Настроить зеркала Entware, управлять копиями opkg.conf, обновить пакеты и применить сервисные исправления. |
| 🎛 Редактор меню | Нажать **E**, скрыть ненужные пункты и вернуть их позже. Нумерация пересчитывается автоматически. |

## Wiki

**[Открыть подробное руководство →](docs/WIKI.md)**

В Wiki собраны установка и обновление, описание всех пунктов меню, стратегии, DNS, диагностика, обслуживание, команды SSH, удаление и восстановление из резервных копий.

[Установка и альтернативные способы](docs/WIKI.md#установить-стабильный-релиз) · [Управление NFQWS](docs/WIKI.md#управление-nfqws2) · [DNS](docs/WIKI.md#настройки-dns-серверов) · [Диагностика](docs/WIKI.md#утилиты-и-диагностика) · [Удаление и резервные копии](docs/WIKI.md#удаление-и-резервные-копии)

Лицензия — [MIT](LICENSE). Xmenu предоставляется «как есть»; автор не несёт ответственности за последствия его использования. [Проекты и благодарности](docs/WIKI.md#используемые-проекты-и-благодарности).
