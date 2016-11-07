module Programs exposing (get, names)

import Urm exposing (Command(..))
import Dict exposing (Dict)
import Array exposing (Array)


zeroOutRegister : Int -> Int -> Urm.Command
zeroOutRegister register cmdIndex =
    let
        cmdIndexWhenDone =
            cmdIndex + 1
    in
        Deb register cmdIndex cmdIndexWhenDone


{-| Move the contents of register 1 to register 2,
    zeroing out register 2 first
-}
move : ( Array Int, Array Urm.Command )
move =
    let
        registers =
            Array.fromList [ 3, 4 ]

        program =
            Array.fromList
                [ (zeroOutRegister 2 1)
                , Deb 1 3 4
                , Inc 2 2
                , Exit
                ]
    in
        ( registers, program )


{-| Subtract the value of register 4 from register 3, putting
    the result in register 0 and using register 2 as a flag
    to indicate negative values. Zero in register 2 indicates
    the value in register 1 is positive, 1 indicates negative
-}
subtract : Int -> Int -> ( Array Int, Array Urm.Command )
subtract a b =
    let
        registers =
            Array.fromList [ 1, 2, a, b ]

        program =
            Array.fromList
                [ (zeroOutRegister 1 1)
                , (zeroOutRegister 2 2)
                , Deb 4 4 5
                , Deb 3 3 7
                , Deb 3 6 11
                , Inc 1 5
                , Inc 4 8
                , Inc 2 9
                , Deb 4 10 11
                , Inc 1 9
                , Exit
                ]
    in
        ( registers, program )


{-| Multiplies the value of register 3 by the value of
    register 4
-}
multiplication : ( Array Int, Array Urm.Command )
multiplication =
    let
        registers =
            Array.fromList [ 0, 0, 3, 5 ]

        program =
            Array.fromList
                [ (zeroOutRegister 1 1)
                , (zeroOutRegister 2 2)
                , Deb 4 4 9
                , Deb 2 5 6
                , Inc 3 4
                , Deb 3 7 3
                , Inc 1 8
                , Inc 2 6
                , Exit
                ]
    in
        ( registers, program )


{-| Copy the contents of register 1 to register 2,
    zeroing out register 2 first
-}
copy : ( Array Int, Array Urm.Command )
copy =
    let
        registers =
            Array.fromList [ 4, 3, 2 ]

        program =
            Array.fromList
                [ Deb 2 1 2
                , Deb 3 2 3
                , Deb 1 4 6
                , Inc 2 5
                , Inc 3 3
                , Deb 3 7 8
                , Inc 1 6
                , Exit
                ]
    in
        ( registers, program )


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
        [ ( "move", move )
        , ( "copy", copy )
        , ( "incrementTwice", incrementTwice )
        , ( "decrementTwice", decrementTwice )
        , ( "addition", addition )
        , ( "nonDestructiveAddition", nonDestructiveAddition )
        , ( "subtractSimple", (subtract 9 5) )
        , ( "subtractNegative", (subtract 5 9) )
        , ( "multiplication", multiplication )
        ]


get : String -> ( Array Int, Array Urm.Command )
get name =
    Dict.get name programs
        |> Maybe.withDefault ( Array.empty, Array.fromList [ Exit ] )


names : List String
names =
    Dict.keys programs
