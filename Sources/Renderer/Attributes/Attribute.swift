public protocol RendableAttribute: Rendable {}

public struct AttributeCollection<each T: RendableAttribute> {
    let attributes: (repeat each T)
}

extension AttributeCollection: Rendable {
    @RendableBuilder
    public var body: some Rendable {
        repeat each attributes
    }
}

extension AttributeCollection: RendableAttribute {}

public enum Attribute {
    case cssClass(value: String)
    case href(value: String)
    case src(value: String)
    case target(value: String)
    case alt(value: String)

    var label: String {
        switch self {
        case .cssClass: "class"
        case .href: "href"
        case .src: "href"
        case .target: "target"
        case .alt: "alt"
        }
    }

    var value: String {
        switch self {
        case .cssClass(let v): v
        case .href(let v): v
        case .src(let v): v
        case .target(value: let v): v
        case .alt(value: let v): v
        }
    }
}

extension Attribute: Rendable {
    public var body: Never {
        fatalError("The body of a Content component must never be called.")
    }
}

extension Attribute: PrimitiveRendable {
    func render_primitive(r: some R) {
        r.write(" \(self.label)=\"\(self.value)\"")
    }
}

public struct VoidAttribute { public init() {} }

extension VoidAttribute: RendableAttribute {}

extension VoidAttribute: Rendable {
    public var body: Never {
        fatalError("The body of a Content component must never be called.")
    }
}

extension VoidAttribute: PrimitiveRendable {
    func render_primitive(r: some R) {}
}
