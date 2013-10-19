Context
-------

Context file is a file named `context`. It has `.json`, `.yml` or `.rb` extension.

Contexts contain variables — everything you need to write only once: your repo name, your project name,
pieces of code, et cetera. So, use it for everything that you want to store or to be dynamic.

Context is not required. You can delete your `context.yml` if you don’t need any variables.

Here are examples:

#### `context.yml`

```yaml
{{yaml_example}}
```

#### `context.json`

```json
{{json_example}}
```

This one sets your repo to `"sword"` and user to `"somu"`. Those two variables are very
important in Gutenberg. They’re magical. After setting them, you can easily generate a header,
for example, using built-in {{mustache_header}} variable. This is what you’d get:

    Sword
    =====

It is a taste of what is called mixins. More on that later.


#### `context.rb`

Use `context.rb` if you need some advanced features, like putting your gem’s last version in a constant,  
putting your program’s help message inside of README, and so on. Get used to this DSL:

```ruby
{{ruby_example}}
```

In fact, it is equivalent to this:

```ruby
{{old_ruby_example}}
```

This README itself uses this `context.rb`:

```ruby
{{self_context}}
```
