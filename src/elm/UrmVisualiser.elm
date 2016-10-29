module UrmVisualiser exposing (..)

import Urm
import Programs
import Time exposing (Time)


-- Model


type alias Model =
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


update : Msg -> Model -> ( Model, Cmd Msg )
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


changeProgram : Model -> String -> ( Model, Cmd Msg )
changeProgram model programName =
    let
        ( registers, program ) =
            Programs.get programName

        newModel =
            { model
                | machineState = Urm.init registers program
                , autoStep = False
            }
    in
        ( newModel, Cmd.none )
