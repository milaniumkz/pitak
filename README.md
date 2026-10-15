# PITAK

Исходники приложения объявлений PITAK (`com.milanium.pitak`) и панели администратора.

## Структура

- `pitak/` — Flutter-приложение Android, iOS и Web; версия 1.0.3+2.
- `pitakadmin/` — отдельное Flutter-приложение администратора.
- `pitak/firebase/` — актуальные правила Firestore/Storage, индексы, Cloud Functions и тесты.
- `pitak/web/privacy.html`, `delete-account.html` — публичные страницы политики и удаления аккаунта.

## Работа в облачной среде

Установите Flutter 3.44.1 (Dart 3.12.1), Java 17, Android SDK 36, NDK 28.2.13676358 и Node.js 22. Машинные пути из `android/local.properties` создаются Flutter автоматически.

```sh
cd pitak
flutter pub get
flutter test
flutter build web --release
flutter build apk --debug
cd firebase/functions
npm ci
node --test user_data.test.js
```

Для панели администратора выполните `flutter pub get` и `flutter run -d chrome` из `pitakadmin/`. Доступ к административным операциям определяется серверными правилами; наличие исходников доступа не предоставляет.

## Релиз Android

Для подписанной сборки создайте локальный файл `pitak/android/key.properties` по шаблону `key.properties.example` и предоставьте оригинальный ключ загрузки через секретное хранилище среды. Не коммитьте ключ или пароли. Пути в Java Properties с не-ASCII символами требуют Unicode escaping; в облаке удобнее использовать ASCII-путь.

```sh
cd pitak
flutter build appbundle --release
```

Результат: `pitak/build/app/outputs/bundle/release/app-release.aab`. Перед загрузкой нового выпуска увеличьте versionCode в `pubspec.yaml`, если предыдущий уже использован в Google Play.

## Firebase

Клиентская Firebase-конфигурация включена в исходники: это публичные идентификаторы приложения, а не административные учётные данные. Проект: `pitak-8dfc0`. Для развёртывания нужен отдельно авторизованный аккаунт с доступом к проекту; секреты и рабочие токены в репозитории отсутствуют.

```sh
npm install -g firebase-tools
firebase login
cd pitak/firebase
firebase deploy --project pitak-8dfc0 --only firestore,storage,functions
```

Для Hosting сначала соберите Web, скопируйте содержимое `pitak/build/web/` в `pitak/firebase/hosting/`, затем выполните из `pitak/firebase/`:

```sh
firebase deploy --project pitak-8dfc0 --only hosting
```

`hosting/` — временный результат сборки, он не хранится в Git. При работе с правилами используйте Firebase Emulator и `rules.test.cjs` с `@firebase/rules-unit-testing` и `firebase`, установленными отдельно в тестовой среде.

## Состояние публикации

Сборка Android подписана локально; серверные исправления и Web опубликованы в Firebase. В Google Play сохранены изменения описания и декларации здоровья. Новый AAB ещё не загружен, выпуск ещё не отправлен на проверку. Требуется закончить декларации, доступ для проверяющих и скриншоты, затем отправить выпуск через Play Console.

## Что не публикуется

Ключи подписи, пароли, токены, аккаунты проверяющих, резервные копии и персональные данные Firebase, скриншоты закрытых консолей, исходные ZIP-архивы и результаты сборки остаются вне публичного репозитория. Данные пользователей находятся в Firebase и доступны только с соответствующими правами. Репозиторий содержит код и ресурсы проекта, но не копию рабочей базы данных.
