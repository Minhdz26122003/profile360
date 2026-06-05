# Base Structure Reference

## Cap nhat 2026-06-04

Project nay da bat dau migrate theo huong `lib/app + lib/base + lib/features`.

Trang thai hien tai:

- da co `lib/app/bootstrap`, `lib/app/di`, `lib/app/router`
- da co `lib/base/utils`, `lib/base/widgets`
- da co `lib/features/customer_profile`, `lib/features/home`, `lib/features/cart`, `lib/features/shared`
- `customer_profile` va `home` da duoc tach `domain entities` ra khoi `presentation`
- `customer_profile` va `home` da co `use_case`
- mot phan file cu trong `lib/presentation/pages/...` van con ton tai de phuc vu giai doan chuyen tiep

Tai lieu ben duoi la target/base reference va van dung de tiep tuc refactor.

## Muc dich

Tai lieu nay ghi lai base structure hien tai cua project Flutter nay de co the dung lam khuon khi refactor hoac khoi tao project khac theo cung cach to chuc.

Base nay dang theo huong:

- `base` chua cac thanh phan dung chung.
- `feature module` tach rieng theo nghiep vu, hien tai la `crm` va `shop`.
- `presentation -> use_case -> repository -> api/service` la luong chinh.
- `GetIt` duoc dung cho dependency injection.
- `Bloc/Cubit` duoc dung cho state management.

## Tong quan cau truc

```text
lib/
|-- base/
|   |-- configs_app/
|   |-- domain/
|   |-- service/
|   |-- utils/
|   `-- widget/
|-- crm/
|   |-- di/
|   |-- domain/
|   |-- infrastructure/
|   |-- presentation/
|   `-- use_case/
|-- shop/
|   |-- di/
|   |-- domain/
|   |-- infrastructure/
|   |-- presentation/
|   `-- use_case/
|-- page/
|-- widgets/
|-- l10n/
|-- generated/
|-- main.dart
`-- routers.dart
```

## 1. Lop `base`

Day la phan dung chung va nen duoc tai su dung toi da giua cac project.

### `lib/base/configs_app`

Noi chua config toan app:

- `api_url.dart`: khai bao endpoint, base url.
- `app_color.dart`, `app_dimension.dart`, `app_style.dart`, `app_themes.dart`: he thong theme, spacing, style.
- `app_constant.dart`: constant dung chung.
- `app_enum.dart`: enum dung chung.
- `app_image.dart`: map asset dung chung.
- `app_di.dart`: composition root cua DI, goi dang ky module.

### `lib/base/domain`

- `use_case.dart`: dinh nghia interface chung cho use case.
- Quy uoc: moi use case trong feature nen follow `UseCase<Type, Params>`.

### `lib/base/service`

Noi chua tang giao tiep du lieu dung chung:

- `client/`
  - `rest_client.dart`: cau hinh `Dio`, timeout, header, token, logging.
  - `api_caller.dart`: wrapper cho `get/post/put/delete/upload`, show loading, xu ly loi.
  - `certificate_http.dart`: custom certificate/http override.
- `model/`
  - `base_response.dart`, `base_model.dart`: parse response chung.
  - cac entity base dung chung nhu `id_name_entities.dart`, `image_entities.dart`, `key_name_color_entities.dart`.
- `params/`
  - cac params dung chung nhu `id_params.dart`, `limit_offset_params.dart`.
- `fcm/`
  - Firebase messaging, notification.
- `event_bus_app.dart`
  - event dung chung toan app.

### `lib/base/utils`

Noi chua helper va extension:

- `app_preference.dart`: local storage, token, authorization, url.
- `common/`: function, navigator, widget helper.
- `extension/`: ext cho `String`, `List`, `BuildContext`, `Map`, `Text`.
- `mixin/`: mixin cho bloc va UI flow.
- `permission_app.dart`, `file_utils.dart`, `face_touch_id.dart`.

### `lib/base/widget`

Noi chua reusable widget va UI utility:

- input, dialog, bottom sheet, loading, refresher, responsive, image, html, webview, video...
- muc tieu la feature module khong phai viet lai UI co tinh chat dung chung.

## 2. Feature module chuan

Hai module hien tai `crm` va `shop` deu dang follow cung mot pattern lon:

```text
feature/
|-- di/
|-- domain/
|   |-- entities/
|   |-- model/
|   `-- event_bus/
|-- infrastructure/
|   |-- params/
|   `-- repositories/
|-- presentation/
|   |-- page(s)/
|   `-- widgets/
`-- use_case/
```

## 3. Vai tro tung layer trong feature

### `di/`

Noi dang ky dependency cua tung module.

Vi du:

- `lib/crm/di/di_module.dart`
- `lib/shop/di/shop_di.dart`

Tai day dang ky:

- repository interface -> repository impl
- use case -> inject repository tu `locator`

### `domain/`

Noi chua model mang tinh nghiep vu:

- `entities/`: object parse tu API va su dung trong app.
- `model/`: model nghiep vu hoac model tong hop cho UI.
- `event_bus/`: event trao doi giua cac man hinh trong cung domain.

### `infrastructure/params`

Noi chua request param theo tung API hoac use case.

Quy uoc:

- moi params nen co `toJson()`
- params nao co generate thi di kem file `*.g.dart`

### `infrastructure/repositories`

Noi tiep can API hoac datasource.

Thuong tach 2 file:

- `xxx_repositories.dart`: abstract contract
- `xxx_repositories_impl.dart`: implementation dung `ApiCaller`

Repository lam cac viec:

- goi endpoint
- truyen params
- parse `BaseResponse`
- map JSON thanh entity

### `use_case/`

Tang trung gian giua `presentation` va `repository`.

