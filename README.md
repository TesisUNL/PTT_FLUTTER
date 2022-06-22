# PTT_MBS_APP

Proyecto Móvil Frontend del proyecto enfocado a la ruta turística de la Mancomunidad Bosque Seco

## Getting Started

### Requirements
- [Flutter](https://docs.flutter.dev/get-started/install) sdk version >=2.16.1 <3.0.0
- Un dispositivo móvil o un emulador instalado

### Cómo instalar y correr el proyecto:

1. Clonar el proyecto
```
git clone https://github.com/TesisUNL/PTT_FLUTTER.git
cd  PTT_FLUTTER
```

2. Instalar las dependencias
```
flutter pub get
```

3. Correr el proyecto con: 
```
flutter run lib/main.dart
```

Notes:

Se debe asegurar que esté conectado un dispositivo antes de correr el comando anterior. En caso de que se se inicie en el navegador, establecer en falso el inicio en web.

```
flutter config --no-enable-web
```

## Tests unitarios:

Para correr los tests unitarios se utiliza el comando: 

```
flutter test
```

## Dependencies

Para agregar dependencias, hacerlo en el archivo: [pubspec.yaml file](pubspec.yaml). 

Ejemplo:

```
dev_dependencies:
  flutter_test:
    sdk: flutter
    flutter_lints: ^1.0.0
```

Y para actualizar las dependias usar el comando: 
```
flutter pub get
```

