module Next where

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

mkMDXProvider ::
  Component
    { children :: Array JSX
    , components :: MDXComponents
    }
mkMDXProvider = mdxProvider_

data MDXComponents

foreign import head_ ::
  Component
    { children :: Array JSX }

foreign import mdxProvider_ ::
  Component
    { children :: Array JSX
    , components :: MDXComponents
    }
