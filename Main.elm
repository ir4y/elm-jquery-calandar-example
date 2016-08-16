port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
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
    case msg of
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
        ( model1, cmd1 ) =
            Calendar.init "first"

        ( model2, cmd2 ) =
            Calendar.init "second"
    in
        ( { first = model1
          , second = model2
          }
        , Cmd.batch
            [ Cmd.map First cmd1
            , Cmd.map Second cmd2
            ]
        )
