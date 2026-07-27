public struct TupleContent<each T: Rendable> {
    init(_ tuples: repeat each T) {
        self.tuples = (repeat each tuples)
    }

    internal let tuples: (repeat each T)
}

extension TupleContent: Rendable {
    public var body: Never {
        fatalError("The body of a TupleContent component must never be called.")
    }
}

extension TupleContent: PrimitiveRendable {
    func render_primitive(r: some PrimitiveRendable.R) {
        repeat r.render_rec(each self.tuples)
    }
}
