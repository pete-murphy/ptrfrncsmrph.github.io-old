module CodeBlock
  ( mkCodeBlock
  ) where

import Prelude
import Data.Nullable (Nullable)
import React.Basic.DOM (CSS)
import React.Basic.DOM as DOM
import React.Basic.Hooks (Component, JSX)
import React.Basic.Hooks as Hooks

-- | We're currently 'unsafeCoerce'-ing this in the only place where it is
-- | currently being used, so can probably get rid of the types here (use
-- | Foreign something or other?)
mkCodeBlock ::
  Component
    { children :: Array JSX
    , className :: String
    , extraClassName :: Nullable String
    , style :: CSS
    }
mkCodeBlock = do
  codeBlock <- codeBlock_
  Hooks.component "CodeBlock" \props ->
    pure (codeBlock props { style = DOM.css { color: "red" } })

foreign import codeBlock_ ::
  Component
    { children :: Array JSX
    , className :: String
    , extraClassName :: Nullable String
    , style :: CSS
    }
