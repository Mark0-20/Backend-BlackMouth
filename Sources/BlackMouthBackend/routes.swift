import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("menu_items") { req async throws -> [MenuItems] in
        let menuItem = try await MenuItems.query(on: req.db).all()
        return menuItem
    }

    app.get("menu_items", ":id") { req async throws -> MenuItems in
        guard let menuItem = try await MenuItems.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return menuItem
    }

    app.post("menu_items") {req async throws -> MenuItems in
        let menuItem = try req.content.decode(MenuItems.self)
        try await menuItem.save(on: req.db)
        return menuItem
    }

    app.put("menu_items", ":id"){req async throws -> MenuItems in
        guard let existingMenuItem = try await MenuItems.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound, reason: "Album not found")
        }
        let updatedMenuItem = try req.content.decode(MenuItems.self)
        existingMenuItem.name = updatedMenuItem.name
        existingMenuItem.description = updatedMenuItem.description
        existingMenuItem.price = updatedMenuItem.price
        existingMenuItem.category = updatedMenuItem.category
        existingMenuItem.imageURL = updatedMenuItem.imageURL
        try await existingMenuItem.update(on: req.db)
        return existingMenuItem
    }

    app.delete("menu_items", ":id"){ req async throws -> HTTPStatus in
        guard let existingMenuItem = try await MenuItems.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound, reason: "Album not found")
        }
        try await existingMenuItem.delete(on: req.db)
        return .noContent
    }

    try app.register(collection: TodoController())
}
