port module Main exposing (..)

import Tests
import UrmTests
import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)


main : Program Value
main =
    run emit UrmTests.all


port emit : ( String, Value ) -> Cmd msg
