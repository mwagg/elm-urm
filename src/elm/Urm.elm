module Urm exposing (Instruction(..), State, empty, init, run, step)

import Array exposing (Array)


type Instruction
    = Exit
    | Inc Int Int
    | Deb Int Int Int


type alias State =
    { registers : Array Int
    , program : Array Instruction
    , exited : Bool
    , programCounter : Int
    }


empty : State
empty =
    init Array.empty (Array.fromList [ Exit ])


init : Array Int -> Array Instruction -> State
init registers program =
    { registers = registers
    , program = program
    , programCounter = 1
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
            nextInstruction state
    in
    case cmd of
        Exit ->
            { state | exited = True }

        Inc register nextInstr ->
            { state
                | programCounter = nextInstr
                , registers = incrementRegister state.registers register
            }

        Deb register successIndex branchIndex ->
            let
                ( newRegisters, decremented ) =
                    decrementRegister state.registers register

                nextInstr =
                    if decremented then
                        successIndex

                    else
                        branchIndex
            in
            { state
                | programCounter = nextInstr
                , registers = newRegisters
            }


incrementRegister : Array Int -> Int -> Array Int
incrementRegister registers index =
    let
        arrayIndex =
            index - 1

        value =
            Array.get arrayIndex registers
                |> Maybe.withDefault 0
    in
    Array.set arrayIndex (value + 1) registers


decrementRegister : Array Int -> Int -> ( Array Int, Bool )
decrementRegister registers index =
    let
        arrayIndex =
            index - 1

        value =
            Array.get arrayIndex registers
                |> Maybe.withDefault 0

        decremented =
            value > 0

        newValue =
            if decremented then
                value - 1

            else
                0
    in
    ( Array.set arrayIndex newValue registers, decremented )


nextInstruction : State -> Instruction
nextInstruction state =
    let
        cmdIndex =
            state.programCounter - 1
    in
    Array.get cmdIndex state.program
        |> Maybe.withDefault Exit
