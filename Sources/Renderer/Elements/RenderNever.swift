extension Never: Rendable {
    public var body: some Rendable {
        fatalError("The body of type Never must never be called.")
    }
}
