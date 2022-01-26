{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "my-project"
, dependencies =
  [ "arrays"
  , "colors"
  , "console"
  , "debug"
  , "effect"
  , "foldable-traversable"
  , "foreign"
  , "maybe"
  , "nullable"
  , "partial"
  , "prelude"
  , "psci-support"
  , "react"
  , "react-basic"
  , "react-basic-dom"
  , "react-basic-emotion"
  , "react-basic-hooks"
  , "typelevel-prelude"
  , "unsafe-coerce"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
