// Copyright (c) 2026 Robert Brune. All Rights Reserved.
import Contexts
import Renderer

public enum InlineConditionalContainer<F, S>:
   InlineContext 
        & Rendable
        & RendableAttribute
where
    F: InlineContext & Rendable,
    S: InlineContext & Rendable
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
