module UrmRegistersView exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Urm
import UrmVisualiser exposing (Msg)
import Array exposing (Array)


root : Urm.State -> Html Msg
root state =
    let
        classes =
            classList
                [ ( "urm-current-state", True )
                ]
    in
        div [ classes ]
            [ div
                [ class "pure-u" ]
                [ h3 []
                    [ text "Registers" ]
                , registersView state.registers
                ]
            ]


registersView : Array Int -> Html Msg
registersView registers =
    let
        registerNumbers =
            List.repeat 10 0
                |> List.indexedMap
                    (\i _ ->
                        th [] [ text (toString (i + 1)) ]
                    )

        registerValue =
            \v -> td [] [ text (toString v) ]

        registerValues =
            Array.map registerValue registers
                |> Array.toList
    in
        table [ class "pure-table" ]
            [ thead [] [ tr [] registerNumbers ]
            , tbody [] [ tr [] registerValues ]
            ]
