import Vapor
import Fluent

struct UserRegisterDTO: Content {
    var username: String
    var email: String
    var password: String
}

struct UserLoginDTO: Content {
    var email: String
    var password: String
}

struct UserPublicDTO: Content {
    var id: UUID?
    var username: String
    var email: String
}
