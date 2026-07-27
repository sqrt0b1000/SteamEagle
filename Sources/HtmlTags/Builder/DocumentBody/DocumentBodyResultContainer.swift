// Copyright (c) 2026 Robert Brune. All Rights Reserved.
import Contexts
import Renderer

public struct DocumentBodyResultContainer<each A>:
    DocumentBodyContext
        & Rendable
        & RendableAttribute
where
    repeat each A: DocumentBodyContext & Rendable
{
    let attr: (repeat each A)

    @RendableBuilder
    public var body: some Rendable {
        repeat each attr
    }
}
