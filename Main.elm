import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Array

main : Program Never Model Msg
main =
  Html.beginnerProgram { model = { notes = [] }, view = view, update = update }

type Msg = Increment | Decrement

type alias Model =
  {
    notes : List String
  }

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      { model |
          notes = ( letterToNote ( letterByNumber ( List.length model.notes ) ) ) :: model.notes
      }

    Decrement ->
      { model |
        notes = removeFirstFromlist model.notes
      }

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString ( List.length model.notes ) ) ]
    , button [ onClick Increment ] [ text "+" ]
    , div [] [ viewNoteList model.notes ]
    ]

viewNote : String -> Html Msg
viewNote note =
    div [] [ text note ]

viewNoteList : List String -> Html Msg
viewNoteList notes =
  div
    []
    (List.map viewNote notes)

letterByNumber : Int -> Maybe Char
letterByNumber i =
  Array.get i (Array.fromList ['a', 'b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'])

letterToNote : Maybe Char -> String
letterToNote l =
  case l of
    Just letter ->
      toString letter

    Nothing ->
      "**note not found**"

removeFirstFromlist list =
  case List.tail list of
    Just sublist ->
      sublist

    Nothing ->
      []