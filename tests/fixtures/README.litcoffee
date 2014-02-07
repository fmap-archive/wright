The CIE AFAICT don't publish reference translation tables, so we generate some
with the code at <http://www.brucelindbloom.com/javascript/ColorConv.js> (which
is assumed to be correct and safe.)

    [path, fs, _] = ['path', 'fs', 'underscore'].map require
    library       = path.resolve(__dirname, '..', '..', 'vendor', 'brucelindbloom.com', 'ColorConv.js')
    eval fs.readFileSync(library, 'utf8')

We consider the translation of 400 SRGB vectors with values scaled to the open
interval [0,1]:

    r     = () -> Math.random()
    sRGBs = [1..400].map () -> [r(), r(), r()]

    form =
      RGBModel:   { selectedIndex: 14 } # sRGB
      Gamma:      { selectedIndex: 0  } # sRGB
      Adaptation: { selectedIndex: 3  } # None
      RefWhite:   { selectedIndex: 5  } # D65
    RGBModelChange form

Lindbloom's functions depend heavily on global variables; we define wrappers
that set these based on arguments, and recover the set results:

    FillAllCells = () -> null

    toXYZ = (rgb) ->
      [form.RGB_R, form.RGB_G, form.RGB_B] = rgb.map (v) -> {value: v}
      ButtonRGB(form)
      return [XYZ.X, XYZ.Y, XYZ.Z]

    toLAB = (rgb) -> 
      [form.RGB_R, form.RGB_G, form.RGB_B] = rgb.map (v) -> {value: v}
      ButtonRGB(form)
      return [Lab.L, Lab.a, Lab.b]
    
    toYxy = (rgb) -> 
      [form.RGB_R, form.RGB_G, form.RGB_B] = rgb.map (v) -> {value: v}
      ButtonRGB(form)
      return [xyY.Y, xyY.x, xyY.y]

That's all we need to test functions in any direction.

    Array::flatten = () -> _.flatten this
    lines = sRGBs.map (rgb) -> [rgb, toXYZ(rgb), toLAB(rgb), toYxy(rgb)].flatten().join(',')
    fs.writeFileSync path.resolve(__dirname, 'conv.csv'), lines.join('\n')
