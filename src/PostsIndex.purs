module PostsIndex where

import Prelude

import Effect.Unsafe as Unsafe
import Gen.Posts (Post)
import Gen.Posts as Posts
import Layout as Layout
import Next as Next
import React.Basic.DOM as DOM
import React.Basic.Hooks (Component, JSX)
import React.Basic.Hooks as Hooks

mkPostsIndex :: Component { children :: Array JSX }
mkPostsIndex = do
  layout <- Layout.mkLayout
  postItem <- mkPostItem
  Hooks.component "PostsIndex" \_ -> React.do
    pure
      ( layout
          { children:
              [ DOM.h1_ [ DOM.text "Blog posts" ]
              , DOM.ul_ (Posts.posts_ <#> postItem)
              ]
          , description: "A list of blog posts"
          , pageTitle: "Blog posts"
          }
      )

mkPostItem :: Component Post
mkPostItem = do
  link <- Next.mkLink
  Hooks.component "PostItem" \post ->
    pure
      ( DOM.li_
          [ link { href: post.urlPath, child: DOM.text post.title } ]
      )

-- | Interop
postsIndex :: { children :: Array JSX } -> JSX
postsIndex = Unsafe.unsafePerformEffect mkPostsIndex
