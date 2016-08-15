port module Main exposing (..)

import String
import Debug
import Cmd.Extra exposing (message)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as JsonDecode
import Html.App as App
import Calendar


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map First (Calendar.subscriptions model.first)
        , Sub.map Second (Calendar.subscriptions model.second)
        ]



-- MODEL


type alias Model =
    { first : Calendar.Model
    , second : Calendar.Model
    }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ App.map First (Calendar.view model.first)
        , App.map Second (Calendar.view model.second)
        ]



-- UPDATE


type Msg
    = First Calendar.Msg
    | Second Calendar.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "MESSAGE: " msg) of
        First msg' ->
            let
                ( model', cmd' ) =
                    Calendar.update msg' model.first
            in
                ( { model | first = model' }, Cmd.map First cmd' )

        Second msg' ->
            let
                ( model', cmd' ) =
                    Calendar.update msg' model.second
            in
                ( { model | second = model' }, Cmd.map First cmd' )



-- INIT


init : ( Model, Cmd Msg )
init =
    let
        calc1 =
            Calendar.init "first"

        calc2 =
            Calendar.init "second"
    in
        ( { first = fst calc1
          , second = fst calc2
          }
        , Cmd.batch
            [ Cmd.map First (snd calc1)
            , Cmd.map Second (snd calc2)
            ]
        )
