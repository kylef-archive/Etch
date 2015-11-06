import PathKit
import Stencil


public protocol WriterType {
  func write(filename: Path, content: String) throws
  func render(template: String, filename: Path, context: [String: Any]?) throws
}


class Writer : WriterType {
  let theme: Path
  let destination: Path
  let context: Context

  init(theme: Path, destination: Path, context: Context) {
    self.theme = theme
    self.destination = destination
    self.context = context
  }

  func write(filename: Path, content: String) throws {
    let output = destination + filename
    try (output + "..").mkpath()
    try output.write(content)
  }

  func render(template: String, filename: Path, context: [String: Any]? = nil) throws {
    let template = try Template(path: theme + template)

    let content: String = try self.context.push(context) {
      try template.render(self.context)
    }

    try write(filename, content: content)
  }
}
