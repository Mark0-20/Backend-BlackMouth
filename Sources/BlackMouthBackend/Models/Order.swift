import Fluent
import Vapor

final class Order: Model, Content, @unchecked Sendable {
    static let schema = "orders"

    @ID(key: .id)
    var id: UUID?

    // Usuario dueño del pedido
    @Parent(key: "user_id")
    var user: User

    // Items del carrito/pedido
    @Field(key: "items")
    var items: [OrderItem]

    @Field(key: "status")
    var status: String  // "cart", "placed", "paid"

    init() {}

    init(id: UUID? = nil, userID: UUID, items: [OrderItem], status: String = "cart") {
        self.id = id
        self.$user.id = userID
        self.items = items
        self.status = status
    }
}

// Modelo que representa un item dentro del carrito
struct OrderItem: Content, Codable {
    let menuItemID: UUID
    let quantity: Int
}
