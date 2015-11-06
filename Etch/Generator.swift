import Stencil

public protocol GeneratorType {
  func generate(writer: WriterType) throws
}


public protocol GeneratorBuilderType : GeneratorType {
  typealias Builder: GeneratorBuilder
  init(builder: Builder)
}

public protocol GeneratorBuilder {
  init()
}


class AnonymousGenerator : GeneratorType {
  let generator: WriterType throws -> ()

  init(_ generator: WriterType throws -> ()) {
    self.generator = generator
  }

  func generate(writer: WriterType) throws {
    try generator(writer)
  }
}


class AggregateGenerator : GeneratorType {
  let generators: [GeneratorType]

  init(generators: [GeneratorType]) {
    self.generators = generators
  }

  func generate(writer: WriterType) throws {
    try generators.forEach { try $0.generate(writer) }
  }
}
