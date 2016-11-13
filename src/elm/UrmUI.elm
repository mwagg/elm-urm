module UrmUI exposing (section)

import Html exposing (..)
import Html.Attributes exposing (..)
import UrmVisualiser exposing (Msg(ChangeProgram))


section : String -> String -> Html Msg -> Html Msg
section title clazz contents =
    let
        classes =
            classList
                [ ( clazz, True )
                , ( "urm-section", True )
                ]

        heading =
            div [ class "urm-section__header" ] [ h2 [] [ text title ] ]

        contentContainer =
            div [ class "urm-section__content" ] [ contents ]
    in
        div [ classes ] [ heading, contentContainer ]
