// Copyright (c) 2026 Robert Brune. All Rights Reserved.
import Contexts
import Renderer

@resultBuilder
public struct HeadBuilder {

    public typealias Foundation = DocumentMetaDataContext & Rendable

    public typealias Unrestricted = Foundation
        & UntitledMetaDataContext
        & UnbasedMetaDataContext

    public typealias UntitledBased = Foundation
        & UntitledMetaDataContext
        & BasedMetaDataContext

    public typealias TitledUnbased = Foundation
        & TitledMetaDataContext
        & UnbasedMetaDataContext

    public typealias TitledBased = Foundation
        & TitledMetaDataContext
        & BasedMetaDataContext

    // - Start blocks

    public static func buildPartialBlock<U: Unrestricted>(
        first: U
    ) -> some Unrestricted {
        first
    }
    public static func buildPartialBlock(
        first: String,
    ) -> some TitledUnbased {
        TitleMetaData(title: first)
    }

    public static func buildPartialBlock<T: TitledUnbased>(
        first: T,
    ) -> some TitledUnbased {
        first
    }

    public static func buildPartialBlock<T: UntitledBased>(
        first: T,
    ) -> some UntitledBased {
        first
    }

    public static func buildPartialBlock<T: TitledBased>(
        first: T,
    ) -> some TitledBased {
        first
    }

    // Merge unrestricted
    public static func buildPartialBlock<UA: Unrestricted, UB: Unrestricted>(
        accumulated: UA, next: UB
    )
        -> some Unrestricted
    {
        Container(a: accumulated, b: next)
    }

    // Tiled defined, merge unrestricted
    public static func buildPartialBlock<UA: TitledUnbased, UB: Unrestricted>(
        accumulated: UB, next: UA
    )
        -> some TitledUnbased
    {
        Container(a: next, b: accumulated)
    }
    public static func buildPartialBlock<UA: TitledUnbased, UB: Unrestricted>(
        accumulated: UA, next: UB
    )
        -> some TitledUnbased
    {
        Container(a: accumulated, b: next)
    }

    // Base defined, merge unrestricted
    public static func buildPartialBlock<UA: UntitledBased, UB: Unrestricted>(
        accumulated: UA, next: UB
    )
        -> some UntitledBased
    {
        Container(a: accumulated, b: next)
    }
    public static func buildPartialBlock<UA: UntitledBased, UB: Unrestricted>(
        accumulated: UB, next: UA
    )
        -> some UntitledBased
    {
        Container(a: next, b: accumulated)
    }

    // Both defined / Merge unrestricted

    public static func buildPartialBlock<UA: TitledBased, UB: Unrestricted>(
        accumulated: UA, next: UB
    )
        -> some TitledBased
    {
        Container(a: accumulated, b: next)
    }

    public static func buildPartialBlock<UA: TitledBased, UB: Unrestricted>(
        accumulated: UB, next: UA
    )
        -> some TitledBased
    {
        Container(a: next, b: accumulated)
    }

    // - Finalizer
    public static func buildFinalResult<U: Unrestricted>(_ component: U) -> U { component }

    public static func buildFinalResult<B: UntitledBased>(_ component: B) -> B { component }
    public static func buildFinalResult<T: TitledUnbased>(_ component: T) -> T { component }

    public static func buildFinalResult<TB: TitledBased>(_ component: TB) -> TB { component }
}

extension TupleContent: Context where repeat each T: Context {}
extension TupleContent: DocumentMetaDataContext where repeat each T: DocumentMetaDataContext {}
extension TupleContent: UntitledMetaDataContext where repeat each T: UntitledMetaDataContext {}
extension TupleContent: UnbasedMetaDataContext where repeat each T: UnbasedMetaDataContext {}

public struct Container<A, B>: DocumentMetaDataContext & Rendable
where
    A: DocumentMetaDataContext & Rendable,
    B: DocumentMetaDataContext & Rendable
{
    let a: A
    let b: B

    @RendableBuilder
    public var body: some Rendable {
        a
        b
    }
}

extension Container: BasedMetaDataContext
where A: BasedMetaDataContext, B: UnbasedMetaDataContext {}

extension Container: UnbasedMetaDataContext
where A: UnbasedMetaDataContext, B: UnbasedMetaDataContext {}

extension Container: TitledMetaDataContext
where A: TitledMetaDataContext, B: UntitledMetaDataContext {}

extension Container: UntitledMetaDataContext
where A: UntitledMetaDataContext, B: UntitledMetaDataContext {}

// Container for title and base

public struct TitleMetaData: DocumentMetaDataContext & Rendable & TitledMetaDataContext
        & UnbasedMetaDataContext
{
    public let title: String

    @RendableBuilder
    public var body: some Rendable {
        ElementContainer(tag: .title) { self.title }
    }
}

public struct BaseMetaData<A: AttributeBuilder.UnknownContext>:
    DocumentMetaDataContext & Rendable & BasedMetaDataContext & UntitledMetaDataContext
{
    public init(@AttributeBuilder attributes: @escaping () -> A) {
        self.attributes = attributes
    }

    private let attributes: () -> A

    @RendableBuilder
    public var body: some Rendable {
        VoidElement(tag: .base, attribute: attributes())
    }

}

extension Base {
    public var metaData: BaseMetaData<some AttributeBuilder.UnknownContext> {
        BaseMetaData.init {
            switch self {
            case .href(let href): HrefContainer(href: href)  //href
            case .target(let target): TargetContainer(target: target)  //target
            case .hrefTarget(let href, let target): getHrefTarg(href: href, target: target)
            }
        }
    }
    @AttributeBuilder
    private func getHrefTarg(href: Href, target: Target) -> some AttributeBuilder.HrefTarget {
        HrefContainer(href: href)
        TargetContainer(target: target)
    }
}
