### Harby

Harby is a parser for a simple Tcl-like grammar, ideal for handling arguments to one-line text commands, such as with IRC bots.

Harby recognizes various types of strings, numbers and regexes. You may supply a delegate object to handle commands.

### Syntax

Harby's syntax is simple—elements separated by whitespace. Here's an overview of Harby's argument types.

#### Strings

Strings come in three flavors: "naked," single-quoted, and double-quoted. Use "naked" strings for single words or short phrases (escape spaces with `\`). Use single quotes for strings with lots of whitespace or brackets that you don't want to turn into commands. Use double quotes for strings with commands inside of them.

```
foo bar\ baz      #=> ['foo', 'bar baz']
foo 'bar baz'     #=> ['foo', 'bar baz']
foo "bar [smile]" #=> ['foo', 'bar :)']
```

Single and double quotes can be escaped with `\'` and `\"`, respectively.

#### Numbers

Integers and floats are turned into their Ruby counterparts.

```
foo 123  #=> ['foo', 123]
foo 12.3 #=> ['foo', 12.3]
```

#### Regular expressions

Regular expressions are arguments contained within `/.../` with optional modifiers, and may contain whitespace.

```
foo /bar baz/     #=> ['foo', /bar baz/]
foo /b[aeu]r/ix   #=> ['foo', /b[aeu]r/ix]
```

#### Commands

Commands are wrapped in brackets (`[]`) and are constructed of a name and any number of optional arguments of any type. The command name or any of its arguments may even be other commands!

```
[smile]            #=> [':)']
[repeat 3 [smile]] #=> [':):):)']
[delete /aeiou\s/i 'I am a giant bucket'] #=> ['mgntbckt']
```

### Usage

Instantiate `Harby::Parser` and pass string input to its `#parse` method.

```ruby
require 'harby'
parser = Harby::Parser.new
parser.parse 'foo bar' #=> ['foo', 'bar']
```

To handle commands, you may pass a delegate object or block to `Harby::Parser.new` or assign it after instantiation. A delegate object is any object which responds to `#call(name, args)`.

```ruby
# Pass a block during instantiation
parser = Harby::Parser.new do |name, args|
  "#{name}(#{args.join(', ')})"
end

# Pass an object during instantiation
parser = Harby::Parser.new(->(name, args) { "#{name}(#{args.join(', ')})" })

# Or assign a delegate to an instance
parser.delegate = ->(name, args) { "#{name}(#{args.join(', ')})" }

parser.parse '[foo bar baz]' #=> ['foo(bar, baz)']
```

### Contributing

To run the specs, use the RSpec binstub.

```
$ bin/rspec
```

### License (MIT)

Copyright © 2015 Ross Paffett.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
