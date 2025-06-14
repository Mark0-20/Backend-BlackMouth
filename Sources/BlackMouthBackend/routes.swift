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

    try app.register(collection: TodoController())
}
