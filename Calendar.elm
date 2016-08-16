port module Calendar exposing (..)

import Cmd.Extra exposing (message)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- SUBSCRIPTIONS


port initCalendarWidget : String -> Cmd msg


port setCalandarValue : (( String, String ) -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    setCalandarValue SetCalandarValue



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
    = InitCalendarWidget
    | SetCalandarValue ( String, String )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCalandarValue ( id, data ) ->
            if model.id == id then
                ( { model | data = data }, Cmd.none )
            else
                ( model, Cmd.none )

        InitCalendarWidget ->
            ( model, initCalendarWidget model.id )



-- INIT


init : String -> ( Model, Cmd Msg )
init id =
    ( { id = id, data = "" }, message InitCalendarWidget )
