The CIE chromacity coordinates of standard illuminants were fetched from
Wikipedia, and written to modules in this directory. To replicate, run `coffee
README.litcoffee`.
    
    fs     = require 'fs'
    Krake  = require 'krake'
    Spider = new Krake {}

    mkModule = (res) ->
      moduleName   = res['name']
      functionName = moduleName.toLowerCase()
      fs.writeFileSync "#{moduleName}.hs", """
        module Data.Wright.CIE.Illuminant.#{moduleName} (#{functionName}) where

        import Data.Wright.Types (Environment)
        import Data.Wright.CIE.Illuminant (environment)

        #{functionName} :: Environment
        #{functionName} = environment (#{res['x']}, #{res['y']})
      """

    main = () ->
      Spider.scrape({
        url: "http://en.wikipedia.org/wiki/Standard_illuminant"
      , cols: 
          [ { desc: "name"
            , sel: '//*[@id="mw-content-text"]/table/tr/td[1]'
            , fn: (desc) -> desc.replace(/<[^>]+>/g,'')
            }
          , { desc: "x"
            , sel: '//*[@id="mw-content-text"]/table/tr/td[2]'
            } 
          , { desc: "y"
            , sel: '//*[@id="mw-content-text"]/table/tr/td[3]'
            }
          ]
      }).on 'retrieved', mkModule

    main()
