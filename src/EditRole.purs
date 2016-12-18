module EditRole where

import Prelude
import Data.Maybe
import MDL
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Control.Monad.Aff (Aff)
import Control.Monad.Eff.Class (liftEff)
import DOM (DOM)
import DOM.HTML.Types (HTMLElement)
import Halogen.HTML.Properties (InputType)

data Query a = Initialize (Maybe HTMLElement) a | UpdateRoleName String a | Test a

data PermissionCategory = ProductPermissions | OrderPermissions | UserPermissions

type State = { test :: Boolean, element :: Maybe HTMLElement, roleName :: String }

type Effects eff = (dom :: DOM | eff)

ui :: forall eff. H.Component HH.HTML Query Void (Aff (Effects eff))
ui = H.component
       { render
       , eval
       , initialState }
  where

  render :: State -> H.ComponentHTML Query
  render state =
    if state.test then
      HH.div
      [ HP.id_ "cmp-div"
      , HP.ref (HE.input Initialize)
      , HP.classes [HH.ClassName "mdl-textfield", HH.ClassName "mdl-js-textfield", HH.ClassName "mdl-textfield--floating-label"] ]
      [ HH.input
        [ HP.id_ "roleName"
        , HP.inputType (HP.InputText)
        , HP.value state.roleName
        , HE.onValueInput (HE.input UpdateRoleName)
        , HP.class_ (HH.ClassName "mdl-textfield__input") ]
      , HH.label
        [ HP.for "roleName"
        , HP.class_ (HH.ClassName "mdl-textfield__label") ]
        [ HH.text "Role name"]
      ]
    else
      HH.div_ [ HH.button
                [HE.onClick (HE.input_ Test)]
                [ HH.text "Click to render MDL"]]

  eval :: Query ~> H.ComponentDSL State Query Void (Aff (Effects eff))
  eval (UpdateRoleName s next) = do
    H.modify (_ { roleName = s })
    pure next
  eval (Test next) = do
    H.modify (_ { test = true })
    pure next
  eval (Initialize el next) = do
    case el of
      Nothing -> pure next
      Just el' -> do
        liftEff $ upgradeElement el'
        pure next

  initialState :: State
  initialState = { test: false, element: Nothing, roleName: "" }
