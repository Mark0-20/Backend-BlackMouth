# BlackMouthBackend
# 🍔 Backend BlackMouth

Tema del proyecto: Menú digital de hamburguesería – BlackMouth 🍔

Integrantes del equipo:

Marco Antonio Hernández Magaña

Sebastián Mendoza Sosa

Miguel Muñoz Hernández

Máximo Núñez Mireles

Daniel Solís Padierna

URL de la API desplegada:
🔗 https://urchin-app-p4aaq.ondigitalocean.app/menu_items

Backend para la aplicación **BlackMouth**, un sistema de menú digital para un restaurante de hamburguesas. Desarrollado con [Vapor](https://vapor.codes/), un framework backend en Swift.

## 🚀 Tecnologías utilizadas

- [Vapor 4](https://docs.vapor.codes/)
- Swift 5+
- PostgreSQL
- JWT (autenticación)
- Docker (opcional para despliegue local)

## 📁 Estructura del proyecto

```
Backend-BlackMouth/
├── Controllers/
│   └── MenuItemController.swift
├── Migrations/
│   └── CreateMenuItem.swift
├── Models/
│   └── MenuItem.swift
├── Routes/
│   └── routes.swift
├── Configurations/
│   └── configure.swift
├── main.swift
└── ...
```

## 🧾 Funcionalidad actual

### Endpoints disponibles

#### GET `/menu_items`
Retorna una lista de todos los elementos del menú.

**Ejemplo de respuesta:**
```json
[
  {
    "id": "627FA821-4A25-11F0-A440-EAB4945E15B5",
    "category": "Comida rápida",
    "name": "Hamburguesa Clásica",
    "imageURL": "https://example.com/img/hamburguesa.jpg"
  }
]
```


## ⚙️ Configuración local

### Requisitos

- Swift 5.9+
- PostgreSQL corriendo localmente o remotamente
- Vapor Toolbox (opcional, recomendado):  
  ```bash
  brew install vapor
  ```

### Instalación

1. Clona el repositorio:
   ```bash
   git clone https://github.com/Mark0-20/Backend-BlackMouth.git
   cd Backend-BlackMouth
   ```

2. Configura el archivo `.env` con tus credenciales de base de datos:
   ```env
   DATABASE_URL=postgres://usuario:contraseña@localhost:5432/blackmouthdb
   ```

3. Ejecuta las migraciones y corre el servidor:
   ```bash
   vapor run migrate
   vapor run serve
   ```

## 🧪 Pruebas

Puedes probar los endpoints con herramientas como [Postman](https://www.postman.com/) o [Insomnia](https://insomnia.rest/).

---

## 📦 Despliegue

El backend esta desplegado en servicio :

- [DigitalOcean App Platform](https://www.digitalocean.com/products/app-platform)

### See more

- [Vapor Website](https://vapor.codes)
- [Vapor Documentation](https://docs.vapor.codes)
- [Vapor GitHub](https://github.com/vapor)
- [Vapor Community](https://github.com/vapor-community)
