# purescript-thumbor-url-builder

Bindings for `MCeddy / ThumborUrlBuilderTs` lib. Just because it is typed. WIP.


## `Thumbor.Url.Builder`

There you can find pure monoidal builder which can be used as follows:

```purescript
  let
    key = Key "yoursecretkey"
    server = Server "https://example.com"
    img = ImagePath "https://myapp.com/assets/img/image.jpeg"
  in
    B.build (Just key) server img
      $ B.format PNG
      <> B.smartCrop true
      <> B.resize 100 200
      <> B.crop { top: 10, left: 15, right: 150, bottom: 100 }
```

## `Thumbor.Url.Effect`

Low level effectful bindings. All mutate passed `Thumbor` object and nearly all result in `Effect Unit` so it is hard to chain and use them. It is done on purpose. Just use `Builder` :-P
