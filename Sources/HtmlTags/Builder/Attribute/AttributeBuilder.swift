import Contexts
import Renderer

//TODO: Create macro to generate the builder

@resultBuilder
public struct AttributeBuilder {

    public typealias Foundation = Rendable & RendableAttribute & AttributeContext

    public typealias UnknownContext = Foundation & UnSrcContext & UnAltContext

    public typealias NoContext = Foundation
        & UnHrefContext
        & UnTargetContext
        & UnSrcContext
        & UnAltContext

    public typealias H = Foundation
        & HrefContext
        & UnTargetContext
        & UnSrcContext
        & UnAltContext

    public typealias T = Foundation
        & UnHrefContext
        & TargetContext
        & UnSrcContext
        & UnAltContext

    public typealias HrefTarget = Foundation
        & HrefContext
        & TargetContext
        & UnSrcContext
        & UnAltContext

    // - Start blocks elements
    public static func buildPartialBlock<each F: NoContext>(
        first: repeat each F
    ) -> ResultContainer<repeat each F, False, False> {
        ResultContainer(attr: (repeat each first))
    }

    public static func buildPartialBlock<F: UnknownContext>(
        first: F
    ) -> ResultContainer<F, Undef, Undef> {
        ResultContainer(attr: first)
    }

    public static func buildPartialBlock(
        first: Target
    ) -> ResultContainer<TargetContainer, False, True> {
        ResultContainer(attr: TargetContainer(target: first))
    }

    public static func buildPartialBlock<F: T>(
        first: F
    ) -> ResultContainer<F, False, True> {
        ResultContainer(attr: first)
    }

    public static func buildPartialBlock(
        first: Href
    ) -> ResultContainer<HrefContainer, True, False> {
        ResultContainer(attr: HrefContainer(href: first))
    }

    public static func buildPartialBlock<F: H>(
        first: F
    ) -> ResultContainer<F, True, False> {
        ResultContainer(attr: first)
    }

    public static func buildPartialBlock<F: HrefTarget>(
        first: F
    ) -> ResultContainer<F, True, True> {
        ResultContainer(attr: first)
    }

    // - Build expressions

    public static func buildExpression<each F: NoContext>(_ expression: repeat each F)
        -> ResultContainer<repeat each F, False, False>
    {
        ResultContainer(attr: (repeat each expression))
    }

    public static func buildExpression(_ expression: Href)
        -> ResultContainer<HrefContainer, True, False>
    {
        ResultContainer(attr: (HrefContainer(href: expression)))
    }

    public static func buildExpression<F: H>(_ expression: F)
        -> ResultContainer<F, True, False>
    {
        ResultContainer(attr: (expression))
    }

    public static func buildExpression(_ expression: Target)
        -> ResultContainer<TargetContainer, False, True>
    {
        ResultContainer(attr: (TargetContainer(target: expression)))
    }

    public static func buildExpression<F: T>(_ expression: F)
        -> ResultContainer<F, False, True>
    {
        ResultContainer(attr: (expression))
    }

    public static func buildExpression<F: HrefTarget>(_ expression: F)
        -> ResultContainer<F, True, True>
    {
        ResultContainer(attr: (expression))
    }

    // - Build branches

    public static func buildEither<F: NoContext, S: NoContext>(first component: F)
        -> ConditionalContainer<F, S, False, False>
    {
        ConditionalContainer<F, S, False, False>.first(f: component)
    }

    public static func buildEither<F: NoContext, S: NoContext>(second component: S)
        -> ConditionalContainer<F, S, False, False>
    {
        ConditionalContainer<F, S, False, False>.second(s: component)
    }

    public static func buildEither<F: H, S: NoContext>(first component: F)
        -> ConditionalContainer<F, S, Undef, False>
    {
        ConditionalContainer<F, S, Undef, False>.first(f: component)
    }

    public static func buildEither<F: H, S: NoContext>(second component: S)
        -> ConditionalContainer<F, S, Undef, False>
    {
        ConditionalContainer<F, S, Undef, False>.second(s: component)
    }

    public static func buildEither<F: H, S: H>(first component: F)
        -> ConditionalContainer<F, S, True, False>
    {
        ConditionalContainer<F, S, True, False>.first(f: component)
    }

    public static func buildEither<F: H, S: H>(second component: S)
        -> ConditionalContainer<F, S, True, False>
    {
        ConditionalContainer<F, S, True, False>.second(s: component)
    }

    public static func buildEither<F: H, S: T>(first component: F)
        -> ConditionalContainer<F, S, True, True>
    {
        ConditionalContainer<F, S, True, True>.first(f: component)
    }

    public static func buildEither<F: H, S: T>(second component: S)
        -> ConditionalContainer<F, S, True, True>
    {
        ConditionalContainer<F, S, True, True>.second(s: component)
    }

    public static func buildEither<F: T, S: H>(first component: F)
        -> ConditionalContainer<F, S, True, True>
    {
        ConditionalContainer<F, S, True, True>.first(f: component)
    }

    public static func buildEither<F: T, S: H>(second component: S)
        -> ConditionalContainer<F, S, True, True>
    {
        ConditionalContainer<F, S, True, True>.second(s: component)
    }

    public static func buildEither<F: UnknownContext, S: UnknownContext>(first component: F)
        -> ConditionalContainer<F, S, Undef, Undef>
    {
        ConditionalContainer<F, S, Undef, Undef>.first(f: component)
    }

