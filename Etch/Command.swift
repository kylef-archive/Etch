import Commander
import PathKit


extension Etch : CommandType {
  public func run(parser: ArgumentParser) throws {
    let group = Group()

    group.command("build")
    { [unowned self] in
      let source = Path.current
      let output = Path.current + "output"
      try! self.build(source, output: output)
    }

    try group.run(parser)
  }
}
