public protocol DocumentMetaDataContext: Rendable {
    associatedtype DocumentMetaDataContent: DocumentMetaDataContext

    var body: DocumentMetaDataContent { get }
}