Use case thuong:

- nhan `params`
- goi repository
- khong chua UI logic

Vi du flow:

`ShopHomeCubit -> HomeListProductUseCase -> ShopHomeRepositories -> ShopHomeRepositoriesImpl -> ApiCaller -> RestClient`

### `presentation/`

Tang giao dien va state:

- `page/` hoac `pages/`: screen theo tinh nang
- `widgets/`: widget rieng cua feature
- `Cubit/Bloc`: state management cho page

Cubit thuong:

- lay dependency tu `locator`
- goi use case
- emit state
- xu ly UI flow nhu load more, navigate, event bus

## 4. Composition root cua app

### `lib/main.dart`

Day la diem khoi dong app:

- init Flutter binding
- init Firebase
- config image cache
- set orientation
- load `baseUrl` tu `AppPreferences`
- goi `setupLocator()`
- boot `MaterialApp`

### `lib/base/configs_app/app_di.dart`

Day la composition root cua DI:

- goi `ShopModule.registerModule()`
- goi `CRMModule.registerModule()`

Neu refactor project khac, day la noi de dang ky them module moi.

### `lib/routers.dart`

Dieu phoi route toan app:

- route chung cua app
- delegate sang `CRMNavigator` va `NavigatorShop`
- central navigation entry bang `AppNavigator.onGenerateRouteMain`

## 5. Quy uoc thuc te dang duoc dung trong repo nay

- API response duoc wrap trong `BaseResponse`.
- Entity parse JSON bang `fromJson`, mot so file generate `*.g.dart`.
- Param request tach rieng khoi Cubit/Page.
- Repository khong nen chua UI logic.
- Cubit/Page co the truy cap `eventBus`, navigator, toast khi can.
- `base/widget` va `widgets/` cung ton tai:
  - `base/widget`: reusable co tinh framework/base.
  - `widgets/`: widget dung chung muc app, nhung nghiep vu co the cao hon mot chut.

## 6. Cach tach 1 feature moi theo dung base nay

Khi tao module moi, nen follow thu tu:

1. Tao folder module:

```text
lib/<feature>/
|-- di/
|-- domain/
|   |-- entities/
|   |-- model/
|   `-- event_bus/
|-- infrastructure/
|   |-- params/
|   `-- repositories/
|-- presentation/
|   |-- pages/
|   `-- widgets/
`-- use_case/
```

2. Tao `params` cho request.
3. Tao `entities` de map response.
4. Tao `repository` abstract + impl.
5. Tao `use_case`.
6. Tao `Cubit/Bloc` + `Page`.
7. Dang ky DI trong `di/`.
8. Noi route vao router module va `lib/routers.dart` neu can.

## 7. Checklist refactor project khac theo base nay

Neu muon dua 1 project khac ve theo base nay, nen lam theo checklist sau:

### Buoc 1. Tach phan dung chung vao `base`

Chuyen cac thanh phan sau vao `base`:

- network client
- response parser
- local storage
- common widget
- extension/mixin
- constants/theme/assets
- use case base

### Buoc 2. Chia code theo feature module

Khong de code theo kieu:

- `screens/`
- `services/`
- `models/`

cho toan bo app trong cung 1 cho.

Nen tach thanh:

- `shop`
- `crm`
- `auth`
- `booking`
- `profile`

tuy theo domain that su cua project.

### Buoc 3. Di chuyen logic theo dung layer

- UI logic vao `presentation`
- business action vao `use_case`
- datasource/API vao `repository`
- request object vao `infrastructure/params`
- response object vao `domain/entities` hoac `base/service/model` neu la object dung chung

### Buoc 4. Gom DI va router

- moi module co file `di` rieng
- app co 1 `setupLocator()` tong
- app co 1 router tong, feature co router rieng neu can

### Buoc 5. Chuan hoa naming

Nen giu naming dong nhat:

- `xxx_use_case.dart`
- `xxx_repositories.dart`
- `xxx_repositories_impl.dart`
- `xxx_params.dart`
- `xxx_entities.dart`
- `xxx_cubit.dart`
- `xxx_page.dart`

## 8. Goi y khi ap dung cho project moi

Nen giu lai:

- `base/`
- pattern `use_case + repository + cubit`
- `GetIt`
- `Bloc/Cubit`
- `BaseResponse`
- routing tong + module routing

Co the thay doi theo project moi:

- ten module (`crm`, `shop`, ...)
- co can `event_bus` hay khong
- widget dung chung nao thuc su can dua vao `base`
- to chuc `page/` va `widgets/` chi tiet theo team

## 9. De xuat base structure muc tieu cho project khac

Neu muon dung repo nay lam chuan, co the huong den khung sau:

```text
lib/
|-- base/
|-- features/
|   |-- auth/
|   |-- home/
|   |-- booking/
|   `-- profile/
|-- app/
|   |-- di/
|   |-- router/
|   `-- bootstrap/
|-- l10n/
`-- main.dart
```

Khac biet so voi repo hien tai:

- repo hien tai dang de module ngay duoi `lib/` nhu `crm/`, `shop/`
- neu muon chuan hoa hon cho project moi, co the dua tat ca vao `lib/features/`

## 10. Ket luan

Base nay phu hop voi app Flutter co nhieu domain va nhieu API, can tach ro:

- phan dung chung
- phan nghiep vu
- phan giao dien
- phan truy cap du lieu

Neu dung lai cho project khac, muc tieu refactor khong phai copy y nguyen folder, ma la giu dung triet ly:

- shared code vao `base`
- code nghiep vu tach theo feature
- dependency duoc dang ky tap trung
- UI khong goi API truc tiep
- moi flow co layer ro rang va de mo rong
