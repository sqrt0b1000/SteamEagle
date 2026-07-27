// Copyright (c) 2026 Robert Brune. All Rights Reserved.
import Contexts
import Renderer

@resultBuilder
public struct InlineContextBuilder {

    public typealias Foundation = InlineContext & Rendable

    public static func buildBlock() -> InlineResultContainer<> {
        InlineResultContainer(attr: ())
    }

    public static func buildPartialBlock<U: Foundation>(
        first: U
    ) -> InlineResultContainer<U> {
        InlineResultContainer(attr: (first))
    }

    public static func buildExpression<each F: Foundation>(_ expression: repeat each F)
        -> InlineResultContainer<repeat each F>
    {
        InlineResultContainer(attr: (repeat each expression))
    }

    public static func buildExpression<F: Foundation>(_ expression: F?)
        -> InlineConditionalContainer<F, EmptyContainer>
    {
        if let component = expression {
            return InlineConditionalContainer.first(f: component)
        } else {
            return InlineConditionalContainer.second(s: EmptyContainer())
        }
    }

    public static func buildEither<R: Foundation, S: Foundation>(first component: R)
        -> InlineConditionalContainer<R, S>
    {
        InlineConditionalContainer.first(f: component)
    }

    public static func buildEither<R: Foundation, S: Foundation>(second component: S)
        -> InlineConditionalContainer<R, S>
    {
        InlineConditionalContainer.second(s: component)
    }

    public static func buildArray<F: Foundation>(_ components: [F])
        -> InlineArrayContainer<F>
    {
        InlineArrayContainer(elements: components)
    }

    public static func buildPartialBlock<each F, S: Foundation>(
        accumulated: InlineResultContainer<repeat each F>,
        next: S
    ) -> InlineResultContainer<repeat each F, S> {
        InlineResultContainer(attr: (repeat each accumulated.attr, next))
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
