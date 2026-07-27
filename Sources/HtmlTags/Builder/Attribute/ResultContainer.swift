import Contexts
import Renderer

public struct ResultContainer<each A, Href, Target>:
    AttributeContext
        & Rendable
        & RendableAttribute
where
    repeat each A: AttributeContext & Rendable,
    Href: BooleanMarker,
    Target: BooleanMarker
{
    let attr: (repeat each A)

    @RendableBuilder
    public var body: some Rendable {
        repeat each attr
    }
}

extension ResultContainer: UnIdContext where repeat each A: UnIdContext {}
extension ResultContainer: UnClassContext where repeat each A: UnClassContext {}
extension ResultContainer: UnStyleContext where repeat each A: UnStyleContext {}
extension ResultContainer: UnLangContext where repeat each A: UnLangContext {}
extension ResultContainer: UnTabIndexContext where repeat each A: UnTabIndexContext {}
extension ResultContainer: UnHiddenContext where repeat each A: UnHiddenContext {}

extension ResultContainer: UnHrefContext where repeat each A: UnHrefContext {}
extension ResultContainer: UnSrcContext where repeat each A: UnSrcContext {}
extension ResultContainer: UnAltContext where repeat each A: UnAltContext {}
extension ResultContainer: UnTargetContext where repeat each A: UnTargetContext {}
extension ResultContainer: UnTypeContext where repeat each A: UnTypeContext {}
extension ResultContainer: UnValueContext where repeat each A: UnValueContext {}
extension ResultContainer: UnPlaceholderContext where repeat each A: UnPlaceholderContext {}

extension ResultContainer: HrefContext where Href == True {}
extension ResultContainer: TargetContext where Target == True {}
