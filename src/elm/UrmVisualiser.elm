module UrmVisualiser exposing (UrmVisualiser, update, Msg(..))

import Urm
import Programs
import Time exposing (Time)


-- UrmVisualiser


type alias UrmVisualiser =
    { machineState : Urm.State
    , autoStep : Bool
    }



-- Update


type Msg
    = ChangeProgram String
    | Step
    | Play
    | Stop
    | Tick Time


update : Msg -> UrmVisualiser -> ( UrmVisualiser, Cmd Msg )
update msg model =
    case msg of
        ChangeProgram programName ->
            changeProgram model programName

        Step ->
            ( { model | machineState = Urm.step model.machineState }, Cmd.none )

        Play ->
            ( { model | autoStep = True }, Cmd.none )

        Stop ->
            ( { model | autoStep = False }, Cmd.none )

        Tick time ->
            if model.autoStep == False then
                ( model, Cmd.none )
            else
                ( { model | machineState = Urm.step model.machineState }, Cmd.none )


changeProgram : UrmVisualiser -> String -> ( UrmVisualiser, Cmd Msg )
changeProgram model programName =
    let
        ( registers, program ) =
            Programs.get programName

        newUrmVisualiser =
            { model
                | machineState = Urm.init registers program
                , autoStep = False
            }
    in
        ( newUrmVisualiser, Cmd.none )
