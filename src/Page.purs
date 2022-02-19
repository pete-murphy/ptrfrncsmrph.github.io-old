module Page where

import Prelude

import CodeBlock as CodeBlock
import Data.Array ((:))
import Effect.Unsafe as Unsafe
import Foreign.Object as Object
import Layout as Layout
import MultiCodeBlock as MultiCodeBlock
import Next as Next
import React.Basic.Hooks (Component, JSX, (/\))
import React.Basic.Hooks as Hooks
import React.Basic.DOM as DOM
import Unsafe.Coerce as Coerce

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
              [ layout
                  { children: DOM.h1_ [ DOM.text props.meta.title ] : props.children
                  , description: props.meta.description
                  , pageTitle: props.meta.title
                  }
              ]
          , components:
              Object.fromFoldable
                [ "code" /\ Coerce.unsafeCoerce codeBlock
                , "MultiCodeBlock" /\ Coerce.unsafeCoerce multiCodeBlock
                ]
          }
      )

page :: Props -> JSX
page = Unsafe.unsafePerformEffect mkPage
