! Copyright (C) 2011 Fred Alger.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel sequences images.http assocs combinators
urls.encoding sets ;

IN: qr-codes

CONSTANT: chart-size "350x350"

: gchart-base-url ( -- str )
    "http://chart.apis.google.com/chart?cht=qr&chs=" chart-size "&chl="
    append append  ;

: gchart-url ( str -- str ) 
    url-encode gchart-base-url "&dummy=.png" surround ;

: qr-image ( str -- image )
    gchart-url load-http-image ;
