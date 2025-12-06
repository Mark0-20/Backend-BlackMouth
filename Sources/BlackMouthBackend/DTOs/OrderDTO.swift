import Vapor
import Fluent

// MARK: - ITEM DEL PEDIDO
struct OrderItemDTO: Content, Codable {
    var menuItemID: UUID
    var quantity: Int

    func toModel() -> OrderItem {
        return OrderItem(menuItemID: menuItemID, quantity: quantity)
    }

    static func fromModel(_ model: OrderItem) -> OrderItemDTO {
        return OrderItemDTO(menuItemID: model.menuItemID, quantity: model.quantity)
    }
}

// MARK: - DTO PARA CREAR PEDIDO
struct OrderCreateDTO: Content {
    var userID: UUID
    var items: [OrderItemDTO]
}

// MARK: - DTO PARA AGREGAR ITEM
struct AddItemDTO: Content {
    let menuItemID: UUID
    let quantity: Int
}

// MARK: - DTO PARA CAMBIAR STATUS
struct UpdateStatusDTO: Content {
    let status: String
}

// MARK: - DTO PARA RESPUESTA PÚBLICA
struct OrderPublicDTO: Content {
    var id: UUID?
    var userID: UUID
    var items: [OrderItemDTO]
    var status: String

    static func fromModel(_ order: Order) -> OrderPublicDTO {
        return OrderPublicDTO(
            id: order.id,
            userID: order.$user.id,
            items: order.items.map { OrderItemDTO.fromModel($0) },
            status: order.status
        )
    }
}
