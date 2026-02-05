public protocol DocumentBodyContext {
    associatedtype DocumentBodyContent: DocumentBodyContext

    var body: DocumentBodyContent { get }
}
