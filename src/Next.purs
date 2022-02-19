module Next where

import Prelude
import Foreign (Foreign)
import Foreign.Object (Object)
import React.Basic.Hooks (Component, JSX)

mkHead ::
  Component
    { children :: Array JSX
    }
mkHead = head_

mkMDXProvider ::
  Component
    { children :: Array JSX
    , components :: Object (Foreign -> JSX)
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
    , components :: Object (Foreign -> JSX)
    }

foreign import mkLink_ ::
  Component
    { href :: String
    , children :: JSX
    }
