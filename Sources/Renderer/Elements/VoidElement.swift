public struct VoidElement<A: RendableAttribute> {

    let tag: VoidTags
    public let attribute: A

    public init(tag: VoidTags, attribute: A) {
        self.tag = tag
        self.attribute = attribute
    }
}

extension VoidElement: Rendable {
    public var body: Never {
        fatalError("The body of a VoidElement component must never be called.")
    }
}

extension VoidElement: Element {}

extension VoidElement: PrimitiveRendable {
    func render_primitive(r: some R) {
        r.write("<")
        r.write("\(self.tag.rawValue)")
        r.render_rec(self.attribute)
        //r.write("<(self.tag.attribute)")
        r.write(">")
    }
}
