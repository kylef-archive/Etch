import Commander
import PathKit


func resolveTheme(theme: String) -> Path? {
  if !theme.isEmpty {
    return Path(theme)
  }

  return nil
}


extension Etch : CommandType {
  public func run(parser: ArgumentParser) throws {
    let group = Group()

    group.command("build",
      Option("output", "output", flag: "o", description: "Where to output the generated files."),
      Option("theme", "", flag: "t", description: "Path where to find the theme templates.")
    ){ [unowned self] output, theme in
      let source = Path.current
      try self.build(source, output: Path(output), theme: resolveTheme(theme))
    }

    try group.run(parser)
  }
}
