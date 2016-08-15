port module Calendar exposing (..)

import String
import Debug
import Cmd.Extra exposing (message)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as JsonDecode


-- SUBSCRIPTIONS


port output : String -> Cmd msg


port input : (( String, String ) -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    input SetValue



-- MODEL


type alias Model =
    { id : String
    , data : String
    }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.input
            [ id model.id
            , value model.data
            ]
            []
        ]



-- UPDATE


type Msg
    = Ask
    | SetValue ( String, String )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "MESSAGE: " msg) of
        SetValue ( id, data ) ->
            if model.id == id then
                ( { model | data = data }, Cmd.none )
            else
                ( model, Cmd.none )

        Ask ->
            ( model, output model.id )



-- INIT


init : String -> ( Model, Cmd Msg )
init id =
    ( { id = id, data = "" }, message Ask )
