module Layout where

import Prelude

import Next as Next
import React.Basic.DOM as Basic.DOM
import React.Basic.Hooks (Component, JSX)
import React.Basic.Hooks as Hooks
import React.DOM as DOM
import React.DOM.Props (Props)
import React.DOM.Props as Props
import Unsafe.Coerce as Coerce

-- @TODO: These seem to be necessary in order to avoid calling 'React.forwardRef' 
-- (which 'React.Basic.DOM.Internal.unsafeCreateDOMComponent' uses)
-- https://github.com/lumihq/purescript-react-basic-dom/blob/528627d4d44189add3bda6244807ca249910a9dd/src/React/Basic/DOM/Internal.js#L27
unsafeMeta :: Array Props -> JSX
unsafeMeta = DOM.meta >>> Coerce.unsafeCoerce

unsafeTitle' :: Array JSX -> JSX
unsafeTitle' = map Coerce.unsafeCoerce >>> DOM.title' >>> Coerce.unsafeCoerce

mkLayout :: Component { children :: Array JSX, pageTitle :: String, description :: String }
mkLayout = do
  head <- Next.mkHead
  Hooks.component "Layout" \props ->
    pure
      ( Hooks.fragment
          [ head
              { children:
                  [ unsafeMeta
                      [ Props.name "viewport"
                      , Props.content "width=device-width, initial-scale=1"
                      ]
                  , unsafeMeta
                      [ Props.charSet "utf-8"
                      ]
                  , unsafeMeta
                      [ Props.name "Description"
                      , Props.content props.description
                      ]
                  , unsafeTitle' [ Basic.DOM.text props.pageTitle ]
                  ]
              }
          , Basic.DOM.main_ props.children
          ]
      )
