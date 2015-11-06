extension ContextType {
  /// Add a generator using a closure to the context
  public func addGenerator(generator: WriterType throws -> ()) {
    addGenerator(AnonymousGenerator(generator))
  }
}

public class EtchBuilder {
  var readers = [ReaderType]()
  var processors = [ProcessorType]()
  var generators = [GeneratorType]()

  // MARK: Readers

  /// Add a reader to Etch
  public func addReader(reader: ReaderType) {
    readers.append(reader)
  }

  // MARK: Processors

  /// Add a processor to Etch
  public func addProcessor(processor: ProcessorType) {
    processors.append(processor)
  }

  /// Add a processor using a closure to Etch
  public func addProcessor(processor: (ReaderType, ContextType) throws -> ()) {
    addProcessor(AnonymousProcessor(processor))
  }

  // MARK: Generators

  /// Add a generator to Etch
  public func addGenerator(generator: GeneratorType) {
    generators.append(generator)
  }

  /// Add a generator using a closure to Etch
  public func addGenerator(generator: WriterType throws -> ()) {
    addGenerator(AnonymousGenerator(generator))
  }

  /// Add a generator using the builder pattern
  public func addGenerator<T: GeneratorBuilderType>(generator: T.Type, closure: T.Builder -> ()) {
    let builder = T.Builder()
    closure(builder)
    addGenerator(T(builder: builder))
  }
}
