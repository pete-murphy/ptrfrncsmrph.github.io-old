module Page where

import Prelude

import CodeBlock as CodeBlock
import Data.Array ((:))
import Effect.Unsafe as Unsafe
import Foreign.Object as Object
import Foreign.Object (fromFoldable)
import Color as Color
import Layout as Layout
import MultiCodeBlock as MultiCodeBlock
import Next as Next
import React.Basic.Hooks (Component, JSX, (/\))
import React.Basic.Hooks as Hooks
import React.Basic.DOM as DOM
import Unsafe.Coerce as Coerce
import React (ReactElement)
import React.Basic as Basic
import React.Basic.Emotion (Style)
import React.Basic.Emotion as E

type Props =
  { children :: Array JSX
  , meta ::
      { title :: String
      , description :: String
      , date :: String
      }
  }

mkPage :: Component Props
mkPage = do
  layout <- Layout.mkLayout
  mdxProvider <- Next.mkMDXProvider
  multiCodeBlock <- MultiCodeBlock.mkMultiCodeBlock
  codeBlock <- CodeBlock.mkCodeBlock

  Hooks.component "Page" \props -> Hooks.do
    pure
      ( mdxProvider
          { children:
              [ Basic.element E.global { styles }
              , layout
                  { children: DOM.h1_ [ DOM.text props.meta.title ] : props.children
                  , description: props.meta.description
                  , pageTitle: props.meta.title
                  }
              ]
          , components:
              Next.components
                { code: Coerce.unsafeCoerce codeBlock
                , "MultiCodeBlock": Coerce.unsafeCoerce multiCodeBlock
                }
          }
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

-- | Interop
page :: Props -> JSX
page = Unsafe.unsafePerformEffect mkPage