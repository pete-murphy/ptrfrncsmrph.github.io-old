module Index where

import Prelude
import Effect.Class.Console (log)
import Effect.Unsafe (unsafePerformEffect)
import Layout as Layout
import React.Basic.DOM as R
import React.Basic.Hooks (Component, component, useEffectOnce)
import React.Basic.Hooks as React
import Unsafe.Coerce (unsafeCoerce)

mkIndex :: Component Unit
mkIndex = do
  layout <- Layout.mkLayout
  component "Index" \_ -> React.do
    pure
      $ layout
          { children:
              [ R.h1_ [ R.text "He" ]
              ]
          , description: "Blog"
          , pageTitle: "Blog"
          }

-- | Interop
index = unsafePerformEffect mkIndex
