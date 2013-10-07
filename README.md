# Cuba LIbre

Super simple CLI parser inspired by [Cuba](http://cuba.is)'s simplicity.

_(When I say inspired, I mean I've copied lots of stuff and adapted it)_

**Completely under development**

## Example

```
require "cubalibre"

CubaLIbre.define do
  on "lorem" do
    puts "ipsum"
  end
  
  on default do
    abort "Usage: #{$0} lorem"
  end
end
```

See [`UNLICENSE`](UNLICENSE) for licensing options, but basically, you can do whatever you want with this library.