module Index where

import Prelude

import Effect.Unsafe as Unsafe
import Layout as Layout
import React.Basic.DOM as DOM
import React.Basic.Hooks (Component)
import React.Basic.Hooks as Hooks

mkIndex :: Component Unit
mkIndex = do
  layout <- Layout.mkLayout
  Hooks.component "Index" \_ -> Hooks.do
    pure
      $ layout
          { children:
              [ DOM.h1_ [ DOM.text "Hello" ]
              ]
          , description: "Blog"
          , pageTitle: "Blog"
          }

-- | Interop
index = Unsafe.unsafePerformEffect mkIndex
