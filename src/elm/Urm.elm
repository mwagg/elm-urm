module Urm exposing (init, step, run, Command(..), State)

import Array exposing (Array)
import Debug


type Command
    = Exit
    | Inc Int Int
    | Deb Int Int Int


type alias State =
    { registers : Array Int
    , program : Array Command
    , exited : Bool
    , programCounter : Int
    }


init : Array Int -> Array Command -> State
init registers program =
    { registers = registers
    , program = program
    , programCounter = 0
    , exited = False
    }


run : State -> State
run state =
    let
        newState =
            step state
    in
        if newState.exited then
            newState
        else
            run newState


step : State -> State
step state =
    let
        cmd =
            nextCommand state
    in
        case cmd of
            Exit ->
                { state | exited = True }

            Inc register cmdIndex ->
                { state
                    | programCounter = cmdIndex
                    , registers = incrementRegister state.registers register
                }

            Deb register successIndex branchIndex ->
                let
                    ( newRegisters, decremented ) =
                        decrementRegister state.registers register

                    nextCmdIndex =
                        if decremented then
                            successIndex
                        else
                            branchIndex
                in
                    { state
                        | programCounter = nextCmdIndex
                        , registers = newRegisters
                    }


incrementRegister : Array Int -> Int -> Array Int
incrementRegister registers index =
    let
        value =
            Array.get index registers
                |> Maybe.withDefault 0
    in
        Array.set index (value + 1) registers


decrementRegister : Array Int -> Int -> ( Array Int, Bool )
decrementRegister registers index =
    let
        value =
            Array.get index registers
                |> Maybe.withDefault 0

        decremented =
            value > 0

        newValue =
            if decremented then
                value - 1
            else
                0
    in
        ( Array.set index newValue registers, decremented )


nextCommand : State -> Command
nextCommand state =
    Array.get state.programCounter state.program
        |> Maybe.withDefault Exit
