The specifications of popular RGB working spaces were fetched from a page of
Bruce Linderbloom's, and written to modules in this directory. To replicate,
run `coffee README.litcoffee`.

Please note: (1) the L-star gamma function, as used in ECI RGB v2, is undefined
until I figure out how it works; (2) the sRGB gamma value is approximate.

    fs = require 'fs'
    _  = require 'underscore'
    krake = require 'krake'

    Array::words      = ( ) -> this.join ' '
    String::withFirst = (f) -> this.replace(/^./, f) 
    String::normalise = ( ) -> this.replace(/[- ()\/]/g,'')

    mkModule = (res) ->
      thisModule  = res['name'].normalise().withFirst (s)->s.toUpperCase()
      env         = thisModule.withFirst (s)->s.toLowerCase()
      whiteModule = res['white']
      white       = whiteModule.toLowerCase()
      na          = (s) -> if s.match "-" then "undefined" else s
      gamma       = na res['gamma'].replace('≈','').replace('L*', 'undefined')
      red         = _.values(res)[3..5].map(na).words()
      green       = _.values(res)[6..8].map(na).words()
      blue        = _.values(res)[9..11].map(na).words()
      fs.writeFileSync "#{thisModule}.hs", """
        module Data.Wright.RGB.Model.#{thisModule} (#{env}) where

        import Data.Wright.Types (Model(..), Primary(..))
        import Data.Wright.CIE.Illuminant.#{whiteModule} (#{white})

        #{env} :: Model
        #{env} = #{white}
          { gamma = #{gamma}
          , red   = Primary #{red}
          , green = Primary #{green}
          , blue  = Primary #{blue}
          }
      """

    main = () ->
      table = (s0) -> "//table[@summary='RGB Working Space Summary']/tbody/tr/#{s0}"
      new Krake({}).scrape({
        url: "http://www.brucelindbloom.com/WorkingSpaceInfo.html"
      , cols: 
          [ { desc: "name"   , sel: table 'td[1]' }
            { desc: "gamma"  , sel: table 'td[2]' }
            { desc: "white"  , sel: table 'td[3]' }
            { desc: "redx"   , sel: table 'td[4]' }
            { desc: "redy"   , sel: table 'td[5]' }
            { desc: "redY"   , sel: table 'td[6]' }
            { desc: "greenx" , sel: table 'td[7]' }
            { desc: "greeny" , sel: table 'td[8]' }
            { desc: "greenY" , sel: table 'td[9]' }
            { desc: "bluex"  , sel: table 'td[10]'}
            { desc: "bluey"  , sel: table 'td[11]'}
            { desc: "blueY"  , sel: table 'td[12]'}
          ]
      }).on 'retrieved', mkModule

    main()
