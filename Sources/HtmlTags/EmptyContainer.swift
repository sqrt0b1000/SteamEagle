import Contexts
import Renderer

/// An empty container that renders nothing.
///
/// This class is used for the implementation of ``Optional`` in the result builder.
/// It can be used as a placeholder, that renders no content.
public struct EmptyContainer:
    DocumentBodyContext
        & InlineContext
        & Rendable
        & RendableAttribute
{
    @RendableBuilder
    public var body: some Rendable {}
}
