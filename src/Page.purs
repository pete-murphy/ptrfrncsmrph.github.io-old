module Page where

import Prelude
import CodeBlock as CodeBlock
import Color as Color
import Effect.Unsafe (unsafePerformEffect)
import Layout as Layout
import MultiCodeBlock as MultiCodeBlock
import Next as Next
import React.Basic.Emotion (Style)
import React.Basic.Emotion as E
import React.Basic.Hooks (Component, JSX, component, element)
import Unsafe.Coerce (unsafeCoerce)

mkPage :: Component { children :: Array JSX }
mkPage = do
  layout <- Layout.mkLayout
  mdxProvider <- Next.mkMDXProvider
  multiCodeBlock <- MultiCodeBlock.mkMultiCodeBlock
  codeBlock <- CodeBlock.mkCodeBlock
  component "Page" \{ children } -> React.do
    pure
      $ mdxProvider
          { children:
              [ element E.global { styles }
              , layout
                  { children
                  , description: "Blog"
                  , pageTitle: "Blog"
                  }
              ]
          , components:
              Next.components
                { code: unsafeCoerce codeBlock
                , "MultiCodeBlock": unsafeCoerce multiCodeBlock
                }
          }

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
page :: { children :: Array JSX } -> JSX
page = unsafePerformEffect mkPage
