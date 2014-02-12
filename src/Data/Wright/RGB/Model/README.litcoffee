The specifications of popular RGB working spaces were fetched from a page of
Bruce Lindbloom's, and written to modules in this directory. To replicate, run
`coffee README.litcoffee`.

    fs = require 'fs'
    _  = require 'underscore'
    krake = require 'krake'

    Array::words      = ( ) -> this.join ' '
    String::withFirst = (f) -> this.replace(/^./, f) 
    String::normalise = ( ) -> this.replace(/[- ()\/]/g,'')

    processGamma = (gamma) ->
      gamma[0] == '≈'     && gamma='SRGB'
      gamma == 'L*'       && gamma='LStar'
      gamma.match(/\d+/)  && gamma='Gamma ' + gamma
      return gamma

    na = (s) -> 
      if s.match "-" then "undefined" else s

    mkModule = (res) ->
      thisModule  = res['name'].normalise().withFirst (s)->s.toUpperCase()
      env         = thisModule.withFirst (s)->s.toLowerCase()
      whiteModule = res['white']
      white       = whiteModule.toLowerCase()
      gamma       = processGamma (na res['gamma'])
      red         = _.values(res)[3..5].map(na).words()
      green       = _.values(res)[6..8].map(na).words()
      blue        = _.values(res)[9..11].map(na).words()
      fs.writeFileSync "#{thisModule}.hs", """
        module Data.Wright.RGB.Model.#{thisModule} (#{env}) where

        import Data.Wright.Types (Model(..), Primary(..), Gamma(..))
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
      table = (s) -> "//table[@summary='RGB Working Space Summary']/tbody/tr/td[#{s}]"
      new Krake({}).scrape({
        url: "http://www.brucelindbloom.com/WorkingSpaceInfo.html"
      , cols: 
          [ { desc: "name"   , sel: table 1  }
            { desc: "gamma"  , sel: table 2  }
            { desc: "white"  , sel: table 3  }
            { desc: "redx"   , sel: table 4  }
            { desc: "redy"   , sel: table 5  }
            { desc: "redY"   , sel: table 6  }
            { desc: "greenx" , sel: table 7  }
            { desc: "greeny" , sel: table 8  }
            { desc: "greenY" , sel: table 9  }
            { desc: "bluex"  , sel: table 10 }
            { desc: "bluey"  , sel: table 11 }
            { desc: "blueY"  , sel: table 12 }
          ]
      }).on 'retrieved', mkModule
    
    main()
