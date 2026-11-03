# Настройки DNS-серверов

[◆ Wiki Xmenu](../WIKI.md) · [Читать целиком](Full-guide.md) · [README](../../README.md)

## Настройки DNS-серверов

**Путь: 11 → 6.** Показывает текущие DNS интернет-фильтров, общие DoT/DoH и внешние DNS без шифрования.

```text
DNS-серверы Keenetic

Интернет-фильтры
Отдельные DNS-серверы фильтров не настроены.

Общие DNS: DoT 0/8 · DoH 1/8
DoH: https://dns.google/dns-query
Запросы к этим серверам передаются с шифрованием.

1. Добавить DoT
2. Добавить DoH
3. Привязать домен к DNS (пресеты)
4. Удалить общие DNS-серверы
0. Назад
```

| Действие | Что изменяет |
| --- | --- |
| **Добавить DoT** | Добавляет TLS-сервер с адресом, портом и SNI. Доступны пресеты и ручной ввод `99`. |
| **Добавить DoH** | Добавляет HTTPS URI DNS-сервера. Поддерживает пресеты и ручной ввод `99`. |
| **Привязать домен** | Настраивает выбранный DNS для определённых доменов: Instagram, Twitch, Supercell и других либо для собственного домена. |
| **Удалить общие DNS-серверы** | Показывает общие upstream-серверы для выборочного удаления. Записи интернет-фильтров исключены из этого списка. |

В пресетах есть Яндекс, Cloudflare, Google, Quad9, CleanBrowsing, OpenDNS, AdGuard, ControlD, DNS.SB, DNS4EU, Alibaba, DNSPod, Xbox-DNS, Comss, Malw Link, NullsProxy, Geo Hide, AstraCat, Bezmezhau, DNS-AI, Mafioznik и Shecan. Можно выбрать несколько номеров через запятую и указать домен, для которого применяются серверы.

Счётчики `DoT N/8` и `DoH N/8` относятся к общим серверам секции System. Профили фильтров и политики в них не учитываются.

<details>
<summary><b>Пошагово: добавить DoH или DoT</b></summary>

**DoH из списка:** открой **12 → 6 → 2**, выбери номер провайдера, затем оставь поле домена пустым для общего сервера или укажи конкретный домен.

Пример диалога добавления общего DoH:

```text
Номера серверов через запятую: 3
Привязать серверы к домену (Enter — общие): [Enter]
Конфигурация Keenetic сохранена.
```

В данном списке номер 3 — Google DoH. Для нескольких серверов можно ввести, например, `2,3`; фактические настройки каждого пресета приведены в таблицах ниже.

**Ручной DoT:** открой **12 → 6 → 1**, выбери **99**, заполни область применения и данные сервера:

```text
Номера серверов через запятую: 99
Привязать серверы к домену (Enter — общие): [Enter]
Адрес DoT: dns.example.net
Порт (Enter — 853): [Enter]
SNI (Enter — без SNI): dns.example.net
```

`dns.example.net` здесь обозначает адрес твоего сервера. Для ручного DoH вводится полный HTTPS URI, например `https://dns.example.net/dns-query`.

После сохранения экран повторно читает настройки Keenetic. Общие серверы появляются в строках DoT/DoH. Чтобы удалить добавленный сервер, выбери **12 → 6 → 4** и его номер.

</details>

<details>
<summary><b>Все пресеты привязки доменов</b></summary>

| № | Сервер и протокол | Домены |
| --- | --- | --- |
| 1 | CleanBrowsing / DoT | `instagram.com` |
| 2 | CleanBrowsing / DoH | `instagram.com` |
| 3 | CleanBrowsing / DoT | `cdninstagram.com` |
| 4 | CleanBrowsing / DoH | `cdninstagram.com` |
| 5 | sw.ext.io / DoT | `rutor.is`, `rutor.info` |
| 6 | Malw Link / DoH | `ntc.party` |
| 7 | Xbox-DNS / DoT | `gql.twitch.tv`, `usher.ttvnw.net` |
| 8 | Xbox-DNS / DoH | `gql.twitch.tv`, `usher.ttvnw.net` |
| 9 | NullsProxy / DoT | Домены Supercell из списка ниже |
| 10 | NullsProxy / DoH | Те же домены Supercell |

```text
supercell.com
supercellid.com
brawlstarsgame.com
clashofclans.com
clashroyaleapp.com
```

Для собственного домена воспользуйся добавлением DoT или DoH и заполни поле **«Привязать серверы к домену»**. Привязка влияет на разрешение DNS-имени; она не создаёт VPN-маршрут для всего трафика сайта.

</details>

<details>
<summary><b>Как читать текущие DNS и интернет-фильтры</b></summary>

| Строка экрана | Значение |
| --- | --- |
| **Интернет-фильтры** | DNS, которые прошивка возвращает для фильтров, их профилей и назначений сетям или устройствам |
| **Отдельные DNS-серверы фильтров не настроены** | В полученном ответе нет отдельных upstream-серверов фильтров; это не утверждение об отсутствии любых других настроек фильтрации |
| **DNS без шифрования** | Внешние адреса из активных DNS-настроек, без внутренних loopback-адресов прокси |
| **Общие DNS: DoT N/8 · DoH N/8** | Число общих защищённых серверов, доступных в секции System |
| **DoH: https://…** | Фактический URI выбранного сервера, а не локальный порт прокси |

