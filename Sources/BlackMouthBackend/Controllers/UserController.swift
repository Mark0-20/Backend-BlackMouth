import Vapor
import Fluent

struct UserController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let users = routes.grouped("users")

        users.post("register", use: register)
        users.post("login", use: login)
    }

    @Sendable
    func register(req: Request) async throws -> UserPublicDTO {
        let input = try req.content.decode(UserRegisterDTO.self)

        let hashed = try await req.password.async.hash(input.password)

        let user = User(
            username: input.username,
            email: input.email,
            passwordHash: hashed
        )

        try await user.save(on: req.db)

        return UserPublicDTO(
            id: user.id,
            username: user.username,
            email: user.email
        )
    }

    @Sendable
    func login(req: Request) async throws -> UserPublicDTO {
        let input = try req.content.decode(UserLoginDTO.self)

        guard let user = try await User.query(on: req.db)
            .filter(\.$email == input.email)
            .first()
        else {
            throw Abort(.notFound, reason: "User not found")
        }

        let isValid = try await req.password.async.verify(input.password, created: user.passwordHash)

        guard isValid else {
            throw Abort(.unauthorized, reason: "Invalid credentials")
        }

        return UserPublicDTO(
            id: user.id,
            username: user.username,
            email: user.email
        )
    }
}
