/// A protocol for a component that can render rendable context to an given result type
public protocol PublicRenderer {
    associatedtype Result
    func render<R: Rendable>(_ c: R) -> Result
}