Xmenu читает текущие данные из `show dns-proxy` и назначения из `show running-config`. Для изменения общих upstream-серверов используются отдельные команды `dns-proxy tls upstream` и `dns-proxy https upstream`.

Настройки интернет-фильтра и добавленные вручную общие серверы имеют разные области действия. Удаление общего сервера из Xmenu не предназначено для очистки профилей интернет-фильтров.

</details>


<details>
<summary><b>Все пресеты DoT: номера, адреса и SNI</b></summary>

Номера соответствуют меню добавления DoT в версии 1.4.4. Ручной ввод — **99**.

| № | Провайдер | Адрес | SNI |
| --- | --- | --- | --- |
| 1 | Yandex | `77.88.8.8` | `common.dot.dns.yandex.net` |
| 2 | Cloudflare | `1.1.1.1` | `cloudflare-dns.com` |
| 3 | Google | `8.8.8.8` | `dns.google` |
| 4 | Quad9 | `9.9.9.9` | `dns.quad9.net` |
| 5 | CleanBrowsing | `185.228.168.9` | `security-filter-dns.cleanbrowsing.org` |
| 6 | OpenDNS | `208.67.222.222` | `dns.opendns.com` |
| 7 | AdGuard Default | `94.140.14.14` | `dns.adguard-dns.com` |
| 8 | AdGuard Family | `94.140.14.15` | `family.adguard-dns.com` |
| 9 | ControlD Free | `p0.freedns.controld.com` | `p0.freedns.controld.com` |
| 10 | DNS.SB | `185.222.222.222` | `dot.sb` |
| 11 | DNS4EU Protective | `protective.joindns4.eu` | `protective.joindns4.eu` |
| 12 | Alibaba DNS | `dns.alidns.com` | `dns.alidns.com` |
| 13 | DNSPod | `dot.pub` | `dot.pub` |
| 14 | Xbox-DNS | `xbox-dns.ru` | `xbox-dns.ru` |
| 15 | Comss DNS | `dns.comss.one` | `dns.comss.one` |
| 16 | Malw Link | `dns.malw.link` | `dns.malw.link` |
| 17 | NullsProxy | `dns.nullsproxy.com` | `dns.nullsproxy.com` |
| 18 | Geo Hide | `geohide.ru` | `geohide.ru` |
| 19 | AstraCat | `dns.astracat.network` | `dns.astracat.network` |
| 20 | Bezmezhau | `dns.bezmezhau.com` | `dns.bezmezhau.com` |
| 21 | DNS-AI | `dns.dns-ai.ru` | `dns.dns-ai.ru` |
| 22 | Mafioznik | `dns.mafioznik.xyz` | `dns.mafioznik.xyz` |
| 23 | Shecan Free | `free.shecan.ir` | `free.shecan.ir` |

</details>

<details>
<summary><b>Все пресеты DoH: номера и HTTPS URL</b></summary>

Номера соответствуют меню добавления DoH в версии 1.4.4. Ручной ввод — **99**.

| № | Провайдер | URI |
| --- | --- | --- |
| 1 | Yandex | `https://77.88.8.8/dns-query` |
| 2 | Cloudflare | `https://cloudflare-dns.com/dns-query` |
| 3 | Google | `https://dns.google/dns-query` |
| 4 | Quad9 | `https://dns.quad9.net/dns-query` |
| 5 | CleanBrowsing | `https://doh.cleanbrowsing.org/doh/security-filter/` |
| 6 | OpenDNS | `https://doh.opendns.com/dns-query` |
| 7 | AdGuard Default | `https://dns.adguard-dns.com/dns-query` |
| 8 | AdGuard Family | `https://family.adguard-dns.com/dns-query` |
| 9 | ControlD Free | `https://freedns.controld.com/p0` |
| 10 | DNS.SB | `https://doh.dns.sb/dns-query` |
| 11 | DNS4EU Protective | `https://protective.joindns4.eu/dns-query` |
| 12 | DNS4EU Unfiltered | `https://unfiltered.joindns4.eu/dns-query` |
| 13 | Alibaba DNS | `https://dns.alidns.com/dns-query` |
| 14 | DNSPod | `https://doh.pub/dns-query` |
| 15 | Xbox-DNS | `https://xbox-dns.ru/dns-query` |
| 16 | Comss DNS | `https://dns.comss.one/dns-query` |
| 17 | Malw Link | `https://dns.malw.link/dns-query` |
| 18 | NullsProxy | `https://dns.nullsproxy.com/dns-query` |
| 19 | Geo Hide | `https://dns.geohide.ru/dns-query` |
| 20 | AstraCat | `https://dns.astracat.network/dns-query` |
| 21 | Bezmezhau | `https://dns.bezmezhau.com/dns-query` |
| 22 | DNS-AI | `https://dns.dns-ai.ru/dns-query` |
| 23 | Mafioznik | `https://dns.mafioznik.xyz/dns-query` |
| 24 | Shecan Free | `https://free.shecan.ir/dns-query` |

</details>

---

[← Управление nfqws2](NFQWS.md) · [Утилиты и диагностика →](Diagnostics.md)
