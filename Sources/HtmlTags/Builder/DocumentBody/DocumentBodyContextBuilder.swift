// Copyright (c) 2026 Robert Brune. All Rights Reserved.
import Contexts
import Renderer

@resultBuilder
public struct DocumentBodyContextBuilder {

    public typealias Foundation = DocumentBodyContext & Rendable

    public static func buildBlock() -> DocumentBodyResultContainer<> {
        DocumentBodyResultContainer(attr: ())
    }

    public static func buildPartialBlock<U: Foundation>(
        first: U
    ) -> DocumentBodyResultContainer<U> {
        DocumentBodyResultContainer(attr: (first))
    }

    public static func buildExpression<each F: Foundation>(_ expression: repeat each F)
        -> DocumentBodyResultContainer<repeat each F>
    {
        DocumentBodyResultContainer(attr: (repeat each expression))
    }

    public static func buildExpression<F: Foundation>(_ expression: F?)
        -> DocumentBodyConditionalContainer<F, EmptyContainer>
    {
        if let component = expression {
            return DocumentBodyConditionalContainer.first(f: component)
        } else {
            return DocumentBodyConditionalContainer.second(s: EmptyContainer())
        }
    }

    public static func buildEither<R: Foundation, S: Foundation>(first component: R)
        -> DocumentBodyConditionalContainer<R, S>
    {
        DocumentBodyConditionalContainer.first(f: component)
    }

    public static func buildEither<R: Foundation, S: Foundation>(second component: S)
        -> DocumentBodyConditionalContainer<R, S>
    {
        DocumentBodyConditionalContainer.second(s: component)
    }

    public static func buildArray<F: Foundation>(_ components: [F])
        -> DocumentBodyArrayContainer<F>
    {
        DocumentBodyArrayContainer(elements: components)
    }

    public static func buildPartialBlock<each F, S: Foundation>(
        accumulated: DocumentBodyResultContainer<repeat each F>,
        next: S
    ) -> DocumentBodyResultContainer<repeat each F, S> {
        DocumentBodyResultContainer(attr: (repeat each accumulated.attr, next))
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
