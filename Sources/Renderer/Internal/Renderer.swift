// Rendering content
protocol Renderer {

    /// Writing a string component to the output stream of the renderer
    func write(_ r: String)

    /// Calling the `Renderer` recursively on a `Rendable` component
    func render_rec(_ c: some Rendable)
}
