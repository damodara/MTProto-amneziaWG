#!/bin/bash
# Скрипт для обновления Docker образов

echo "Остановка контейнеров..."
docker-compose down

echo "Обновление образов..."
docker-compose pull

echo "Запуск контейнеров..."
docker-compose up -d

echo "Проверка состояния контейнеров..."
docker-compose ps

echo "Обновление завершено!"