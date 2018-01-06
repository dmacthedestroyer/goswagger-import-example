# Go-Swagger import resolution example
Go-swagger seems to do some kind of magic import resolution after code generation, which is pretty sweet! For example:

```bash
make goodimport
less goswagger-generated/bar/foobar.go
```
```go
package bar

import (
	"fmt"

	"github.com/dmacthedestroyer/goswagger-import-example/goswagger-generated/foo"
)

func Bar() (string, error) {
	f, _ := foo.Foo()
	return fmt.Sprint(f, "bar"), nil
}
```

The template I used didn't specify any imports, and yet it resolved them automatically! I really like this feature, but it doesn't always work:

```bash
make badimport
less goswagger-generated/bar/foobar.go
```
```go
package bar

import "fmt"

func Bar() (string, error) {
	f, _ := foo.Foo()
	return fmt.Sprint(f, "bar"), nil
}
```
Notice it's missing the import for `foo` -- that's because in the swagger-config file I rendered the `bar.gotmpl` before the `foo.gotmpl` so it didn't resolve `foo.go`: it hadn't been generated yet.

In this trivial example, I can get around it by just ordering the templates correctly. But in other cases, that's not possible.

For instance, if I render a template in the `operations` section that should reference a file in the `operationGroups` section (or vice-versa), I can't control the ordering in which it gets generated so the fancy auto-resolution magic can't help me.
