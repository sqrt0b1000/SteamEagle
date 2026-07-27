// Copyright (c) 2026 Robert Brune. All Rights Reserved.
import Contexts
import Renderer

public struct DocumentBodyArrayContainer<F>:
    DocumentBodyContext
        & Rendable
        & RendableAttribute
where
    F: DocumentBodyContext & Rendable
{
    let elements: [F]

    @RendableBuilder
    public var body: some Rendable {
        for e in elements {
            e
        }
    }
}
