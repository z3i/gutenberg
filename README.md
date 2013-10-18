Gutenberg
=========

[![Gem version](https://badge.fury.io/rb/gutenberg.png)](http://rubygems.org/gems/gutenberg)
[![Dependency status](https://gemnasium.com/somu/gutenberg.png)](https://gemnasium.com/somu/gutenberg)
[![Code readability](https://codeclimate.com/github/somu/gutenberg.png)](https://codeclimate.com/github/somu/gutenberg)

**Gutenberg** dynamically compiles multiple templates into one README.

It generates static readme file from Mustache-powered plaintext files,
which link automatically. It has a built-in library of mixins.
More on that later, now basic features and how to get it working.

It uses [semantic versioning](http://semver.org) and [Mustache](http://mustache.github.io),
both are cool and I appreciate their usage.

Everywhere
----------

You can use Gutenberg everywhere: your project doesn’t need to be written in Ruby.
Any language is OK, whether it is Python, PHP, or any other you prefer. If you’ve got
a Mac, you already have Ruby installed, so don’t even bother with it.

Get started
------------

Gutenberg is avaliable as a gem, working under Ruby 1.8...2.1:

    $ gem install gutenberg

Then you go to your project folder and say:

    $ gutenberg --init

It generates all the scaffolding: `book` folder, `context.yml` and `structure.md`.
Now let's continue with configuring it for your project.

Context
-------

Context file is a file that is named `context` and has `.json`, `.yml` or `.rb` extension.

Contexts contain all variables you want to write only once: your repo name, your project name,
pieces of code, et cetera. So, use it for everything that you want to store or to be dynamic.

Context is not required. You can delete your `context.yml` if you don’t need any variables.

Here are examples:

#### `context.yml`

```yaml
version: 4.0.0
user: rails
repo: rails

mvc: "[MVC](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)"
mit: "[MIT](http://www.opensource.org/licenses/MIT)"
```

#### `context.json`

```json
{
  "user": "somu",
  "repo": "sword",
  "contributors": "Josh Kauffman and Jackson Gariety"
}
```

#### `context.rb`

Use `context.rb` if you need some advanced features, like putting your gem’s last version in a constant,  
putting your program’s help message inside of README, and so on. Get used to this DSL:

```ruby
Gutenberg.new do
  repo 'sword'
  user 'somu'
end
```

In fact, it is equivalent to this:

```ruby
Gutenberg.new do
  def user; 'somu' end
  def repo; 'gutenberg' end
end
```

Gutenberg itself uses this `context.rb`:

```ruby
Gutenberg.new do
  repo 'gutenberg'
  user 'somu'

  self_structure { read 'book/structure.md'  }
  self_context   { read 'book/context.rb'    }
  
  options `./bin/gutenberg -h`.chomp

  mustache_introduction '`{{introduction}}`'
  mustache_header       '`{{head}}`'

  load 'examples/*'
end
```

Structure
---------

Structure is the only obligatory file to have in Gutenberg.  
Structure is a file called `structure` in `book` folder with any extension.

Structure is hooked up first and should be a barebone of your README.
For example, this repo README's structure looks like this:

```md
{{header}}

{{gem_version}}
{{gemnasium}}
{{code_climate}}

{{introduction}}

{{everywhere}}

{{installation}}

{{on_context}}

{{on_structure}}

{{usage}}

{{rake}}

{{workarounds}}
```

As you see, `books/introduction.md` can be loaded just using Mustache's
`{{introduction}}` variable. So treat `structure.md` like you’d treat
a bookcover for your book pages (I won't ever call it `bookcover`, I swear).

This one includes all built-in Gutenberg mixins and sets your repo to 'sword'
and user to 'somu'. Those two variables are very important in Gutenberg. After
setting them, you can easily generate a header, for example, using built-in
`{{head}}` variable, so in that case you'd receive something like this
for your `{{head}}`:

    Sword
    =====

After you've setup books folder, start creating pages inside it. They will be
automatically hooked and put into a variable with the same name: you can use
them in your `structure.md`.

To understand how to write all this template things, just look into this repo's
book folder. I love eating my own dog food. In fact, I cook it for myself.
Barkety bark.



Rake integration
----------------

Gutenberg easily integrates with Rake. You include this portion of code in your Rakefile:

```ruby
require 'gutenberg/task'
Gutenberg::Task.new
```

And you’re pretty ready to use them! It adds two tasks:

    rake readme      # Compile README.md
    rake see_readme  # See README.md

Workarounds for non-Ruby guys
-----------------------------

Since Gutenberg can into JSON and YAML, you may generate a context automatically
using your own code so your version, your help information and these things are up-to-date.

Remember that `gutenberg` executable has a lot of options so you can fine-tune it for your needs:

```
Usage: gutenberg [options]
    -c, --context <path>             Specify context file
    -d, --directory <path>           Specify documentation directory
    -f, --file <path>                Change resulting file name, README.md by default
    -h, --help                       Prints this message out
        --no-mixins                  Do not include mixins
    -p, --pattern <pattern>          Specify including file matching pattern
    -s, --structure <pattern>        Specify structure pattern
    -v, --version                    Prints Gutenberg version
```
