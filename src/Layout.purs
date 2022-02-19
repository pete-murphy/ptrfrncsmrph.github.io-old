module Layout where

import Prelude

import Color as Color
import Next as Next
import React.Basic as Basic
import React.Basic.DOM as Basic.DOM
import React.Basic.Emotion (Style)
import React.Basic.Emotion as E
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
          , Basic.element E.global { styles }
          , Basic.DOM.main_ props.children
          ]
      )

styles :: Style
styles =
  E.css
    { ":root":
        E.nested do
          E.css
            { fontFamily: E.str "-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Oxygen,Ubuntu,Cantarell,Fira Sans,Droid Sans,Helvetica Neue,sans-serif"
            , fontSize: E.str "17.5px"
            }
    , "code":
        E.nested do
          E.css
            { fontFamily: E.str "SF Mono,Fira Code,monospace"
            , backgroundColor: E.color (Color.hsla 20.0 1.0 0.7 0.2)
            , padding: E.str "0.15em 0.2em 0.05em"
            , borderRadius: E.em 0.3
            }
    , "main":
        E.nested do
          E.css
            { maxInlineSize: E.ch 80.0
            , margin: E.auto
            }
    , "p":
        E.nested do
          E.css
            { lineHeight: E.str "1.4"
            }
    , "a":
        E.nested do
          E.css
            { color: E.color Color.black
            }
    }
