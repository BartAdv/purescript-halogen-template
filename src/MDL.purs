-- https://github.com/zudov/purescript-halogen-mdl/blob/master/src/MDL.purs
module MDL where

import Prelude (Unit)
import Control.Monad.Eff (Eff())

import DOM (DOM())
import DOM.HTML.Types (HTMLElement())

foreign import upgradeElement :: forall eff. HTMLElement -> Eff (dom :: DOM | eff) Unit

foreign import trace :: forall a b. a -> (Unit -> b) -> b
