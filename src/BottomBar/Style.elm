module BottomBar.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (input)
import Css.Namespace exposing (namespace)
import CssClasses
import Html.CssHelpers exposing (withNamespace)


type Classes
    = BottomBar
    | NowPlaying
    | AlbumCover
    | MusicInfo
    | MusicTitle
    | ProgressGroup
    | Controls
    | ProgressBar
    | Progress
    | FontSmall
    | ControlIcon
    | Icon
    | ControlButtons
    | SoundControl


css =
    (stylesheet << namespace "")
        [ class BottomBar
            [ backgroundColor <| hex "282828"
            , color <| hex "FFF"
            , displayFlex
            , height <| px 90
            , padding3 zero (px 16) (px 10)
            , displayFlex
            , alignItems center
            , justifyContent center
            ]
        , class NowPlaying
            [ displayFlex
            , alignItems center
            , height <| px 56
            , width <| px 225
            , overflow hidden
            , children
                [ class AlbumCover
                    [ width <| px 56
                    , height <| px 56
                    ]
                , class MusicInfo
                    [ displayFlex
                    , flexDirection column
                    , paddingLeft <| px 10
                    , height <| pct 100
                    , justifyContent center
                    , children
                        [ class MusicTitle
                            [ fontSize <| px 14
                            , lineHeight <| px 24
                            , maxWidth <| px 150
                            , overflow hidden
                            , textOverflow ellipsis
                            , whiteSpace noWrap
                            ]
                        ]
                    ]
                ]
            ]
        , class ProgressGroup
            [ displayFlex
            , alignItems center
            , justifyContent center
            ]
        , class Controls
            [ displayFlex
            , flexDirection column
            , flex (int 1)
            ]
        , class ProgressBar
            [ backgroundColor <| hex "404040"
            , width <| pct 50
            , height <| px 4
            , borderRadius <| px 10
            , displayFlex
            , margin2 zero <| px 10
            , position relative
            , children
                [ input
                    [ width <| pct 100
                    , height <| pct 100
                    , marginTop zero
                    , zIndex <| int 2
                    ]
                , class Progress
                    [ backgroundColor <| hex "a0a0a0"
                    , width <| pct 0
                    , height <| pct 100
                    , borderRadius <| px 10
                    , position absolute
                    ]
                ]
            ]
        , class FontSmall
            [ fontSize <| px 11
            , lineHeight <| px 20
            , fontWeight <| int 300
            , letterSpacing <| px 0.8
            ]
        , class ControlIcon
            [ width <| px 32
            , height <| px 32
            , textAlign center
            , children
                [ class Icon
                    [ lineHeight <| px 32
                    , fontSize <| px 18
                    ]
                ]
            ]
        , class ControlButtons
            [ displayFlex
            , flexDirection row
            , height <| px 50
            , justifyContent center
            , alignItems center
            ]
        , class SoundControl
            [ displayFlex
            , flex <| int 1
            , maxWidth <| px 200
            , alignItems center
            ]
        ]
