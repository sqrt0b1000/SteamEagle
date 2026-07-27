import Contexts
import Renderer

public enum ConditionalContainer<F, S, Href, Target>:
    AttributeContext
        & Rendable
        & RendableAttribute
where
    F: AttributeContext & Rendable,
    S: AttributeContext & Rendable,
    Href: BooleanMarker,
    Target: BooleanMarker
{
    case first(f: F)
    case second(s: S)

    @RendableBuilder
    public var body: some Rendable {
        switch self {
        case .first(f: let b): b.body
        case .second(s: let b): b.body
        }
    }
}

extension ConditionalContainer: UnIdContext
where F: UnIdContext, S: UnIdContext {}

extension ConditionalContainer: UnClassContext
where F: UnClassContext, S: UnClassContext {}

extension ConditionalContainer: UnStyleContext
where F: UnStyleContext, S: UnStyleContext {}

extension ConditionalContainer: UnLangContext
where F: UnLangContext, S: UnLangContext {}

extension ConditionalContainer: UnTabIndexContext
where F: UnTabIndexContext, S: UnTabIndexContext {}

extension ConditionalContainer: UnHiddenContext
where F: UnHiddenContext, S: UnHiddenContext {}

// -

extension ConditionalContainer: UnHrefContext
where F: UnHrefContext, S: UnHrefContext {}

extension ConditionalContainer: UnSrcContext
where F: UnSrcContext, S: UnSrcContext {}

extension ConditionalContainer: UnAltContext
where F: UnAltContext, S: UnAltContext {}

extension ConditionalContainer: UnTargetContext
where F: UnTargetContext, S: UnTargetContext {}

extension ConditionalContainer: UnTypeContext
where F: UnTypeContext, S: UnTypeContext {}

extension ConditionalContainer: UnValueContext
where F: UnValueContext, S: UnValueContext {}

extension ConditionalContainer: UnPlaceholderContext
where F: UnPlaceholderContext, S: UnPlaceholderContext {}

// --

extension ConditionalContainer: IdContext
where F: IdContext, S: IdContext {}

extension ConditionalContainer: ClassContext
where F: ClassContext, S: ClassContext {}

extension ConditionalContainer: StyleContext
where F: StyleContext, S: StyleContext {}

extension ConditionalContainer: LangContext
where F: LangContext, S: LangContext {}

extension ConditionalContainer: TabIndexContext
where F: TabIndexContext, S: TabIndexContext {}

extension ConditionalContainer: HiddenContext
where F: HiddenContext, S: HiddenContext {}

// -

extension ConditionalContainer: HrefContext
where F: HrefContext, S: HrefContext {}

extension ConditionalContainer: SrcContext
where F: SrcContext, S: SrcContext {}

extension ConditionalContainer: AltContext
where F: AltContext, S: AltContext {}

extension ConditionalContainer: TargetContext
where F: TargetContext, S: TargetContext {}

extension ConditionalContainer: TypeContext
where F: TypeContext, S: TypeContext {}

extension ConditionalContainer: ValueContext
where F: ValueContext, S: ValueContext {}

extension ConditionalContainer: PlaceholderContext
where F: PlaceholderContext, S: PlaceholderContext {}
