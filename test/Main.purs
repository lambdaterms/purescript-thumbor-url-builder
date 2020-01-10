module Test.Main where

import Prelude

import Data.Foldable (fold)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class (liftEffect)
import Test.Unit (suite, test)
import Test.Unit.Assert (equal) as Assert
import Test.Unit.Main (runTest)
import Thumbor.Url.Builder (build, crop, format, resize, smartCrop) as B
import Thumbor.Url.Effect (Format(..), ImagePath(..), Server(..))
import Thumbor.Url.Effect (buildUrl, format, resize, smartCrop, thumbor) as E

main ∷ Effect Unit
main = runTest do
  let
    server = Server "https://example.com"
    img = ImagePath "image.jpeg"
  suite "Thumbor.Effects" do
    let
      nonSecure = liftEffect $ E.thumbor Nothing server img

    test "non secure" do
      url ← liftEffect $ nonSecure >>= E.buildUrl
      Assert.equal "https://example.com/unsafe/image.jpeg" url

    test "resize" do
      url ← liftEffect $ nonSecure >>= \t → E.resize 100 200 t *> E.buildUrl t
      Assert.equal "https://example.com/unsafe/100x200/image.jpeg" url

    test "smart crop" do
      url ← liftEffect $ nonSecure >>= \t → E.smartCrop true t *> E.buildUrl t
      Assert.equal "https://example.com/unsafe/smart/image.jpeg" url

    test "format" do
      url ← liftEffect $ nonSecure >>= \t → E.format PNG t *> E.buildUrl t
      Assert.equal "https://example.com/unsafe/filters:format(png)/image.jpeg" url

  suite "Thumbor.Builder" do
    test "fold" do
      let
        url = B.build Nothing server img
          $ B.format PNG
          <> B.smartCrop true
          <> B.resize 100 200
          <> B.crop { top: 10, left: 15, right: 150, bottom: 100 }
      Assert.equal "https://example.com/unsafe/15x10:150x100/100x200/smart/filters:format(png)/image.jpeg" url
