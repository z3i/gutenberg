Mixins
------

You can define mixins just by defining a method which lazily takes
a variable and does something with it:

```ruby
Gutenberg.new do
  user 'somu'

  def name_caps
    user.upcase
  end

  def profile
    "https://github.com/#{user}"
  end
end
```

Then you can use it in your templates:

```
{{mixins_template}}
```

Full list of avaliable built-in mixins:

{{describe_mixins}}
