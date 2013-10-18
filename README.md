Gutenberg
=========

[![Gem version](https://badge.fury.io/rb/gutenberg.png)](http://rubygems.org/gems/gutenberg)
[![Dependency status](https://gemnasium.com/somu/gutenberg.png)](https://gemnasium.com/somu/gutenberg)
[![Code readability](https://codeclimate.com/github/somu/gutenberg.png)](https://codeclimate.com/github/somu/gutenberg)

**Gutenberg** compiles multiple templates into one README.

It generates static readme file from Mustache-powered plaintext files,
which link automatically. It has a built-in library of mixins module.
More on that later, now basic features and how to get it working.

It uses [semantic versioning](http://semver.org) and [Mustache](http://mustache.github.io),
both are cool and I appreciate their usage.

Everywhere
----------

You can use Gutenberg everywhere: your project doesn’t need to be written in Ruby.
Any language is OK, whether it is Python, PHP, or any other you prefer.

Get started
------------

Gutenberg is avaliable as a gem, working under Ruby 1.8...2.1:

    $ gem install gutenberg

Then you go to your project folder and say:

    $ gutenberg --init

It generated all required scaffolding: `book` folder, `context.json` and `structure.md`.
Now let's continue with configuring it for your project.

Context
-------

Context file is a file that is named `context` and has `.json`, `.yml` or `.rb` extension.

Contexts contain all variables you want to write only once: your repo name, your project name,
pieces of code, et cetera.

It is not required. You can delete it if you don’t need any variables.

Here are examples:

### `context.yml`

```yaml
user: somu
repo: sword
```

### `context.json`

```json
{
  "user": "somu",
  "repo": "sword"
}
```

### `context.rb`

Use `context.rb` if you need some advanced features, like putting your gem’s last version in a constant,  
putting your program’s help message inside of README, and so on. Get used to this DSL:

```ruby
Gutenberg.new do
  repo 'sword'
  user 'somu'
end
```

It has a built-in task for Rake, so you include it in your Rakefile:

```ruby
require 'gutenberg/task'
Gutenberg::Task.new
```

Then create book folder inside your project folder, and create
two files there: `structure.md` and `context.rb`.

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

{{usage}}

```

As you see, `books/introduction.md` can be loaded just using Mustache's
`{{introduction}}` variable. So treat `structure.md` as a bookcover
for your book pages (I won't ever call it `bookcover.md`, I swear).

Context is required for writing all the variables inside it. If you want to
include a mixin for Gutenberg, do it there. Your repo, your name — write there.
Everything you want to be stored in variable or be dynamic. Example:

```ruby

```

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

When you are ready, run it!

    $ rake readme
