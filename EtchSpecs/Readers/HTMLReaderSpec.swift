import Spectre
import Etch
import PathKit


describe("HTMLReader") {
  $0.describe("canRead") {
    $0.it("can read HTML files") {
      let reader = HTMLReader()
      let path = Path("index.html")
      try expect(reader.canRead(path)).to.beTrue()
    }

    $0.it("cannot read other files") {
      let reader = HTMLReader()
      let path = Path("index.txt")
      try expect(reader.canRead(path)).to.beFalse()
    }

    $0.it("can read custom provided file extensions") {
      let reader = HTMLReader(fileExtensions: ["txt"])
      let path = Path("index.txt")
      try expect(reader.canRead(path)).to.beTrue()
    }
  }
}
