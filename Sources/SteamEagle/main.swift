// The Swift Programming Language
// https://docs.swift.org/swift-book
//

import Contexts
import HtmlTags
import Renderer

let r = SimpleRenderer()

@HeadBuilder
var simpleHead: some HeadBuilder.Unrestricted {
    MetaDataTag.link
}

@HeadBuilder
var titledHead: some HeadBuilder.TitledUnbased {
    "title"
}

@HeadBuilder
var merged: some HeadBuilder.Unrestricted {
    simpleHead
    simpleHead
}

@HeadBuilder
var tmerged_A: some HeadBuilder.TitledUnbased {
    titledHead
    simpleHead
    simpleHead
}

@HeadBuilder
var tmerged_B: some HeadBuilder.TitledUnbased {
    simpleHead
    titledHead
    simpleHead
}

@HeadBuilder
var tmerged_C: some HeadBuilder.TitledUnbased {
    simpleHead
    titledHead
    simpleHead
}

print(r.render(tmerged_C))

@HeadBuilder
var target_B: some HeadBuilder.UntitledBased {
    BaseMetaData {
        if true {
            Target._blank
            Href(ref: "Test")
        } else {
            Href(ref: "Magic")
        }
    }
}

@HeadBuilder
var target_href: some HeadBuilder.UntitledBased {
    Base.hrefTarget(href: Href(ref: "/index"), target: Target._blank).metaData
}

print(type(of: target_B))

print(r.render(target_B))
print(r.render(target_href))

/*
@HeadBuilder2
var l: UnrestrictedContainer<MetaDataTag> {
    MetaDataTag.link
}

@HeadBuilder2
//var ll: UnrestrictedContainer<MetaDataTag, MetaDataTag> {
var ll: some HeadBuilder2.Unrestricted {
    MetaDataTag.link
    MetaDataTag.link
}

print(" -> \(type(of: ll))")

@HeadBuilder2
//var lll: UnrestrictedContainer<MetaDataTag, MetaDataTag, MetaDataTag> {
var lll: some HeadBuilder2.Unrestricted {
    l
    ll
}

print(" -> \(type(of: lll))")

@HeadBuilder2
var xlll: some HeadBuilder2.Unrestricted {
    l
    (ll as! UnrestrictedContainer<MetaDataTag, MetaDataTag>)
}

print(" -> \(type(of: xlll))")

@HeadBuilder2
var t: some HeadBuilder2.Titled {
    "T"
}

@HeadBuilder2
var tlll: some HeadBuilder2.Titled {
    t
    lll
}

@HeadBuilder2
var lltlll: some HeadBuilder2.Titled {
    lll
    t
    lll
}

print(" -> \(type(of: lltlll))")

@HeadBuilder2
var llTlll: some HeadBuilder2.Titled {
    MetaDataTag.link
    MetaDataTag.link
    "T"
    MetaDataTag.link
    MetaDataTag.link
    MetaDataTag.link
}
print()
print(type(of: llTlll))

*/

@DocumentBodyContextBuilder
var emptyHeader: some DocumentBodyContextBuilder.Foundation {
    H1 {
    }
}

print(r.render(emptyHeader))

@DocumentBodyContextBuilder
var testHeader: some DocumentBodyContextBuilder.Foundation {
    H1 {
        for i in 0..<3 {
            Span { "TEST\(i)" }
        }
        if true {
            Span { "TEST" }

        } else {
            Span { "TEST" }
        }
    }
}

print(r.render(testHeader))

var testAnchor: some DocumentBodyContextBuilder.Foundation {
    Div {
        Anchor {
            Div {
                H1 {
                    Anchor {
                        Anchor {
                            "TEST"
                        }
                        "TEST"
                    }
                }
            }
        }
    }
}

print("Anchor: \(r.render(testAnchor))")

let opt = Optional.some(H1 { "MAGIC" })

var testDiv: some DocumentBodyContextBuilder.Foundation {
    Div {
        Div {
            "TEST"
        }
        Div {
            "TEST"
        }
        for x in 0..<5 {
            Div {
                H1 {
                    "Hello World! \(x)"
                }
            }
        }
        if Bool.random() {
            H1 {
                "X"
            }
        } else {
            H1 {
                "X"
            }
        }
        opt
    }
}

print("Div: \(r.render(testDiv))")
