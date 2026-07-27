/// A context that contains information about the metadata of a document
public protocol DocumentMetaDataContext: Context {}

public protocol TitledMetaDataContext: DocumentMetaDataContext {}
public protocol UntitledMetaDataContext: DocumentMetaDataContext {}

public protocol BasedMetaDataContext: DocumentMetaDataContext {}
public protocol UnbasedMetaDataContext: DocumentMetaDataContext {}
