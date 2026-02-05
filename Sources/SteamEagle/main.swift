// The Swift Programming Language
// https://docs.swift.org/swift-book
//

import Builder
import Contexts
import HtmlTags
import SwiftUI

let r = SimpleRenderer()

let a = Content.tag(Tag.a, EmptyContent.empty)

@ContentBuilder
var bi: some Rendable {
    a
    a
    a
    a
    a
    a
    a
    a
    a
    a
    a
    a
    a
    a
}

r.render(bi)
//r.render(P())

print(r.printing())
