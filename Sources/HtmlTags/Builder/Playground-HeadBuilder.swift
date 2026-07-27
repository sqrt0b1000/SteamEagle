/*
// - MARK: playgound
// This playground explores a different implementation of the head builder pattern,
// that flattens the created object.
// However, as it is not supported at the moment to work with type resolver
// under 'some DocumentMetaDataContext' it is here only for explorations purpose.

public struct UnrestrictedContainer<each B>: DocumentMetaDataContext, Rendable,
    UntitledMetaDataContext, UnrestrictedContainerData
where
    repeat each B: DocumentMetaDataContext & Rendable & UntitledMetaDataContext
{
    let b: (repeat each B)

    init(_ b: repeat each B) {
        self.b = (repeat each b)
    }

    @RendableBuilder
    public var body: some Rendable {
        RendableBuilder.buildBlock(repeat each b)
    }

    public var getV: (repeat each B) {
        (repeat each b)
    }
}

public protocol UnrestrictedContainerData {
    associatedtype B
    var getV: B { get }
}
extension MetaDataTag: UnrestrictedContainerData {
    public var getV: Self { self }
}

public struct TitledContainer<A, each B>: DocumentMetaDataContext, Rendable,
    TitledMetaDataContext
where
    A: DocumentMetaDataContext & Rendable & TitledMetaDataContext,
    repeat each B: DocumentMetaDataContext & Rendable & UntitledMetaDataContext
{
    init(_ a: A, _ b: repeat each B) {
        self.a = a
        self.b = (repeat each b)
    }

    let a: A
    let b: (repeat each B)

    @RendableBuilder
    public var body: some Rendable {
        a
        RendableBuilder.buildBlock(repeat each b)
    }
}

@resultBuilder
public struct HeadBuilder2 {

    public typealias Foundation = DocumentMetaDataContext & Rendable

    public typealias Unrestricted = Foundation
        & UntitledMetaDataContext & UnrestrictedContainerData

    public typealias Titled = Foundation
        & TitledMetaDataContext

    // - Start blocks

    // From container

    public static func buildPartialBlock<
        each U: Unrestricted
    >(
        first: UnrestrictedContainer<repeat each U>,
    ) -> UnrestrictedContainer<repeat each U> {
        print("Use container on \(type(of: first))")
        return first
    }
    public static func buildPartialBlock<
        UA: Titled,
        each UB: Unrestricted
    >(
        first: TitledContainer<UA, repeat each UB>,
    ) -> TitledContainer<UA, repeat each UB> {
        first
    }

    // From Base Value
    @_disfavoredOverload
    public static func buildPartialBlock<U: Unrestricted>(
        first: U
    ) -> UnrestrictedContainer<U> {
        print("Use nesed on \(type(of: first))")
        return UnrestrictedContainer(first)
    }
    public static func buildPartialBlock<T: Titled>(
        first: T,
    ) -> some Titled {
        first
    }
    public static func buildPartialBlock(
        first: String,
    ) -> some Titled {
        TitleMetaData(title: first)
    }

    // Accumulators

    // Merge unrestricted
    public static func buildPartialBlock<
        each UA: Unrestricted,
        each UB: Unrestricted
    >(
        accumulated: UnrestrictedContainer<repeat each UA>,
        next: UnrestrictedContainer<repeat each UB>
    ) -> UnrestrictedContainer<repeat each UA, repeat each UB> {
        print("Merge Container")
        return UnrestrictedContainer(repeat each accumulated.b, repeat each next.b)
    }
    public static func buildPartialBlock<
        each UA: Unrestricted,
        UB: Unrestricted
    >(
        accumulated: UnrestrictedContainer<repeat each UA>,
        next: UB
    ) -> UnrestrictedContainer<repeat each UA, UB.B> {
        print("Build Container prot \(type(of: next))")
        return UnrestrictedContainer(repeat each accumulated.b, next.getV)
    }
    @_disfavoredOverload
    public static func buildPartialBlock<
        each UA: Unrestricted,
        UB: Unrestricted
    >(
        accumulated: UnrestrictedContainer<repeat each UA>,
        next: UB
    ) -> UnrestrictedContainer<repeat each UA, UB> {
        print("Build tree \(type(of: next))")
        return UnrestrictedContainer(repeat each accumulated.b, next)
    }

    // Merge title
    public static func buildPartialBlock<
        UA: Titled,
        each UB: Unrestricted
    >(
        accumulated: UA, next: UnrestrictedContainer<repeat each UB>
    )
        -> TitledContainer<UA, repeat each UB>
    {
        TitledContainer(accumulated, repeat each next.b)
    }

    // Merge title
    @_disfavoredOverload
    public static func buildPartialBlock<
        UA: Titled,
        each UB: Unrestricted
    >(
        accumulated: UA, next: repeat each UB
    )
        -> TitledContainer<UA, repeat each UB>
    {
        TitledContainer(accumulated, repeat each next)
    }

    public static func buildPartialBlock<
        UA: Titled,
        each UB: Unrestricted
    >(
        accumulated: UnrestrictedContainer<repeat each UB>, next: UA
    )
        -> TitledContainer<UA, repeat each UB>
    {
        TitledContainer(next, repeat each accumulated.b)
    }

    public static func buildPartialBlock<
        each UB: Unrestricted
    >(
        accumulated: UnrestrictedContainer<repeat each UB>, next: String
    )
        -> TitledContainer<TitleMetaData, repeat each UB>
    {
        TitledContainer(TitleMetaData(title: next), repeat each accumulated.b)
    }
    public static func buildPartialBlock<
        UA: Titled,
        each UB: Unrestricted,
        each UC: Unrestricted,
    >(
        accumulated: TitledContainer<UA, repeat each UB>,
        next: UnrestrictedContainer<repeat each UC>
    )
        -> TitledContainer<UA, repeat each UB, repeat each UC>
    {
        TitledContainer(accumulated.a, repeat each accumulated.b, repeat each next.b)
    }

    @_disfavoredOverload
    public static func buildPartialBlock<
        UA: Titled,
        each UB: Unrestricted,
        each UC: Unrestricted,
    >(
        accumulated: TitledContainer<UA, repeat each UB>, next: repeat each UC
    )
        -> TitledContainer<UA, repeat each UB, repeat each UC>
    {
        TitledContainer(accumulated.a, repeat each accumulated.b, repeat each next)
    }

    // - Finalizer
    public static func buildFinalResult<T: Titled>(_ component: T) -> T { component }

    public static func buildFinalResult<T: Titled, each U: Unrestricted>(
        _ component: TitledContainer<T, repeat each U>
    ) -> TitledContainer<T, repeat each U> {
        component
    }

    public static func buildFinalResult<each U: Unrestricted>(
        _ component: UnrestrictedContainer<repeat each U>
    ) -> UnrestrictedContainer<repeat each U> {
        print("Fin: \(type(of: component))")
        return component
    }
}
// -

protocol Res {
    associatedtype T: BooleanMarker
}
struct ResT: Res {
    typealias T = True
}
struct ResF: Res {
    typealias T = False
}

protocol ResultResolver {
    associatedtype Output: Res
}

struct AtLeastOneResolver<T1, T2> {}

extension AtLeastOneResolver where T2 == True {
    typealias Output = True
}

extension AtLeastOneResolver where T1 == Undef {
    typealias Output = Undef
}

extension AtLeastOneResolver where T2 == Undef {
    typealias Output = Undef
}

struct Wrapper<C: BooleanMarker> {

}
func test<A: BooleanMarker, B: BooleanMarker>(a: A, b: B) -> Wrapper<
    AtLeastOneResolver<True, True>.Output
> {
    Wrapper()
}

// -

struct UnknownResolver<T1, T2>: ResultResolver {
    typealias Output = False
}

extension UnknownResolver where T1 == True, T2 == True {
    typealias Output = True
}

extension UnknownResolver where T1 == False, T2 == True {
    typealias Output = Undef
}

extension UnknownResolver where T1 == True, T2 == False {
    typealias Output = Undef
}

extension UnknownResolver where T1 == False, T2 == False {
    typealias Output = False
}
*/
