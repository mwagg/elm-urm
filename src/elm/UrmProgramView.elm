module UrmProgramView exposing (root)

import Array exposing (Array)
import Html exposing (..)
import Html.Attributes exposing (..)
import Urm exposing (Instruction(..))
import UrmVisualiser exposing (Msg)


root : Urm.State -> Html Msg
root state =
    div [ class "urm-program" ]
        [ h3 [] [ text "Program" ]
        , programView state.program state.programCounter
        ]


programView : Array Urm.Instruction -> Int -> Html Msg
programView program programCounter =
    let
        nextCmdIndex =
            programCounter - 1

        header =
            [ "#", "instruction", "register", "next", "branch" ]
                |> List.map (\s -> th [] [ text s ])

        commands =
            Array.toList program
                |> List.indexedMap (commandRow nextCmdIndex)
    in
    table [ class "pure-table" ]
        [ thead [] [ tr [] header ]
        , tbody [] commands
        ]


commandRow : Int -> Int -> Instruction -> Html Msg
commandRow nextIndex index cmd =
    let
        tdHtml =
            \v -> td [] [ text v ]

        tdsHtml =
            commandRowValues index cmd
                |> List.map tdHtml

        rowCssClass =
            classList [ ( "next-command", nextIndex == index ) ]
    in
    tr [ rowCssClass ] tdsHtml


commandRowValues : Int -> Instruction -> List String
commandRowValues index cmd =
    let
        values =
            case cmd of
                Exit ->
                    [ "Exit", "", "", "" ]

                Inc register next ->
                    [ "Inc", String.fromInt register, String.fromInt next, "" ]

                Deb register next branch ->
                    [ "Deb", String.fromInt register, String.fromInt next, String.fromInt branch ]

        instructionIndex =
            String.fromInt (index + 1)
    in
    instructionIndex :: values
