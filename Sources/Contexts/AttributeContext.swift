public protocol AttributeContext {}

// General Attribute Contexts

public protocol IdContext: AttributeContext {}
public protocol UnIdContext: AttributeContext {}

public protocol ClassContext: AttributeContext {}
public protocol UnClassContext: AttributeContext {}

public protocol StyleContext: AttributeContext {}
public protocol UnStyleContext: AttributeContext {}

public protocol LangContext: AttributeContext {}
public protocol UnLangContext: AttributeContext {}

public protocol TabIndexContext: AttributeContext {}
public protocol UnTabIndexContext: AttributeContext {}

public protocol HiddenContext: AttributeContext {}
public protocol UnHiddenContext: AttributeContext {}

// Element Spacific Attribute Contexts

// a, link, base
public protocol HrefContext: AttributeContext {}
public protocol UnHrefContext: AttributeContext {}

// img, script, iframe
public protocol SrcContext: AttributeContext {}
public protocol UnSrcContext: AttributeContext {}

// img, area
public protocol AltContext: AttributeContext {}
public protocol UnAltContext: AttributeContext {}

// a, form
public protocol TargetContext: AttributeContext {}
public protocol UnTargetContext: AttributeContext {}

// input, button, link
public protocol TypeContext: AttributeContext {}
public protocol UnTypeContext: AttributeContext {}

// input, option
public protocol ValueContext: AttributeContext {}
public protocol UnValueContext: AttributeContext {}

// input, textarea
public protocol PlaceholderContext: AttributeContext {}
public protocol UnPlaceholderContext: AttributeContext {}
