public class SimpleRenderer: Renderer & PublicRenderer {

    public init() {}

    private var s = ""
    public func render<R: Rendable>(_ c: R) -> String {
        render_rec(c)
        return printing()
    }

    public func render_rec<R: Rendable>(_ c: R) {
        if let r = c as? PrimitiveRendable {
            r.render_primitive(r: self)
            return
        }
        self.render_rec(c.body)
    }

    internal func write(_ r: String) {
        s += r
    }

    private func printing() -> String {
        let s = self.s
        self.s = ""
        return s
    }
}
