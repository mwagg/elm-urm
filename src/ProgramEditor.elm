module ProgramEditor exposing (ProgramEditor)

import Html exposing (Html)
import Urm exposing (Instruction)


type ProgramEditor
    = ReadOnly (List Instruction)
    | Editing (List Instruction) InstructionBeingEdited (List Instruction)


type InstructionBeingEdited
    = Ok String


type alias Config =
    {}


view : Config -> ProgramEditor -> Html msg
view _ _ =
    let
        header : Html msg
        header =
            Html.thead []
                [ Html.tr []
                    [ Html.th [] [ Html.text "#" ]
                    , Html.th [] [ Html.text "Instruction" ]
                    ]
                ]
    in
    Html.table [] [ header ]
