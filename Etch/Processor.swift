public protocol ContextType {
  func addGenerator(generator: GeneratorType)
  subscript(key: String) -> Any? { get set }
}

class ProcessorContext : ContextType {
  var context: [String: Any]
  var generators: [GeneratorType]

  init() {
    context = [:]
    generators = []
  }

  func addGenerator(generator: GeneratorType) {
    generators.append(generator)
  }

  subscript(key: String) -> Any? {
    get {
      return context[key]
    }

    set(value) {
      context[key] = value
    }
  }
}


public protocol ProcessorType {
  func process(reader: Reader, context: ContextType) throws
}


class AggregateProcessor : ProcessorType {
  let processors: [ProcessorType]

  init(processors: [ProcessorType]) {
    self.processors = processors
  }

  func process(reader: Reader, context: ContextType) throws {
    for processor in processors {
      try processor.process(reader, context: context)
    }
  }
}


class AnonymousProcessor : ProcessorType {
  let processor: (Reader, ContextType) throws -> ()

  init(_ processor: (Reader, ContextType) throws -> ()) {
    self.processor = processor
  }

  func process(reader: Reader, context: ContextType) throws {
    try processor(reader, context)
  }
}
