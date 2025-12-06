import Fluent

struct CreateOrder: AsyncMigration {
    func prepare(on db: any Database) async throws {
        try await db.schema("orders")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("items", .json, .required)
            .field("status", .string, .required)
            .create()
    }

    func revert(on db: any Database) async throws {
        try await db.schema("orders").delete()
    }
}
