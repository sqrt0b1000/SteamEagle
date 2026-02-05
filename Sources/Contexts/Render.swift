public enum Tag: String {
    case a = "a"
    case p = "p"
    case h1 = "h1"
    case h2 = "h2"
    case h3 = "h3"
    case h4 = "h4"
}

public enum Modifier: String {
    case cssClass = "class"
    case href = "href"
}

// Public Protocol
public protocol Rendable {
    //associatedtype R: Renderer
    associatedtype Body: Rendable

    var body: Body { get }
}

public protocol PublicRenderer {
    func render<R: Rendable>(_ c: R)
}

// Base Types

@resultBuilder
public struct ContentBuilder {
    public static func buildBlock<each T: Rendable>(
        _ components: repeat each T
    ) -> TupleContent<repeat each T> {
        return TupleContent(repeat each components)
    }
}

public enum EmptyContent: Rendable {
    case empty
    case test(String)
    public var body: Self { self }
}

public enum Content<T: Rendable>: Rendable {
    case tag(Tag, T)
    case tag_classe(tag: Tag, modifier: [Modifier: String], body: T)

    public typealias Body = Content
    public var body: Self { self }
}

public struct TupleContent<each T: Rendable>: Rendable {
    init(_ tuples: repeat each T) {
        self.tuples = (repeat each tuples)
    }

    private let tuples: (repeat each T)

    public var body: Self { self }
}

// Internal Protocol

protocol PrimitiveRenderer {
    typealias R = Renderer & PublicRenderer
    func render_primitive(r: some R)
}
extension EmptyContent: PrimitiveRenderer {
    func render_primitive(r: some Renderer) {
        switch self {
        case .test(let b): r.write(b)
        case .empty: return
        }
    }
}

extension Content: PrimitiveRenderer {
    func render_primitive(r: some R) {
        switch self {
        case .tag(let tag, let body):
            r.write("<\(tag.rawValue)>")
            r.render(body)
            r.write("</\(tag.rawValue)>")
        case .tag_classe(let tag, let modifier, let body):
            r.write("<\(tag.rawValue)")
            r.write(modifier.debugDescription)
            r.write(">")
            r.render(body)
            r.write("</\(tag.rawValue)>")
        }
    }
}

extension TupleContent: PrimitiveRenderer {
    func render_primitive(r: some R) {
        repeat r.render(each self.tuples)
    }
}

protocol Renderer {
    func write(_ r: String)
}

public class SimpleRenderer: Renderer & PublicRenderer {

    public init() {}

    private var s = ""

    public func render<R: Rendable>(_ c: R) {
        if let r = c as? PrimitiveRenderer {
            r.render_primitive(r: self)
            return
        }
        self.render(c.body)
    }

    internal func write(_ r: String) {
        s += r
    }

    public func printing() -> String {
        let s = self.s
        self.s = ""
        return s
    }
}

public class ArrayRenderer: Renderer & PublicRenderer {

    public init() {}

    private var s: [String] = []

    public func render<R: Rendable>(_ c: R) {
        if let r = c as? PrimitiveRenderer {
            r.render_primitive(r: self)
            return
        }
        self.render(c.body)
    }

    internal func internal_render<R: Rendable>(_ c: R) {
        if let r = c as? PrimitiveRenderer {
            r.render_primitive(r: self)
            return
        }
        self.internal_render(c.body)
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
