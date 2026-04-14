#!/bin/bash
# Скрипт для резервного копирования данных

# Директория для бэкапов
BACKUP_DIR="/backup"
DATE=$(date +"%Y%m%d_%H%M%S")

# Создаем директорию для бэкапов, если она не существует
mkdir -p "$BACKUP_DIR"

echo "Создание резервной копии данных..."

echo "1. Резервное копирование данных AmneziaWG..."
tar -czf "$BACKUP_DIR/amnezia-wg-easy_$DATE.tar.gz" -C ~ .amnezia-wg-easy 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Успешно: Данные AmneziaWG сохранены в $BACKUP_DIR/amnezia-wg-easy_$DATE.tar.gz"
else
    echo "Предупреждение: Не удалось создать резервную копию AmneziaWG (возможно, директория не существует)"
fi

echo "2. Резервное копирование данных MTProto..."
tar -czf "$BACKUP_DIR/mtproto-data_$DATE.tar.gz" ./mtproto-data 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Успешно: Данные MTProto сохранены в $BACKUP_DIR/mtproto-data_$DATE.tar.gz"
else
    echo "Ошибка: Не удалось создать резервную копию MTProto"
    exit 1
fi

echo "Резервное копирование завершено!"