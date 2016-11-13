module UrmProgramView exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Urm exposing (Instruction(..))
import UrmVisualiser exposing (Msg)
import Array exposing (Array)
import UrmUI


root : Urm.State -> Html Msg
root state =
    programView state.program state.programCounter
        |> UrmUI.section "Program" "urm-program"


programView : Array Urm.Instruction -> Int -> Html Msg
programView program programCounter =
    let
        nextCmdIndex =
            programCounter - 1

        header =
            [ "#", "instruction", "register", "next", "branch" ]
                |> List.map (\s -> th [ class "urm-program__header" ] [ text s ])

        commands =
            Array.toList program
                |> List.indexedMap (commandRow nextCmdIndex)
    in
        table [ class "urm-program__table" ]
            [ thead [ class "urm-program__headers" ] [ tr [] header ]
            , tbody [ class "urm-program__instructions" ] commands
            ]


commandRow : Int -> Int -> Instruction -> Html Msg
commandRow nextIndex index cmd =
    let
        tdHtml =
            \v -> td [ class "urm-program__instruction" ] [ text v ]

        tdsHtml =
            commandRowValues index cmd
                |> List.map tdHtml

        rowCssClass =
            classList [ ( "urm-program__instructions--next", nextIndex == index ) ]
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
                    [ "Inc", (toString register), (toString next), "" ]

                Deb register next branch ->
                    [ "Deb", (toString register), (toString next), (toString branch) ]

        instructionIndex =
            toString (index + 1)
    in
        instructionIndex :: values
