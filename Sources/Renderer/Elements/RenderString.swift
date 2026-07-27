extension String: Rendable {
    public var body: some Rendable {
        fatalError("The body of type Never must never be called.")
    }
}

extension String: PrimitiveRendable {
    func render_primitive(r: some Renderer) {
        r.write("This needs to be escaped properly!")
    }
}
