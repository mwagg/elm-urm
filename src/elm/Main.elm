module Main exposing (header, init, machineVisualisationView, main, programControl, subscriptions, view)

import Browser
import Html exposing (Html)
import Html.Attributes as Attrs
import Html.Events as Events
import PresetProgramsView
import Time
import Urm
import UrmProgramView
import UrmRegistersView
import UrmVisualiser exposing (Msg(..), UrmVisualiser, update)


type alias Flags =
    ()


main : Program Flags UrmVisualiser Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = UrmVisualiser.update
        , subscriptions = subscriptions
        }


init : Flags -> ( UrmVisualiser, Cmd Msg )
init _ =
    ( { machineState = Urm.empty
      , autoStep = False
      }
    , Cmd.none
    )


subscriptions : UrmVisualiser -> Sub Msg
subscriptions model =
    Time.every 100 Tick



-- View


view : UrmVisualiser -> Html Msg
view model =
    Html.div []
        [ Html.div []
            [ PresetProgramsView.root
            , Html.div [ Attrs.class "main-body" ]
                [ header
                , machineVisualisationView model.machineState
                ]
            ]
        ]


header : Html Msg
header =
    Html.div [ Attrs.class "header" ]
        [ Html.h1 []
            [ Html.text "Unlimited Register Machine" ]
        ]


machineVisualisationView : Urm.State -> Html Msg
machineVisualisationView state =
    Html.div
        [ Attrs.class "machine-visualisation" ]
        [ Html.div [ Attrs.class "pure-g" ]
            [ Html.div [ Attrs.class "pure-u-1-2 machine-visualisation-component" ] [ UrmRegistersView.root state ]
            , Html.div [ Attrs.class "pure-u-1-2 machine-visualisation-component" ] [ UrmProgramView.root state ]
            ]
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
