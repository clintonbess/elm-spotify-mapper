module Playlist.View.Playlist exposing (..)

import BottomBar.Msgs as Player
import BottomBar.View.Player exposing (controlIcon)
import Helpers exposing (cssClass, toSpotifyTrack)
import Html exposing (Html, div, i, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import List.Extra exposing (elemIndex)
import Models exposing (Model)
import Msgs exposing (Msg(MsgForPlayer))
import Playlist.Style exposing (Classes(CloseIcon, Icons, PauseIcon, PlayIcon, PlaylistPage, PlaylistSongs, RightIcons, Song, SongInfo, SongName, SongNumber, SongPlaying, SpeakerIcon))
import Playlist.View.Info exposing (playlistInfo)
import Spotify.Models exposing (Track)


formatArtists : List String -> Html Msg
formatArtists artists =
    span [ cssClass [ SongInfo ] ]
        (List.map
            (\artist -> span [] [ text artist ])
            artists
        )


song : Int -> Bool -> Track -> Html Msg
song trackNumber isPlaying track =
    let
        songClasses =
            if isPlaying then
                [ Song, SongPlaying ]
            else
                [ Song ]
    in
    div [ cssClass songClasses ]
        [ span [ cssClass [ SongNumber ] ] [ text <| toString trackNumber ++ "." ]
        , div
            [ cssClass [ Icons ] ]
            [ i
                [ cssClass [ SpeakerIcon ]
                , class "fa fa-volume-up"
                ]
                []
            , i
                [ cssClass [ PauseIcon ]
                , class "fa fa-pause"
                ]
                []
            , i
                [ cssClass [ PlayIcon ]
                , class "fa fa-play"
                , onClick (Msgs.MsgForPlayer (Player.Play track.preview_url))
                ]
                []
            ]
        , div []
            [ span [ cssClass [ SongName ] ] [ text track.name ]
            , formatArtists track.artists
            ]
        , div [ cssClass [ RightIcons ] ]
            [ i
                [ cssClass [ CloseIcon ]
                , class "fa fa-close"
                ]
                []
            ]
        ]


playlist : Model -> Html Msg
playlist model =
    div [ cssClass [ PlaylistSongs ] ]
        (List.map
            (\track ->
                let
                    index =
                        case elemIndex track model.playlist.tracks of
                            Just value ->
                                value + 1

                            Nothing ->
                                0

                    isPlaying =
                        case model.selectedTrack of
                            Just selectedTrack ->
                                let
                                    currentTrack =
                                        toSpotifyTrack selectedTrack
                                in
                                currentTrack == track

                            Nothing ->
                                False
                in
                song index isPlaying track
            )
            model.playlist.tracks
        )


render : Model -> List (Html Msg)
render model =
    [ div [ cssClass [ PlaylistPage ] ]
        [ playlistInfo model
        , playlist model
        ]
    ]
