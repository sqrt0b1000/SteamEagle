import Testing

@testable import Contexts
@testable import SteamEagle

@Test func example() async throws {

    let r = SimpleRenderer()

    let a = Content.tag(Tag.a, EmptyContent.empty)

    @ContentBuilder
    var bi: some Rendable {
        a
        a
    }

    print(r.printing())
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}
