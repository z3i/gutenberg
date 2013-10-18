Context
-------

Context file is a file that is named `context` and has `.json`, `.yml` or `.rb` extension.

Contexts contain all variables you want to write only once: your repo name, your project name,
pieces of code, et cetera.

It is not required. You can delete it if you don’t need any variables.

Here are examples:

### `context.yml`

```yaml
{{yaml_example}}
```

### `context.json`

```json
{{json_example}}
```

### `context.rb`

Use `context.rb` if you need some advanced features, like putting your gem’s last version in a constant,  
putting your program’s help message inside of README, and so on. Get used to this DSL:

```ruby
{{ruby_example}}
```
