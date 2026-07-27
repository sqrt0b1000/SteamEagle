import Contexts
import Renderer

public typealias Inline = InlineContext & Rendable
public typealias DocumentBody = DocumentBodyContext & Rendable

public struct H1<Body: Inline>: Rendable, DocumentBodyContext {
    let content: Body

    public init(@InlineContextBuilder body: () -> Body) {
        self.content = body()
    }

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .h1) {
            self.content
        }
    }
}

public struct H2<Body: Inline>: Rendable, DocumentBodyContext {
    let content: Body

    public init(@InlineContextBuilder body: () -> Body) {
        self.content = body()
    }

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .h2) {
            self.content
        }
    }
}

public struct H3<Body: Inline>: Rendable, DocumentBodyContext {
    let content: Body

    public init(@InlineContextBuilder body: () -> Body) {
        self.content = body()
    }

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .h3) {
            self.content
        }
    }
}

public struct Span<Body: Inline>: Rendable, DocumentBodyContext, InlineContext {
    let content: Body

    public init(@InlineContextBuilder body: () -> Body) {
        self.content = body()
    }

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .span) {
            self.content
        }
    }
}

public struct Anchor<Body: Rendable & Context>: Rendable, Context {
    let content: Body

    public init(@InlineContextBuilder body: () -> Body) where Body: InlineContext {
        self.content = body()
    }

    public init(@DocumentBodyContextBuilder body: () -> Body) where Body: DocumentBodyContext {
        self.content = body()
    }

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .span) {
            self.content
        }
    }
}

extension Anchor: DocumentBodyContext where Body: DocumentBodyContext {}
extension Anchor: InlineContext where Body: InlineContext {}

public struct Div<Body: DocumentBody>: Rendable, DocumentBodyContext {
    let content: Body

    public init(@DocumentBodyContextBuilder body: () -> Body) {
        self.content = body()
    }

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .div) {
            self.content
        }
    }
}

public struct Nav<Body: DocumentBody>: Rendable, DocumentBodyContext {
    let content: Body

    public init(@DocumentBodyContextBuilder body: () -> Body) {
        self.content = body()
    }

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .nav) {
            self.content
        }
    }
}

public struct Main<Body: DocumentBody>: Rendable, DocumentBodyContext {
    let content: Body

    public init(@DocumentBodyContextBuilder body: () -> Body) {
        self.content = body()
    }

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .main) {
            self.content
        }
    }
}

public struct Header<Body: DocumentBody>: Rendable, DocumentBodyContext {
    let content: Body

    public init(@DocumentBodyContextBuilder body: () -> Body) {
        self.content = body()
    }

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .header) {
            self.content
        }
    }
}

public struct Footer<Body: DocumentBody>: Rendable, DocumentBodyContext {
    let content: Body

    public init(@DocumentBodyContextBuilder body: () -> Body) {
        self.content = body()
    }

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .footer) {
            self.content
        }
    }
}

extension String: DocumentBodyContext, InlineContext {
}
