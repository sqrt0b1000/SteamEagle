// Copyright (c) 2026 Robert Brune. All Rights Reserved.
import Contexts
import Renderer

public struct InlineArrayContainer<F>:
   InlineContext 
        & Rendable
        & RendableAttribute
where
    F: InlineContext & Rendable
{
    let elements:[F]

    @RendableBuilder
    public var body: some Rendable {
        for e in elements {
            e
        }
    }
}
