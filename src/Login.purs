module Login where

import Prelude

import Halogen
import Halogen.HTML.Events as E
import Halogen.HTML as H
import Halogen.HTML.Properties as P

data Query a = AttemptLogin a
             | UpdateUsername String a
             | UpdatePassword String a

type State = { attempting :: Boolean, username :: String, password :: String }

initialState :: State
initialState = { attempting: false, username: "", password: "" }

ui :: forall g. Component H.HTML Query Void g
ui = component { render, eval, initialState } where
  render :: State -> ComponentHTML Query
  render state =
    H.div_
     [ H.input
       [ P.autofocus true
       , P.value state.username
       , P.placeholder "username"
       , E.onValueInput (E.input UpdateUsername)]
     , H.input
       [ P.value state.password
       , P.placeholder "password"
       , E.onValueInput (E.input UpdatePassword) ]
     , H.button
         [ P.disabled (state.attempting || state.username == "" || state.password == "")
         , E.onClick (E.input_ AttemptLogin) ]
         [ H.text "Log-in" ]
     ]

  eval :: Query ~> ComponentDSL State Query Void g
  eval (UpdateUsername s next) = do
    modify (_ { username = s })
    pure next
  eval (UpdatePassword s next) = do
    modify (_ { password = s })
    pure next
  eval (AttemptLogin next) = do
    modify (_ { attempting = true })
    pure next
