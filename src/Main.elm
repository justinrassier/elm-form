import SignupForm exposing (init, update, view)
import StartApp
import Effects



app =
    StartApp.start
        { init = (init, Effects.none)
        , update = update
        , view = view
        , inputs = []
        }

main =
    app.html
