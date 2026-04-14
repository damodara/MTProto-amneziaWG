# MTProto-amneziaWG

## Настройка проекта

1. Скопируйте файл .env_example в .env:
```bash
cp .env_example .env
```

2. Убедитесь, что в .env указан правильный IP-адрес сервера в переменной WG_HOST.

3. Сгенерируйте хеш пароля для AmneziaWG:
```bash
./scripts/generate_password_hash.sh ваш_пароль
```
Замените `ваш_пароль` на реальный пароль (например, `mysecretpassword123`).

**Важно**:
- Скрипт должен запускаться из корневой директории проекта
- Если запустить скрипт без аргумента, он покажет сообщение об использовании и завершится
- Полученный хеш вставьте в .env в переменную PASSWORD_HASH

## Запуск

```bash
docker-compose up -d
```

## Получение ссылки для подключения

После запуска получите ссылку для подключения к MTProto:
```bash
docker logs mtproto-proxy 2>&1 | grep -E "tg://|Secret [0-9]+:"
```

## Веб-интерфейс AmneziaWG

Доступен по адресу: http://your_server:51821
Логин: admin
Пароль: тот, для которого вы сгенерировали хеш

## Управление проектом

### Обновление образов
```bash
./scripts/update_images.sh
```

### Резервное копирование данных
```bash
./scripts/backup_data.sh
```

### Мониторинг
Состояние контейнеров можно проверить командой:
```bash
docker-compose ps
```

Индивидуальные логи:
```bash
docker logs amnezia-wg-easy
docker logs mtproto-proxy
```

## Устранение неполадок

### Контейнеры не запускаются
- Проверьте корректность .env файла
- Убедитесь, что порты 443, 51820 и 51821 не заняты
- Проверьте наличие TUN/TAP устройства

### MTProto прокси не работает
- Проверьте, что SECRET в .env корректен
- Убедитесь, что порт 443 открыт в firewall
- Проверьте логи: `docker logs mtproto-proxy`

### AmneziaWG веб-интерфейс недоступен
- Проверьте, что WG_HOST в .env содержит правильный IP
- Убедитесь, что порт 51821 открыт в firewall
- Проверьте логи: `docker logs amnezia-wg-easy`

## FAQ

### Как изменить пароль администратора?
1. Сгенерируйте новый хеш пароля:
```bash
./scripts/generate_password_hash.sh новый_пароль
```
2. Обновите PASSWORD_HASH в .env файле
3. Перезапустите контейнеры:
```bash
docker-compose restart amnezia-wg-easy
```

**Примечание**: скрипт должен запускаться из корневой директории проекта и требует указания пароля в качестве аргумента.

### Где хранятся данные?
- AmneziaWG: ~/.amnezia-wg-easy
- MTProto: ./mtproto-data

## Версии образов
- AmneziaWG: ghcr.io/deckersu/amnezia-wg-easy:latest
- MTProto Proxy: telegrammessenger/proxy:latest

Рекомендуется периодически обновлять образы с помощью скрипта `./scripts/update_images.sh`.