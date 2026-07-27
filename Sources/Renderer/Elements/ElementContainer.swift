public struct ElementContainer<T: Rendable, A: RendableAttribute> {

    let tag: Tags
    let content: T
    public let attribute: A

    public init(tag: Tags, attribute: A = VoidAttribute(), @RendableBuilder content: () -> T) {
        self.tag = tag
        self.content = content()
        self.attribute = attribute
    }
}

extension ElementContainer: Rendable {
    public var body: Never {
        fatalError("The body of a Content component must never be called.")
    }
}

extension ElementContainer: Element {}

extension ElementContainer: PrimitiveRendable {
    func render_primitive(r: some PrimitiveRendable.R) {
        r.write("<\(self.tag.rawValue)")
        //r.write(modifier.debugDescription)
        r.write(">")
        r.render_rec(self.content)
        r.write("</\(self.tag.rawValue)>")
    }
}
