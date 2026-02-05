// Copyright (c) 2026 Robert Brune. All Rights Reserved.
import Contexts

@resultBuilder
public struct DocumentMetaDataBuilder<T: DocumentMetaDataContext> {

    public static func buildBlock(_ components: T...)
        -> MetaData
    {
        MetaData.title("Test")
    }
}

public enum MetaData: DocumentMetaDataContext {
    case title(String)

    public var body: some DocumentMetaDataContext {
        MetaData.title("Test")
    }
}
