module MultiCodeBlock where

import Prelude

import Control.Comonad as Comonad
import Control.Comonad.Store as Store
import Data.Array as Array
import Data.Array.NonEmpty (NonEmptyArray)
import Data.Array.NonEmpty as NonEmpty
import Data.Maybe (Maybe(..))
import React.Basic (JSX)
import React.Basic.DOM as DOM
import React.Basic.Events as Events
import React.Basic.Hooks (Component, (/\))
import React.Basic.Hooks as Hooks
import Unsafe.Coerce as Coerce

data Language
  = PureScript
  | TypeScript
  | Haskell
  | Rust

instance Show Language where
  show = case _ of
    PureScript -> "PureScript"
    TypeScript -> "TypeScript"
    Haskell -> "Haskell"
    Rust -> "Rust"

mkMultiCodeBlock :: Component { children :: Array InternalPropsType }
mkMultiCodeBlock = do
  multiCodeBlock_ <- mkMultiCodeBlock_
  Hooks.component "MultiCodeBlock" \{ children } -> Hooks.do
    let
      codes = children # Array.mapMaybe \node' -> ado
        language <- parseLanguage node'
        in { language, node: Coerce.unsafeCoerce node' :: JSX }
    case NonEmpty.fromArray codes of
      Just nonEmptyCodes -> pure (multiCodeBlock_ nonEmptyCodes)
      Nothing -> mempty

mkMultiCodeBlock_ :: Component (NonEmptyArray { language :: Language, node :: JSX })
mkMultiCodeBlock_ =
  Hooks.component "MultiCodeBlock_" \codes -> Hooks.do
    let
      render { language, node } =
        DOM.div_ [ DOM.text (show language), node ]
    state /\ setState <- Hooks.useState (Store.store render (NonEmpty.head codes))
    let
      buttons = Hooks.fragment
        ( NonEmpty.toArray
            ( codes <#> \code -> DOM.button
                { onClick: Events.handler_ (setState (Store.seek code))
                , children: [ DOM.text (show code.language) ]
                }
            )
        )
    pure (DOM.div_ [ buttons <> Comonad.extract state ])

parseLanguage :: InternalPropsType -> Maybe Language
parseLanguage { props } = case props.children.props.className of
  "language-purescript" -> Just PureScript
  "language-typescript" -> Just TypeScript
  "language-haskell" -> Just Haskell
  "language-rust" -> Just Rust
  _ -> Nothing

type InternalPropsType
  = { props :: { children :: { props :: { className :: String } } } }