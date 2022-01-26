module MultiCodeBlock where

import Prelude

import Color as Color
import Data.Array (mapWithIndex, (!!))
import Data.Maybe (Maybe(..), fromMaybe, fromMaybe')
import Data.Traversable (sequence, traverse)
import Effect (Effect)
import Effect.Class.Console (log, logShow)
import Effect.Unsafe (unsafePerformEffect)
import Partial.Unsafe (unsafeCrashWith)
import React.Basic.DOM as R
import React.Basic.Emotion (Style)
import React.Basic.Emotion as E
import React.Basic.Events (handler_)
import React.Basic.Hooks (Component, component, useState', (/\))
import React.Basic.Hooks as React
import Unsafe.Coerce (unsafeCoerce)

data Language
  = PureScript
  | TypeScript
  | Haskell
  | Rust

instance showLanguage :: Show Language where
  show PureScript = "PureScript"
  show TypeScript = "TypeScript"
  show Haskell = "Haskell"
  show Rust = "Rust"

type CodeBlockProps
  = { props :: { children :: { props :: { className :: String } } } }

mkMultiCodeBlock :: Component { children :: Array CodeBlockProps }
mkMultiCodeBlock = do
  languageButton <- mkLanguageButton
  component "MultiCodeBlock" \{ children } -> React.do
    selectedIx /\ setSelectedIx <- useState' 0
    let
      -- TODO: Remove `unsafeCrashWith`
      codes =
        fromMaybe'
          (\_ -> unsafeCrashWith ("Bug: parseLanguage shouldn't fail\n" <> unsafeCoerce children))
          -- `traverse` & `sequence` just used to "bubble up" the possible failure of `parseLanguage`
          (traverse (\c -> sequence (c /\ parseLanguage c)) children)

      buttons = codes
        # mapWithIndex
            ( \i (_ /\ lang) -> languageButton
                { handleClick: setSelectedIx i
                , language: lang
                }
            )
    pure
      ( case codes !! selectedIx of
          Just (node /\ lang) ->
            E.element R.div'
              { css: style
              , className: ""
              , children:
                  [ R.div_ buttons
                  , unsafeCoerce node
                  ]
              }
          -- @TODO: Make this impossible state unrepresentable
          Nothing -> unsafeCrashWith ("Bug: selectedIx shouldn't be out of bounds for codes")
      )

parseLanguage :: CodeBlockProps -> Maybe Language
parseLanguage { props } = case props.children.props.className of
  "language-purescript" -> Just PureScript
  "language-typescript" -> Just TypeScript
  "language-haskell" -> Just Haskell
  "language-rust" -> Just Rust
  _ -> Nothing

style :: Style
style =
  E.css
    { backgroundColor: E.color (Color.hsla 95.0 1.0 0.5 1.0)
    , padding: E.str "0.15em 0.2em 0.05em"
    , "code":
        E.nested do
          E.css
            { display: E.str "block"
            }
    }

-- TODO: Design for dark mode and how to implement.

-- TODO: Add styles ...  do I need to pass down class name? why does E.element insist on it?
mkLanguageButton :: Component { handleClick :: Effect Unit, language :: Language }
mkLanguageButton = do
  component "LanguageButton" \props ->
    pure
      ( R.button
          { onClick: handler_ props.handleClick
          , children: [ R.text (show props.language) ]
          }
      )
