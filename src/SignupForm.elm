module SignupForm where
import Html exposing (..)
import Html.Events exposing(..)
import Html.Attributes exposing(id, type', for, value, class)
import Effects exposing(Effects)
import Debug

init:  Model
init  =
    { username = "", password = "", errors = {username = "", password = ""} }

type ActionType = VALIDATE | SET_USERNAME | SET_PASSWORD
type alias Action =
  {actionType: ActionType,
  payload: String
  }

type alias Model =
  {username: String,
   password: String,
   errors: {username: String, password:String}
  }

view: Signal.Address Action -> Model -> Html
view actionDispatcher model =
    div
        [ id "signup-form" ]
        [ h1 [] [ text "Justin's super cool site!!" ]
        , label [ for "username-field" ] [ text "username: " ]
        , input
            [ id "username-field"
            , type' "text"
            , value model.username
            , on "input" targetValue (\str -> Signal.message actionDispatcher { actionType = SET_USERNAME, payload = str })
            ]
            []
        , div [ class "validation-error" ] [ text model.errors.username ]
        , label [ for "password" ] [ text "password: " ]
        , input
            [ id "password-field"
            , type' "password"
            , value model.password
            , on "input" targetValue (\str -> Signal.message actionDispatcher { actionType = SET_PASSWORD, payload = str })
            ]
            []
        , div [ class "validation-error" ] [ text model.errors.password ]
        , button [ class "signup-button", onClick actionDispatcher { actionType = VALIDATE, payload = "" } ] [ text "Sign Up!" ]
        ]



update: Action -> Model -> (Model, Effects Action)
update action model =
    case action.actionType of
        VALIDATE ->
          Debug.watch "model" ( { model | errors <- getErrors model }, Effects.none )
        SET_USERNAME ->
          Debug.watch "model" ( { model | username <- action.payload }, Effects.none )
        SET_PASSWORD ->
          Debug.watch "model"( { model | password <- action.payload }, Effects.none )

getErrors model =
  {username =
    if model.username == "" then
      "Please enter a username!"
    else
      ""
    , password =
      if model.password == "" then
        "Please enter a password!"
      else
        ""
    }
