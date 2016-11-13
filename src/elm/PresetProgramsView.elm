module PresetProgramsView exposing (root)

import Programs
import UrmVisualiser exposing (Msg(ChangeProgram))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import UrmUI


root : Html Msg
root =
    let
        programsHtml =
            List.map programView Programs.names

        menu =
            ol [ class "urm-list" ] programsHtml
    in
        UrmUI.section "Programs" "preset-programs" menu


programView : String -> Html Msg
programView name =
    li [ class "urm-list__item" ]
        [ span [ class "preset-programs__name" ]
            [ a
                [ href ("#" ++ name), onClick (ChangeProgram name) ]
                [ text name ]
            ]
        , span [ class "preset-programs__description" ] [ text "A description" ]
        ]
