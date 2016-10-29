module UrmTests exposing (..)

import Test exposing (..)
import Expect exposing (Expectation)
import Urm exposing (Command(..))
import Array exposing (Array)
import Test
import Programs


expectRanState : Urm.State -> Array Int -> Int -> Bool -> Expectation
expectRanState state registers programCounter exited =
    let
        newState =
            Urm.run state

        expectedState =
            { state
                | registers = registers
                , programCounter = programCounter
                , exited = exited
            }
    in
        Expect.equal newState expectedState


expectSteppedState : Urm.State -> Array Int -> Int -> Bool -> Expectation
expectSteppedState state registers programCounter exited =
    let
        newState =
            Urm.step state

        expectedState =
            { state
                | registers = registers
                , programCounter = programCounter
                , exited = exited
            }
    in
        Expect.equal newState expectedState


all : Test
all =
    describe "Urm"
        [ describe "step"
            [ test "exit results in exited state" <|
                \() ->
                    let
                        state =
                            Urm.init Array.empty (Array.fromList [ Exit ])
                    in
                        expectSteppedState state Array.empty 1 True
            , test "inc increments register and sets program counter" <|
                \() ->
                    let
                        program =
                            Array.fromList [ Inc 1 2, Exit ]

                        registers =
                            Array.fromList [ 0 ]

                        state =
                            Urm.init registers program
                    in
                        expectSteppedState state (Array.fromList [ 1 ]) 2 False
            , test "deb decrements and sets program counter to first index if register greater than 0" <|
                \() ->
                    let
                        program =
                            Array.fromList [ Deb 1 1 2, Exit ]

                        registers =
                            Array.fromList [ 1 ]

                        state =
                            Urm.init registers program
                    in
                        expectSteppedState state (Array.fromList [ 0 ]) 1 False
            , test "deb does not decrement and sets program counter to second index if register is 0" <|
                \() ->
                    let
                        program =
                            Array.fromList [ Deb 1 1 2, Exit ]

                        registers =
                            Array.fromList [ 0 ]

                        state =
                            Urm.init registers program
                    in
                        expectSteppedState state (Array.fromList [ 0 ]) 2 False
            ]
        , describe "run"
            [ test "addition program" <|
                \() ->
                    let
                        ( registers, program ) =
                            Programs.get "addition"

                        state =
                            Urm.init registers program
                    in
                        expectRanState state (Array.fromList [ 5, 0, 0 ]) 5 True
            ]
        ]
