// Public Protocol
public protocol Rendable {
    associatedtype Body: Rendable

    @RendableBuilder
    var body: Body { get }
}
