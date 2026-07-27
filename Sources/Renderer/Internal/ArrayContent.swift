// Copyright (c) 2026 Robert Brune. All Rights Reserved.
import Contexts

public struct ArrayContent<C: Rendable> {
    let elements: [C]
}

extension ArrayContent: Rendable {
    public var body: Never {
        fatalError("The body of a ConditionalContent component must never be called.")
    }
}

extension ArrayContent: PrimitiveRendable {
    func render_primitive(r: some PrimitiveRendable.R) {
        elements.forEach { r.render_rec($0) }
    }
}
