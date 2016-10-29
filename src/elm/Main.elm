module Main exposing (..)

import UrmVisualiser exposing (Model, Msg(..))
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


init : ( Model, Cmd Msg )
init =
    ( { machineState = Urm.empty
      , autoStep = False
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (500 * Time.millisecond) Tick



-- View


view : Model -> Html Msg
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
