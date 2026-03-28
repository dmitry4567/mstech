# MSTech — Flutter Subscription App

Тестовое задание: мобильное приложение на Flutter для управления подпиской пользователя.

---

## Архитектура

Проект построен по принципам **Clean Architecture** с разделением на три слоя:

```
Presentation  →  Domain  ←  Data
   (UI/BLoC)     (бизнес-логика)  (хранение данных)
```

### Слои

| Слой | Ответственность |
|------|----------------|
| **Domain** | Entities, Use Cases, абстрактные интерфейсы репозиториев |
| **Data** | Реализация репозиториев, DataSources, Models, Mappers |
| **Presentation** | Cubits (BLoC), Pages, Widgets, Navigation Guards |

### Стек технологий

| Область | Технология |
|---------|-----------|
| UI Framework | Flutter / Dart |
| State Management | `flutter_bloc` (Cubit) |
| Навигация | `auto_route` (code-gen маршруты + guard) |
| DI | `get_it` |
| Локальное хранение | `shared_preferences` |
| Обработка ошибок | `dartz` (Either монада) |
| Генерация кода | `build_runner` + `auto_route_generator` |

### Поток данных

```
SubscriptionPage
    └─ SubscriptionCubit.setSubscription()
         └─ SetSubscriptionUseCase
              └─ SubscriptionRepository (interface)
                   └─ SubscriptionRepositoryImpl
                        └─ SubscriptionLocalDataSourceImpl (SharedPreferences)
```

При запуске приложения `HasSubscriptionGuard` проверяет наличие сохранённой подписки через `CheckSubscriptionUseCase` и направляет пользователя либо на экран приветствия, либо сразу на экран с информацией о подписке.

---

## Структура проекта

```
lib/
├── main.dart                        # Точка входа
├── di.dart                          # Регистрация зависимостей (GetIt)
│
├── core/
│   ├── app/app.dart                 # Корневой виджет, тема
│   ├── constants/app_constants.dart # Ключи SharedPreferences
│   ├── errors/                      # Exceptions & Failures
│   ├── router/                      # AppRouter + HasSubscriptionGuard
│   ├── usecase/usecase.dart         # Базовый абстрактный UseCase
│   └── utils/typedefs.dart          # ResultFuture, ResultVoid и др.
│
└── features/
    ├── home/presentation/screens/   # WelcomePage, HomePage
    └── subscription/
        ├── domain/
        │   ├── entity/              # Subscription
        │   ├── repository/          # Абстрактный интерфейс
        │   └── usecase/             # CheckSubscription, SetSubscription
        ├── data/
        │   ├── datasource/          # SharedPreferences реализация
        │   ├── mapper/              # Entity ↔ Model
        │   ├── model/               # SubscriptionModel (JSON)
        │   └── repository/          # SubscriptionRepositoryImpl
        └── presentation/
            ├── cubit/               # SubscriptionCubit, InfoSubscriptionCubit
            └── pages/               # SubscriptionPage, InfoSubscriptionPage
```

---

## Запуск проекта

```bash
# Установка зависимостей
flutter pub get

# Генерация маршрутов (auto_route)
dart run build_runner build --delete-conflicting-outputs

# Запуск
flutter run
```

---

## Что улучшил бы при большем времени

1. **Удалённый источник данных** — добавить API-слой (Dio + Retrofit) для получения тарифных планов с сервера вместо хардкода `"month"` / `"year"` в кубите.

2. **Тесты** — написать unit-тесты для Use Cases и Cubits, а также widget-тесты для ключевых экранов.

3. **Локализация** — подключить `flutter_localizations` / `intl` для поддержки нескольких языков.

4. **Обработка сетевых ошибок** — реализовать `NoInternetFailure` (сейчас тип объявлен, но не используется) с retry-логикой.

5. **Flavors / Environments** — разделить окружения `dev` / `staging` / `prod` с раздельными конфигами.

6. **CI/CD** — настроить GitHub Actions: анализ кода (`flutter analyze`), тесты и сборку артефактов.

7. **Кэширование с TTL** — добавить время жизни для локально сохранённой подписки и механизм её обновления.
