module UrmProgramView exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Urm exposing (Command(..))
import UrmVisualiser exposing (Msg)
import Array exposing (Array)


root : Urm.State -> Html Msg
root state =
    div [ class "urm-program" ]
        [ h3 [] [ text "Program" ]
        , programView state.program state.programCounter
        ]


programView : Array Urm.Command -> Int -> Html Msg
programView program programCounter =
    let
        nextCmdIndex =
            programCounter - 1

        header =
            [ "#", "command", "register", "next", "branch" ]
                |> List.map (\s -> th [] [ text s ])

        commands =
            Array.toList program
                |> List.indexedMap (commandRow nextCmdIndex)
    in
        table [ class "pure-table" ]
            [ thead [] [ tr [] header ]
            , tbody [] commands
            ]


commandRow : Int -> Int -> Command -> Html Msg
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


commandRowValues : Int -> Command -> List String
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
