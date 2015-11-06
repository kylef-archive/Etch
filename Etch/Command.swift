import Commander
import PathKit


extension Etch : CommandType {
  public func run(parser: ArgumentParser) throws {
    let group = Group()

    group.command("build",
      Option("output", "output", flag: "o", description: "Where to output the generated files.")
    ){ [unowned self] output in
      let source = Path.current
      try self.build(source, output: Path(output))
    }

    try group.run(parser)
  }
}
