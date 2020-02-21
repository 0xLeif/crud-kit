import Vapor
import Fluent

protocol CrudControllerProtocol {
    associatedtype ModelT: Model & Content where ModelT.IDValue: LosslessStringConvertible
}

extension CrudControllerProtocol {
    internal static func indexAll(on database: Database) -> EventLoopFuture<[ModelT]> {
        return ModelT.query(on: database).all()
    }
    
    internal static func index(_ id: ModelT.IDValue?, on database: Database) -> EventLoopFuture<ModelT> {
        return ModelT.find(id, on: database).unwrap(or: Abort(.notFound))
    }
}
