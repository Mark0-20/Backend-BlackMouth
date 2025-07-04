import Fluent

struct CreateFood : AsyncMigration {

    func prepare(on database : any Database) async throws{
        try await database.schema("menu_items")
        .id()
        .field("name", .string, .required)
        .field("description", .custom("VARCHAR(500)"), .required)
        .field("price", .double, .required)
        .field("category", .string, .required)
        .field("imageURL", .string)
        .field("created_at", .datetime)
        .field("updated_at", .datetime)
        .create()
    }

    func revert(on database: any Database) async throws{
        try await database.schema("menu_items").delete()
    }
}