! Copyright (C) 2011 Fred Alger.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel sequences mirrors strings
calendar make assocs slots classes combinators sets ;

IN: qr-codes.mecard

TUPLE: mecard { name string } { reading string } { telephone string }
    { videophone string } { email string } { memo string }
    { birthday timestamp } { address string } { url string }
    { nickname string } ;

: mecard-phone ( str -- str )
    [ "-+" in? not ] filter ;

: mecode-fields ( -- assoc ) 
    H{  { "name" "N" }
        { "reading" "SOUND" }
        { "telephone" "TEL" }
        { "videophone" "TEL-AV" }
        { "email" "EMAIL" }
        { "memo" "NOTE" }
        { "birthday" "BDAY" }
        { "address" "ADR" }
        { "url" "URL" }
        { "nickname" "NICKNAME" } } ;

: translate-value ( key value -- key value' )
    over
    {
        { "TEL"    [ mecard-phone ] }
        { "TEL-AV" [ mecard-phone ] }
        [ drop ]
    } case ;

: mecard-translate ( key value -- key' value' )
   [ mecode-fields at ] dip translate-value ;

: translate-keys-to-mecard ( assoc -- assoc )
    [ nip dup class initial-value = not ] assoc-filter
    [ mecard-translate ] assoc-map ;

: (mecard) ( assoc -- str )
    [ "MECARD:" % [ ":" join % ";" % ] each ";" % ] "" make ;

: >mecard ( obj -- str )
    <mirror> translate-keys-to-mecard (mecard) ;
