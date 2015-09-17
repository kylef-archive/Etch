import PathKit
import Stencil


public class Etch {
  let readers: [ReaderType]
  let processors: [ProcessorType]
  let generators: [GeneratorType]

  /// Instantiate Etch using the builder pattern
  public init(closure: EtchBuilder -> ()) {
    let builder = EtchBuilder()
    closure(builder)

    readers = builder.readers
    processors = builder.processors
    generators = builder.generators
  }

  public func build(source: Path, output: Path) throws {
    let reader = Reader(readers: readers)

    let processorContext = ProcessorContext()
    try process(reader, context: processorContext)

    let context = Context(dictionary: processorContext.context)
    let writer = Writer(theme: source + "theme", destination: output, context: context)

    let generator = AggregateGenerator(generators: processorContext.generators)
    try generator.generate(writer)
  }
}


extension Etch : ProcessorType {
  public func process(reader: Reader, context: ContextType) throws {
    generators.forEach(context.addGenerator)

    let processor = AggregateProcessor(processors: processors)
    try processor.process(reader, context: context)
  }
}
