# ♻️ Проверка и восстановление

[◆ Wiki Xmenu](../WIKI.md) · [Читать целиком](Full-guide.md) · [README](../../README.md)

<details>
<summary><b>Полезные команды для проверки роутера</b></summary>

Сведения об устройстве и компонентах:

```sh
xmenu status
opkg print-architecture
df -h /opt
opkg list-installed
```

Состояние установленных служб:

```sh
/opt/etc/init.d/S51nfqws2 status
/opt/etc/init.d/S51nfqws status
/opt/etc/init.d/S52xmenu-discord-fullsession status
```

Запускай команду той службы, которая установлена на твоём устройстве. Проверка Discord Fix также доступна через **12 → 9 → 1**.

Текущий DNS и сохранённые статические привязки:

```sh
LD_LIBRARY_PATH=/lib:/usr/lib ndmc -c 'show dns-proxy'
LD_LIBRARY_PATH=/lib:/usr/lib ndmc -c 'show running-config' | grep '^ip host '
```

Маршруты и процессы:

```sh
ip route show default
ps | grep '[n]fqws'
```

</details>

<details>
<summary><b>Вернуть предыдущую конфигурацию NFQWS2</b></summary>

Найди копию, созданную перед неудачным изменением:

```sh
ls -lt /opt/etc/xmenu/backups/nfqws2.conf.*.bak
```

Скопируй нужный файл во временный путь, проверь его и сохрани текущую конфигурацию перед восстановлением:

```sh
cp /opt/etc/xmenu/backups/ИМЯ_КОПИИ.bak /tmp/nfqws2-restore.conf &&
sh -n /tmp/nfqws2-restore.conf &&
cp -p /opt/etc/nfqws2/nfqws2.conf "/opt/etc/nfqws2/nfqws2.conf.before-restore.$(date +%Y%m%d-%H%M%S).bak" &&
cp /tmp/nfqws2-restore.conf /opt/etc/nfqws2/.nfqws2-restore.conf &&
mv /opt/etc/nfqws2/.nfqws2-restore.conf /opt/etc/nfqws2/nfqws2.conf &&
/opt/etc/init.d/S51nfqws2 restart
```

Замени `ИМЯ_КОПИИ.bak` реальным именем из вывода `ls`. Для v1 используются его конфиг, каталог и init-скрипт. Восстановление `opkg.conf` удобнее выполнить через **22 → 4 → 2**.

</details>

<details>
<summary><b>Как проверить результат сервисных операций</b></summary>

| Операция | Где проверить |
| --- | --- |
| Смена зеркала | **22** — строка текущего репозитория; **22 → 5** — загрузка индексов |
| Создание копии opkg.conf | Выведенный путь копии и каталог `/opt/etc/xmenu/backups/` |
| Применение стратегии | **12 → 1** — активный вариант; `S51nfqws2 status` — состояние службы |
| Установка blobs | Итоговый счётчик файлов; повторная проверка через **12 → 3** |
| Добавление DNS | **12 → 6** — новый адрес DoT/URI DoH и изменившийся счётчик |
| Применение hosts | **12 → 10 → 99** — текущие записи `ip host` |
| Включение Discord Fix | **12 → 9 → 1** — конфиг, очередь, правила и доступность PPE |
| Dropbear Fix | Новое подключение к Entware SSH на порт `222`; журнал `/tmp/xmenu-dropbear-restart.log` |
| Обновление Xmenu | Версия в заголовке; при необходимости — сравнение файла с `SHA256SUMS` релиза |

</details>

---

[← Если что-то не работает](Troubleshooting.md) · [Пути и корневая структура Xmenu →](Structure.md)