    public static func buildEither<F: UnknownContext, S: UnknownContext>(second component: S)
        -> ConditionalContainer<F, S, Undef, Undef>
    {
        ConditionalContainer<F, S, Undef, Undef>.second(s: component)
    }

    // - Build accumulating

    //NOTE: I would need extra build blocks for each context state,
    //      meaning for each combination of accumulator (3^n) and each combination of next (3^n)
    //      I would need the product of those states (6^n).
    //      For n == 2 I have (9)

    // base true, true
    public static func buildPartialBlock<each F, each S: NoContext>(
        accumulated: ResultContainer<repeat each F, True, True>,
        next: repeat each S
    ) -> ResultContainer<repeat each F, repeat each S, True, True> {
        ResultContainer(attr: (repeat each accumulated.attr, repeat each next))
    }

    // base false false
    public static func buildPartialBlock<each F, S: HrefTarget>(
        accumulated: ResultContainer<repeat each F, False, False>,
        next: S
    ) -> ResultContainer<repeat each F, S, True, True> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }
    public static func buildPartialBlock<each F, S: H>(
        accumulated: ResultContainer<repeat each F, False, False>,
        next: S
    ) -> ResultContainer<repeat each F, S, True, False> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }
    public static func buildPartialBlock<each F, S: T>(
        accumulated: ResultContainer<repeat each F, False, False>,
        next: S
    ) -> ResultContainer<repeat each F, S, False, True> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }
    public static func buildPartialBlock<each F, S: NoContext>(
        accumulated: ResultContainer<repeat each F, False, False>,
        next: S
    ) -> ResultContainer<repeat each F, S, False, False> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }

    // base true false
    public static func buildPartialBlock<each F, S: NoContext>(
        accumulated: ResultContainer<repeat each F, True, False>,
        next: S
    ) -> ResultContainer<repeat each F, S, True, False> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }
    public static func buildPartialBlock<each F, S: T>(
        accumulated: ResultContainer<repeat each F, True, False>,
        next: S
    ) -> ResultContainer<repeat each F, S, True, True> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }

    // base false true
    public static func buildPartialBlock<each F, S: NoContext>(
        accumulated: ResultContainer<repeat each F, False, True>,
        next: S
    ) -> ResultContainer<repeat each F, S, False, True> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }
    public static func buildPartialBlock<each F, S: H>(
        accumulated: ResultContainer<repeat each F, False, True>,
        next: S
    ) -> ResultContainer<repeat each F, S, True, True> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }

    // base undef false

    public static func buildPartialBlock<each F, S: NoContext>(
        accumulated: ResultContainer<repeat each F, Undef, False>,
        next: S
    ) -> ResultContainer<repeat each F, S, Undef, False> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }
    public static func buildPartialBlock<each F, S: T>(
        accumulated: ResultContainer<repeat each F, Undef, False>,
        next: S
    ) -> ResultContainer<repeat each F, S, Undef, True> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }

    // base undef true

    public static func buildPartialBlock<each F, S: NoContext>(
        accumulated: ResultContainer<repeat each F, Undef, True>,
        next: S
    ) -> ResultContainer<repeat each F, S, Undef, True> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }

    // base false undef

    public static func buildPartialBlock<each F, S: NoContext>(
        accumulated: ResultContainer<repeat each F, False, Undef>,
        next: S
    ) -> ResultContainer<repeat each F, S, False, Undef> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }
    public static func buildPartialBlock<each F, S: H>(
        accumulated: ResultContainer<repeat each F, False, Undef>,
        next: S
    ) -> ResultContainer<repeat each F, S, True, Undef> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }

    // base true undef

    public static func buildPartialBlock<each F, S: NoContext>(
        accumulated: ResultContainer<repeat each F, True, Undef>,
        next: S
    ) -> ResultContainer<repeat each F, S, True, Undef> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }

    // base Undef undef

    public static func buildPartialBlock<each F, S: NoContext>(
        accumulated: ResultContainer<repeat each F, Undef, Undef>,
        next: S
    ) -> ResultContainer<repeat each F, S, Undef, Undef> {
        ResultContainer(attr: (repeat each accumulated.attr, next))
    }

    // - Finalizer
    public static func buildFinalResult<F: Foundation>(
        _ component: F
    )
        -> F
    {
        component
    }
}

public struct HrefContainer: AttributeContext & Rendable & RendableAttribute {

    let href: Href

    @RendableBuilder
    public var body: some Rendable {
        Attribute.href(value: href.ref)
    }
}

extension HrefContainer: UnIdContext {}
extension HrefContainer: UnClassContext {}
extension HrefContainer: UnStyleContext {}
extension HrefContainer: UnLangContext {}
extension HrefContainer: UnTabIndexContext {}
extension HrefContainer: UnHiddenContext {}

extension HrefContainer: HrefContext {}
extension HrefContainer: UnSrcContext {}
extension HrefContainer: UnTargetContext {}
extension HrefContainer: UnAltContext {}

public struct TargetContainer: AttributeContext & Rendable & RendableAttribute {

    let target: Target

    @RendableBuilder
    public var body: some Rendable {
        Attribute.target(value: target.rawValue)
    }
}

extension TargetContainer: UnIdContext {}
extension TargetContainer: UnClassContext {}
extension TargetContainer: UnStyleContext {}
extension TargetContainer: UnLangContext {}
extension TargetContainer: UnTabIndexContext {}
extension TargetContainer: UnHiddenContext {}

extension TargetContainer: UnHrefContext {}
extension TargetContainer: UnSrcContext {}
extension TargetContainer: TargetContext {}
extension TargetContainer: UnAltContext {}

