module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Halogen as H
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)

import EditRole

main :: Eff (H.HalogenEffects ()) Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI ui body
