module Thumbor.Url.Builder where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import Effect.Unsafe (unsafePerformEffect)
import Thumbor.Url.Effect (Format, ImagePath, Key, Server, Thumbor, Crop, buildUrl, thumbor)
import Thumbor.Url.Effect (crop, format, resize, smartCrop) as E

newtype Builder = Builder (Thumbor → Effect Unit)

instance semigorupBuilder ∷ Semigroup Builder where
  append (Builder m1) (Builder m2) = Builder (\t → m1 t *> m2 t)

instance monoidBuilder ∷ Monoid Builder where
  mempty = Builder (const $ pure unit)

resize ∷ Int → Int → Builder
resize width height = Builder (E.resize width height)

smartCrop ∷ Boolean → Builder
smartCrop t = Builder (E.smartCrop t)

format ∷ Format → Builder
format f = Builder (E.format f)

crop ∷ Crop → Builder
crop c = Builder (E.crop c)

build ∷ Maybe Key → Server → ImagePath → Builder → String
build k s i (Builder b) = unsafePerformEffect $ do
  t ← thumbor k s i
  b t
  buildUrl t
