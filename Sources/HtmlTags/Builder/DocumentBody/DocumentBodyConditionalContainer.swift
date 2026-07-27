// Copyright (c) 2026 Robert Brune. All Rights Reserved.
import Contexts
import Renderer

public enum DocumentBodyConditionalContainer<F, S>:
    DocumentBodyContext
        & Rendable
        & RendableAttribute
where
    F: DocumentBodyContext & Rendable,
    S: DocumentBodyContext & Rendable
{
    case first(f: F)
    case second(s: S)

    @RendableBuilder
    public var body: some Rendable {
        switch self {
        case .first(f: let b): b.body
        case .second(s: let b): b.body
        }
    }
}
