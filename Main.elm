module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random


type alias Model =
    { flipped : Bool
    , unlocked: Bool
    }


type Msg
    = GotRandom Bool
    | UnlockButton

update msg model =
    case msg of
        GotRandom b ->
            {model | flipped = b} ! []

        UnlockButton -> 
            {model | unlocked = True} ! []

main : Program Never Model Msg
main =
    Html.program
        { init = ( (Model False False), (Random.generate GotRandom Random.bool) )
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


introText =
    Html.text """
Hello! This is an experiment I'm conducting for a 200 level psychology course.
The experiment focuses on implicit biases with regard to race. Please, answer all questions
accurately, as the Implicit Association Test does not imply racism or explicit bias--
it is designed to measure implicit bias.
"""


testInstructions =
    Html.span []
        [ Html.a [ target "_blank", href "https://implicit.harvard.edu/implicit/selectatest.html" ] [ Html.text "Take the Race IAT " ]
        , Html.text "(Labeled Race ('Black - White' IAT) on the IAT website.) and enter your result in the form below."
        ]


surveyInstructions =
    Html.span []
        [ Html.a [ href "https://goo.gl/forms/ArqIFAtzKMMLyTUq1", target "_blank" ]
            [ Html.text "Take the survey "
            ]
        , Html.text "created for this experiment. Your results will be automatically submitted."
        ]


view : Model -> Html Msg
view model =
    let
        test =
            Html.li [] [ testInstructions ]

        survey =
            Html.li [] [ surveyInstructions ]

        l_ =
            if model.flipped then
                Html.ol [] [ test, survey ]
            else
                Html.ol [] [ survey, test ]

    in
        div [ mfs ]
            [ h1 [ mfsHx ] [ Html.text "Implicit Association Test: Race" ]
            , p []
                [ introText
                , l_
                , Html.text "What was your result on the IAT?"
                , Html.form [action "https://formspree.io/yux60000@gmail.com", method "POST"]
                    [ input [ type_ "radio", name "result", value "1", onClick UnlockButton] [ ]
                    , Html.text "Strong auotmatic preference for White people over Black pepole"
                    , br [] []

                    , input [ type_ "radio", name "result", value "2", onClick UnlockButton ] [ ]
                    , Html.text "Moderate automatic preference for White people over Black pepole"
                    , br [] []

                    , input [ type_ "radio", name "result", value "3", onClick UnlockButton ] [ ]
                    , Html.text "Slight automatic preference for White people over Black pepole"
                    , br [] []

                    , input [ type_ "radio", name "result", value "4", onClick UnlockButton ] [ ]
                    , Html.text "Neutral/No automatic preference"
                    , br [] []

                    , input [ type_ "radio", name "result", value "5", onClick UnlockButton ] [ ]
                    , Html.text "Slight automatic preference for Black people over White pepole"
                    , br [] []

                    , input [ type_ "radio", name "result", value "6", onClick UnlockButton ] [ ]
                    , Html.text "Moderate automatic preference for Black people over White pepole"
                    , br [] []

                    , input [ type_ "radio", name "result", value "7", onClick UnlockButton ] [ ]
                    , Html.text "Strong automatic preference for Black people over White pepole"
                    , br [] []

                    , input [type_ "submit", disabled <| not model.unlocked] [Html.text "Submit"]
                    ]
                    , Html.br [] []
                    , Html.text "Thank you for completing this experiment!"
                ]
            ]


mfs : Attribute msg
mfs =
    style
        [ ( "margin", "40px auto" )
        , ( "max-width", "650px" )
        , ( "line-height", "1.6" )
        , ( "font-size", "18px" )
        , ( "color", "#444" )
        , ( "padding", "0 10px" )
        ]


mfsHx : Attribute msg
mfsHx =
    style
        [ ( "line-height", "1.2" )
        ]
