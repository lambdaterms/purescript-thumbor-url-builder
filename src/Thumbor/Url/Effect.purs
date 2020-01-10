module Thumbor.Url.Effect where

import Prelude

import Data.Maybe (Maybe)
import Data.Newtype (class Newtype)
import Data.Nullable (Nullable, toNullable)
import Effect (Effect)
import Effect (Effect) as Thumbor.Url

foreign import data Thumbor ∷ Type

newtype Server = Server String
derive instance newtypeServer ∷ Newtype Server _

newtype ImagePath = ImagePath String
derive instance newtypeImagePath ∷ Newtype ImagePath _

newtype Key = Key String
derive instance newtypeKey ∷ Newtype Key _

-- | Let's require `ImagePath` during constrcution so all thumbor urls
-- | can be treated as secure
foreign import thumborImpl ∷ Nullable Key → Server → ImagePath → Effect Thumbor

thumbor ∷ Maybe Key → Server → ImagePath → Effect Thumbor
thumbor key server img = thumborImpl (toNullable key) server img

foreign import buildUrl ∷ Thumbor → Effect String

-- | Should we `newtype` everything?
type Height = Int
type Width = Int
foreign import resize ∷ Int → Int → Thumbor → Effect Unit

foreign import smartCrop ∷ Boolean → Thumbor → Effect Unit

data Format
  = WEBP
  | JPEG
  | GIF
  | PNG

foreign import formatImpl ∷ String → Thumbor → Effect Unit

format ∷ Format → Thumbor → Effect Unit
format f = formatImpl (serFormat f)
  where
    serFormat WEBP = "webp"
    serFormat JPEG = "jpeg"
    serFormat GIF = "gif"
    serFormat PNG = "png"


type Crop =
  { bottom ∷ Int
  , left ∷ Int
  , right ∷ Int
  , top ∷ Int
  }

foreign import crop ∷ Crop → Thumbor → Effect Unit
