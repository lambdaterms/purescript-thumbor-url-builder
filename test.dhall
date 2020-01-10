let conf = ./spago.dhall

in conf // {
  dependencies = conf.dependencies # [ "debug", "test-unit" ]
}
