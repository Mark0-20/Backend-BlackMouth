import Vapor
import Fluent

struct OrderController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let orders = routes.grouped("orders")

        orders.post(use: createOrder)
        orders.get(":userID", use: getOrdersByUser)
        orders.put(":id", "addItem", use: addItem)
        orders.put(":id", "updateStatus", use: updateStatus)
    }

    // MARK: - Crear pedido
    func createOrder(req: Request) async throws -> OrderPublicDTO {
        let dto = try req.content.decode(OrderCreateDTO.self)

        let order = Order(
            userID: dto.userID,
            items: dto.items.map { $0.toModel() },
            status: "cart"
        )

        try await order.save(on: req.db)

        return OrderPublicDTO.fromModel(order)
    }

    // MARK: - Obtener pedidos por usuario
    func getOrdersByUser(req: Request) async throws -> [OrderPublicDTO] {
        guard let idString = req.parameters.get("userID"),
              let userID = UUID(uuidString: idString)
        else { throw Abort(.badRequest, reason: "Invalid userID.") }

        let orders = try await Order.query(on: req.db)
            .filter(\.$user.$id == userID)
            .all()

        return orders.map { OrderPublicDTO.fromModel($0) }
    }

    // MARK: - Agregar item a pedido
    func addItem(req: Request) async throws -> OrderPublicDTO {
        let dto = try req.content.decode(AddItemDTO.self)

        guard let id = req.parameters.get("id"),
              let orderID = UUID(uuidString: id),
              let order = try await Order.find(orderID, on: req.db)
        else { throw Abort(.notFound, reason: "Order not found.") }

        let newItem = OrderItem(menuItemID: dto.menuItemID, quantity: dto.quantity)

        order.items.append(newItem)
        try await order.update(on: req.db)

        return OrderPublicDTO.fromModel(order)
    }

    // MARK: - Actualizar estado del pedido
    func updateStatus(req: Request) async throws -> OrderPublicDTO {
        let dto = try req.content.decode(UpdateStatusDTO.self)

        guard let id = req.parameters.get("id"),
              let orderID = UUID(uuidString: id),
              let order = try await Order.find(orderID, on: req.db)
        else { throw Abort(.notFound, reason: "Order not found.") }

        order.status = dto.status
        try await order.update(on: req.db)

        return OrderPublicDTO.fromModel(order)
    }
}
