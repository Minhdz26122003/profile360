# DemoCart

Flutter app đang được refactor dần từ cấu trúc phẳng sang kiến trúc theo `app + base + features`.

## Cấu trúc hiện tại

```text
lib/
|-- app/
|   |-- bootstrap/
|   |-- di/
|   `-- router/
|-- base/
|   |-- configs_app/
|   |-- domain/
|   |-- services/
|   |-- utils/
|   `-- widgets/
|-- features/
|   |-- cart/
|   |-- customer_profile/
|   |-- home/
|   `-- shared/
`-- main.dart
```

## Trạng thái refactor

- `customer_profile`: đã có `domain`, `repository`, `use_case`, `presentation` entrypoint trong `features/`
- `home`: đã tách `domain`, `repository`, `use_case`, và entrypoint trong `features/`
- `cart`: đã tách `domain` và presentation entrypoint trong `features/`
- `app`: đã có `bootstrap`, `router`, `app_locator`
- `base`: đã có `utils` và `widgets` dùng chung đầu tiên

Một phần file cũ dưới `lib/presentation/pages/...` vẫn còn tồn tại như lớp chuyển tiếp trong quá trình dọn dẹp.

## Chạy dự án

```bash
flutter pub get
flutter run
```

## Tài liệu liên quan

- `docs/base_structure.md`
- `docs/plans/2026-06-04-project-structure-refactor-design.md`
- `docs/plans/2026-06-04-project-structure-refactor.md`
