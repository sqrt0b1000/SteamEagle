import Contexts
import Renderer

public enum CharSet {
    case utf8
}

public struct Href: Equatable, Hashable {
    let ref: String

    public init(ref: String) {
        self.ref = ref
    }
}

public enum Link: Equatable, Hashable {
    case stylesheet(ref: Href)
}

public enum Target: String {
    case _self = "_self"
    case _blank = "_blank"
    case _parent = "_parent"
    case _top = "_top"
}

public enum Base: Equatable, Hashable {
    case hrefTarget(href: Href, target: Target)
    case target(target: Target)
    case href(href: Href)
}

public enum MetaDataTag: Equatable, Hashable {
    case meta(charSet: CharSet)

    case link
    case script
    case style
}

extension MetaDataTag: Rendable {
    public var body: some Rendable {
        switch self {
        case .meta(charSet: _): ElementContainer(tag: .meta) { "Unsupported" }
        case .link: ElementContainer(tag: .link) { "Unsupported" }
        case .script: ElementContainer(tag: .script) { "Unsupported" }
        case .style: ElementContainer(tag: .style) { "Unsupported" }
        }
    }
}

extension MetaDataTag: DocumentMetaDataContext {}
extension MetaDataTag: UntitledMetaDataContext {}
extension MetaDataTag: UnbasedMetaDataContext {}

public struct Head<C: DocumentMetaDataContext & TitledMetaDataContext & Rendable>: Rendable {

    let context: C

    public init(
        @HeadBuilder context: () -> C
    ) {
        self.context = context()
    }

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .head) {
            self.context
        }
    }
}
