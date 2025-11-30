import NIOSSL
import Fluent
import FluentMySQLDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? "db",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? 3306,
        username: Environment.get("DATABASE_USERNAME") ?? "root",
        password: Environment.get("DATABASE_PASSWORD") ?? "root",
        database: Environment.get("DATABASE_NAME") ?? "blackmouth",
        tlsConfiguration: .forClient(certificateVerification:.none)
    ), as: .mysql)

    app.migrations.add(CreateFood())
    app.migrations.add(CreateTodo())
    app.migrations.add(CreateUser())

    // register routes
    try routes(app)
}
