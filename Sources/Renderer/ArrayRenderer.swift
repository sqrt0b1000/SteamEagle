public class ArrayRenderer: Renderer & PublicRenderer {

    public init() {}

    private var s: [String] = []

    public func render<R: Rendable>(_ c: R) -> String {
        self.render_rec(c.body)
        return printing()
    }

    internal func render_rec<R: Rendable>(_ c: R) {
        if let r = c as? PrimitiveRendable {
            r.render_primitive(r: self)
            return
        }
        self.render_rec(c.body)
    }

    internal func write(_ r: String) {
        s.append(r)
    }

    public func printing() -> String {
        let res = self.s.joined()
        self.s = []
        return res
    }
}
