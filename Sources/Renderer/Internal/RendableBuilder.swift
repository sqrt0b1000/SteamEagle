@resultBuilder
public struct RendableBuilder {

    public static func buildBlock<each R: Rendable>(
        _ components: repeat each R
    ) -> TupleContent<repeat each R> {
        return TupleContent(repeat each components)
    }

    public static func buildBlock<each R: Rendable>(
        _ component: (repeat each R)
    ) -> TupleContent<repeat each R> {
        return TupleContent(repeat each component)
    }

    public static func buildExpression<each R: Rendable>(
        _ expression: (repeat each R)
    ) -> TupleContent<repeat each R> {
        return TupleContent(repeat each expression)
    }

    public static func buildExpression<each R: Rendable>(
        _ expression: repeat each R
    ) -> TupleContent<repeat each R> {
        return TupleContent(repeat each expression)
    }

    public static func buildEither<R: Rendable, S: Rendable>(first component: R)
        -> ConditionalContent<R, S>
    {
        ConditionalContent.first(f: component)
    }

    public static func buildEither<R: Rendable, S: Rendable>(second component: S)
        -> ConditionalContent<R, S>
    {
        ConditionalContent.second(s: component)
    }
    /*
        public static func buildPartialBlock<each R: Rendable>(first: R) -> Component {
        }
        public static func buildPartialBlock<each R: Rendable>(accumulated: Component, next: R)
            -> Component
        {

        }
        */

    public static func buildArray<R: Rendable>(_ components: [R])
        -> ArrayContent<R>
    {
        ArrayContent(elements: components)
    }

    public static func buildFinalResult<each R: Rendable>(
        _ component: TupleContent<repeat each R>
    ) -> TupleContent<repeat each R> { component }

    // Comment: those are needed to build the body expressions of the render tree's leafs, they must never be called
    internal static func buildBlock(_ expression: Never) -> Never {}
    internal static func buildExpression(_ expression: Never) -> Never {}
    internal static func buildFinalResult(_ component: Never) -> Never {}
}
