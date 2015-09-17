import PathKit


public class HTMLReader : ReaderType {
  let fileExtensions: [String]

  public init(fileExtensions: [String]? = nil) {
    self.fileExtensions = fileExtensions ?? ["html"]
  }

  public func canRead(path: Path) -> Bool {
    if let `extension` = path.`extension` {
      return fileExtensions.contains(`extension`)
    }

    return false
  }

  public func read(path: Path) throws -> (Metadata, String) {
    return ([:], try path.read())
  }
}
