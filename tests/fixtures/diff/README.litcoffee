Sample colour differences were generated against a reference implementation at
<http://www.brucelindbloom.com/javascript/ColorDiff.js>, which is assumed to be
safe and correct. To replicate, run `coffee README.litcoffee`.
    
    [path, fs, _] = ['path', 'fs', 'underscore'].map require
    library       = path.resolve(__dirname, '..', '..', '..', 'vendor', 'brucelindbloom.com', 'ColorDiff.js')
    eval fs.readFileSync(library, 'utf8')

The range of coordinates (a,b) aren't necessarily in 1..100 (the range depends
on the source space), but this serves for testing purposes:

    r = () -> 100 * Math.random()
    labReferences = [1..200].map () -> [r(), r(), r()]
    labSamples    = [1..200].map () -> [r(), r(), r()]

Values are set to and retrieved from globals:

    cie76 = (ref, spl) ->
      [Lab1.L, Lab1.a, Lab1.b] = ref
      [Lab2.L, Lab2.a, Lab2.b] = spl
      DeltaE1976(); DE1976

    cie94 = (ref, spl) -> 
      [Lab1.L, Lab1.a, Lab1.b] = ref
      [Lab2.L, Lab2.a, Lab2.b] = spl
      DeltaE1994(true); DeltaE1994(false)
      [DE1994_Textiles, DE1994_GraphicArts]

    cie2k = (ref, spl) -> 
      [Lab1.L, Lab1.a, Lab1.b] = ref
      [Lab2.L, Lab2.a, Lab2.b] = spl
      DeltaE2000(); DE2000

Write to CSV:

    Array::flatten = () -> _.flatten this
    lines = _.zip(labReferences, labSamples).map ([ref, spl]) ->
      [ref, spl, cie76(ref,spl), cie94(ref,spl),cie2k(ref,spl)].flatten().join(',')
    fs.writeFileSync path.resolve(__dirname, 'diff.csv'), lines.join('\n')
