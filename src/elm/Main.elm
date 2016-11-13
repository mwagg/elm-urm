module Main exposing (..)

import UrmVisualiser exposing (UrmVisualiser, Msg(..), update)
import Html.App as App
import Html exposing (Html)
import Html.Attributes as Attrs
import Html.Events as Events
import Urm
import PresetProgramsView
import UrmRegistersView
import UrmProgramView
import Time


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = UrmVisualiser.update
        , subscriptions = subscriptions
        }


init : ( UrmVisualiser, Cmd Msg )
init =
    ( { machineState = Urm.empty
      , autoStep = False
      }
    , Cmd.none
    )


subscriptions : UrmVisualiser -> Sub Msg
subscriptions model =
    Time.every (100 * Time.millisecond) Tick



-- View


view : UrmVisualiser -> Html Msg
view model =
    Html.div []
        [ header
        , PresetProgramsView.root
        , machineVisualisationView model.machineState
        ]


header : Html Msg
header =
    Html.div [ Attrs.class "header" ]
        [ Html.h1 []
            [ Html.text "Elm Unlimited Register Machine" ]
        ]


machineVisualisationView : Urm.State -> Html Msg
machineVisualisationView state =
    Html.div
        [ Attrs.class "machine-visualisation" ]
        [ Html.div [ Attrs.class "machine-visualisation__component" ] [ UrmRegistersView.root state ]
        , Html.div [ Attrs.class "machine-visualisation__component" ] [ UrmProgramView.root state ]
        , programControl
        ]


programControl : Html Msg
programControl =
    Html.div [ Attrs.class "machine-visualisation-component" ]
        [ Html.h3 [] [ Html.text "Program control" ]
        , Html.button [ Events.onClick Step ] [ Html.text "Step" ]
        , Html.button [ Events.onClick Play ] [ Html.text "Run" ]
        , Html.button [ Events.onClick Stop ] [ Html.text "Stop" ]
        ]
