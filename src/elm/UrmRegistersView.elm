module UrmRegistersView exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Urm
import UrmVisualiser exposing (Msg)
import Array exposing (Array)
import UrmUI


root : Urm.State -> Html Msg
root state =
    let
        classes =
            classList
                [ ( "urm-current-state", True )
                ]

        registers =
            Array.indexedMap registerView state.registers
                |> Array.toList
                |> div []
    in
        UrmUI.section "Registers" "urm-registers" registers


registerView : Int -> Int -> Html Msg
registerView index value =
    let
        header =
            div [ class "urm-registers__index" ] [ text (toString (index + 1)) ]

        content =
            div [ class "urm-registers__value" ] [ text (toString value) ]
    in
        div [ class "urm-registers__register" ]
            [ header
            , content
            ]
