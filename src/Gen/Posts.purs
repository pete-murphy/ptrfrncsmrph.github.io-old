module Gen.Posts where

type Post =
  { filePath :: String
  , urlPath :: String
  , title :: String
  , date :: String
  , description :: String
  }

foreign import posts_ :: Array Post
