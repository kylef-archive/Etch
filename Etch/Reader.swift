import PathKit


public typealias Metadata = [String: Any]


public protocol ReaderType {
  /// Returns whether the reader is capable of reading the particular file
  func canRead(path: Path) -> Bool

  func read(path: Path) throws -> (Metadata, String)
}


public class Reader : ReaderType {
  let readers: [ReaderType]

  init(readers: [ReaderType]) {
    self.readers = readers
  }

  public func canRead(path: Path) -> Bool {
    return findReader(path) != nil
  }

  func findReader(path: Path) -> ReaderType? {
    for reader in readers {
      if reader.canRead(path) {
        return reader
      }
    }

    return nil
  }

  public func read(path: Path) throws -> (Metadata, String) {
    if let reader = findReader(path) {
      return try reader.read(path)
    }

    fatalError()  // TODO Throw an error
  }
}
