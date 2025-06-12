import Fluent

struct CreateAlbum : AsyncMigration {

    func prepare(on database : any Database) async throws{
        try await database.schema("menu_items")
        .id()
        .field("name", .string, .required)
        .field("description", .custom("VARCHAR(500)"), .required)
        .field("price", .string, .required)
        .field("category", .string, .required)
        .field("imageURL", .string, .required)
        .field("created_at", .dateandtime, .required)
        .field("updated_at", .dateandtime, .required)
        .create()
    }

    func revert(on database: any Database) async throws{
        try await database.schema("menu_items").delete()
    }
}