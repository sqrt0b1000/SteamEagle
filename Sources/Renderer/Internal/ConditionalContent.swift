public enum ConditionalContent<F: Rendable, S: Rendable> {
    case first(f: F)
    case second(s: S)
}

extension ConditionalContent: Rendable {
    public var body: Never {
        fatalError("The body of a ConditionalContent component must never be called.")
    }
}

extension ConditionalContent: PrimitiveRendable {
    func render_primitive(r: some PrimitiveRendable.R) {
        switch self {
        case .first(let f): r.render_rec(f)
        case .second(let s): r.render_rec(s)
        }
    }
}
