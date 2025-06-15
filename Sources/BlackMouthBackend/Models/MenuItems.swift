import Fluent
import Vapor

final class MenuItems: Model, Content, @unchecked Sendable {
    static let schema = "menu_items"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "description")
    var description: String

    @Field(key: "price")
    var price: Double

    @Field(key: "category")
    var category: String

    @Field(key: "imageURL")
    var imageURL: String

    init() {}

    init(id: UUID? = nil, name: String, description: String, price: Double, category: String, imageURL: String) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.category = category
        self.imageURL = imageURL
    }
}
