module Next where

import Prelude
import Foreign (Foreign)
import React.Basic.Hooks (Component, JSX)
import Type.Row.Homogeneous (class Homogeneous)
import Unsafe.Coerce (unsafeCoerce)

mkHead ::
  Component
    { children :: Array JSX
    }
mkHead = head_

components :: forall r. Homogeneous r (Foreign -> JSX) => Record r -> MDXComponents
components r = unsafeCoerce r

data MDXComponents

mkMDXProvider ::
  Component
    { children :: Array JSX
    , components :: MDXComponents
    }
mkMDXProvider = mdxProvider_

mkLink :: Component
  { child :: JSX
  , href :: String
  }
mkLink = do
  link_ <- mkLink_
  pure \props -> (link_ { children: props.child, href: props.href })

foreign import head_ ::
  Component
    { children :: Array JSX }

foreign import mdxProvider_ ::
  Component
    { children :: Array JSX
    , components :: MDXComponents
    }

foreign import mkLink_ ::
  Component
    { href :: String
    , children :: JSX
    }
