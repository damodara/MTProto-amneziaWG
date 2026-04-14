#!/bin/bash
# Скрипт для генерации хеша пароля для AmneziaWG

if [ $# -eq 0 ]; then
    echo "Использование: $0 <пароль>"
    echo "Пример: $0 mysecretpassword"
    exit 1
fi

PASSWORD="$1"

echo "Генерация хеша пароля..."

# Запуск контейнера для генерации хеша
HASH=$(docker run --rm ghcr.io/w0rng/amnezia-wg-easy:latest bash -c "npm run generate-hash -- --password '$PASSWORD'")

# Извлечение хеша из вывода
HASH_VALUE=$(echo "$HASH" | grep -o '$2b$[0-9]\{2\}\$.*)' | head -1)

if [ -n "$HASH_VALUE" ]; then
    echo "Успешно сгенерирован хеш пароля:"
    echo "$HASH_VALUE"
    echo "Вы можете добавить его в .env файл как PASSWORD_HASH=$HASH_VALUE"
else
    echo "Ошибка при генерации хеша пароля"
    echo "Полный вывод: $HASH"
    exit 1
fi