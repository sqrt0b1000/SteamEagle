// The protocol all primitive elements have to conform to to be renderable
protocol PrimitiveRendable {
    typealias R = Renderer & PublicRenderer
    func render_primitive(r: some R)
}
