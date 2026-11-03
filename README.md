# ◆ Xmenu

Установка компонентов, управление XKeen и NFQWS, настройка DNS и диагностика сети в одном меню.

## Установка

Подключитесь к роутеру с установленным Entware по SSH и выполните одну команду:

```sh
mkdir -p /opt/bin && curl -fL --retry 3 https://github.com/rangerxxyy/Xmenu/releases/latest/download/xmenu-v1.0.sh -o /tmp/xmenu.sh && sh -n /tmp/xmenu.sh && { [ ! -f /opt/bin/xmenu ] || cp -p /opt/bin/xmenu "/opt/bin/xmenu.bak.$(date +%Y%m%d-%H%M%S)"; } && cp /tmp/xmenu.sh /opt/bin/.xmenu-new && chmod 700 /opt/bin/.xmenu-new && mv -f /opt/bin/.xmenu-new /opt/bin/xmenu && xmenu
```

Для следующего запуска введите `xmenu`.

## Возможности

- **Компоненты:** установка и обновление XKeen, NFQWS v1/v2, Xray, Mihomo и веб-панелей.
- **Стратегии:** выбор конфигураций NFQWS, загрузка blobs и списков, резервное копирование.
- **DNS:** просмотр текущих серверов, настройка DoT/DoH, привязка доменов и обновление hosts.
- **Диагностика:** проверка сайтов, DNS и доступности VPS, включая TCP, TLS, SNI и QUIC.
- **Обслуживание:** зеркала Entware, копии opkg.conf, обновление пакетов и сервисные исправления.
- **Настройка меню:** скрытие ненужных пунктов через **E** с автоматической нумерацией.

## Wiki

[**Открыть подробное руководство →**](https://github.com/rangerxxyy/Xmenu/blob/main/docs/WIKI.md)

Описание всех функций, настройка компонентов, диагностика, команды SSH, удаление и восстановление.

Если Xmenu полезен — поддержите проект звездой ⭐
