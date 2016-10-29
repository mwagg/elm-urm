module Programs exposing (get, names)

import Urm exposing (Command(..))
import Dict exposing (Dict)
import Array exposing (Array)


incrementTwice : ( Array Int, Array Urm.Command )
incrementTwice =
    let
        registers =
            Array.fromList [ 0 ]

        program =
            Array.fromList
                [ Inc 1 2
                , Inc 1 3
                , Exit
                ]
    in
        ( registers, program )


decrementTwice : ( Array Int, Array Urm.Command )
decrementTwice =
    let
        registers =
            Array.fromList [ 2 ]

        program =
            Array.fromList
                [ Deb 1 1 2
                , Exit
                ]
    in
        ( registers, program )


addition : ( Array Int, Array Urm.Command )
addition =
    let
        registers =
            Array.fromList [ 0, 2, 3 ]

        program =
            Array.fromList
                [ Deb 2 2 3
                , Inc 1 1
                , Deb 3 4 5
                , Inc 1 3
                , Exit
                ]
    in
        ( registers, program )


nonDestructiveAddition : ( Array Int, Array Urm.Command )
nonDestructiveAddition =
    let
        registers =
            Array.fromList [ 0, 0, 2, 3 ]

        program =
            Array.fromList
                [ Deb 3 2 4
                , Inc 1 3
                , Inc 2 1
                , Deb 2 5 6
                , Inc 3 4
                , Deb 4 7 9
                , Inc 1 8
                , Inc 2 6
                , Deb 2 10 11
                , Inc 4 9
                , Exit
                ]
    in
        ( registers, program )


programs : Dict String ( Array Int, Array Urm.Command )
programs =
    Dict.fromList
        [ ( "incrementTwice", incrementTwice )
        , ( "decrementTwice", decrementTwice )
        , ( "addition", addition )
        , ( "nonDestructiveAddition", nonDestructiveAddition )
        ]


get : String -> ( Array Int, Array Urm.Command )
get name =
    Dict.get name programs
        |> Maybe.withDefault ( Array.empty, Array.fromList [ Exit ] )


names : List String
names =
    Dict.keys programs
