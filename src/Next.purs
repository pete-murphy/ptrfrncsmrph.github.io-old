module Next where

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
    , components :: Object (forall r. r -> JSX)
    }
mkMDXProvider = mdxProvider_

foreign import head_ ::
  Component
    { children :: Array JSX }

foreign import mdxProvider_ ::
  Component
    { children :: Array JSX
    , components :: Object (forall r. r -> JSX)
    }
