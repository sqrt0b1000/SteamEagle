// Copyright (c) 2026 Robert Brune. All Rights Reserved.
import Contexts
import Renderer

public struct InlineResultContainer<each A>:
   InlineContext
        & Rendable
        & RendableAttribute
where
    repeat each A: InlineContext & Rendable
{
    let attr: (repeat each A)

    @RendableBuilder
    public var body: some Rendable {
        repeat each attr
    }
}
