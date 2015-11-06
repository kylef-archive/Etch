import PathKit
import Stencil


public typealias Metadata = [String: Any]


public protocol ReaderType {
  /// Returns whether the reader is capable of reading the particular file
  func canRead(path: Path) -> Bool

  func read(path: Path) throws -> (Metadata, String)
}


public class Reader : ReaderType {
  let source: Path
  let readers: [ReaderType]

  init(source: Path, readers: [ReaderType]) {
    self.source = source
    self.readers = readers
  }

  public func canRead(path: Path) -> Bool {
    return findReader(path) != nil
  }

  func findReader(path: Path) -> ReaderType? {
    for reader in readers {
      if reader.canRead(source + path) {
        return reader
      }
    }

    return nil
  }

  public func read(path: Path) throws -> (Metadata, String) {
    if let reader = findReader(source + path) {
      return try reader.read(source + path)
    }

    fatalError()  // TODO Throw an error
  }

  public func template(path: Path) throws -> Template {
    return try Template(path: source + path)
  }
}
