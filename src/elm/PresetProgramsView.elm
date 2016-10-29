module PresetProgramsView exposing (root)

import Programs
import UrmVisualiser exposing (Msg(ChangeProgram))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


root : Html Msg
root =
    let
        programsHtml =
            List.map programView Programs.names

        classes =
            classList
                [ ( "preset-programs", True )
                ]

        heading =
            h3 [] [ text "Preset programs" ]

        menu =
            div [ class "pure-menu" ]
                [ ul [ class "pure-menu-list" ] programsHtml ]
    in
        Html.div [ classes ] [ heading, menu ]


programView : String -> Html Msg
programView name =
    li [ class "pure-menu-item" ]
        [ a
            [ href ("#" ++ name)
            , class "pure-menu-link"
            , onClick (ChangeProgram name)
            ]
            [ text name ]
        ]
