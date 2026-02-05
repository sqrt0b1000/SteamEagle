import Contexts

public struct Head: DocumentMetaDataContext {

    public var body: some DocumentMetaDataContext {
        return Head()
    }

}
