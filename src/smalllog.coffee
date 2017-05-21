###

--- smalllog ---

Released under MIT license.

by Gustavo Vargas - @xgvargas - 2017

Original coffee code and issues at: https://github.com/xgvargas/smalllog

###

colors = require 'colors'

colorList = [
    colors.white
    colors.cyan
    colors.blue
    colors.red
    colors.green
    colors.yellow
    colors.magenta
    colors.gray
    colors.white.bgCyan
    colors.blue.bgCyan
    colors.red.bgCyan
    colors.green.bgCyan
    colors.yellow.bgCyan
    colors.magenta.bgCyan
    colors.gray.bgCyan
    colors.white.bgMagenta
    colors.cyan.bgMagenta
    colors.blue.bgMagenta
    colors.red.bgMagenta
    colors.green.bgMagenta
    colors.yellow.bgMagenta
    colors.gray.bgMagenta
    colors.white.bgBlue
    colors.cyan.bgBlue
    colors.red.bgBlue
    colors.green.bgBlue
    colors.yellow.bgBlue
    colors.magenta.bgBlue
    colors.gray.bgBlue
]

names = []
opt =
    time: no
    level: 5
    colors: yes
    default: 'none'

module.exports = (name, options) ->

    opt = Object.assign {}, opt, options if options

    names.push name unless name in names

    console.log colors.red.bold 'Oops! Too many log names!!' if names.length > colorList.length

    logName = if opt.colors then colorList[names.indexOf name] name else name

    formatter = (type, args) ->
        text = ''
        text += new Date().toJSON() + ' ' if opt.time
        text += "#{type} #{logName} "
        unless /%[sdo]/.test args[0]
            text += arg + ' ' for arg in args
        else
            try
                n = 0
                text += args[0].replace /%([sdo])/g, (a, b) ->
                    v = args[++n]
                    switch b
                        when 's' then v
                        when 'd' then '' + v
                        when 'o' then JSON.stringify v
                        else '---'

        console.log text

    noop = (text) -> text

    def = ->
        if arguments[0] instanceof Error
            def.error.apply null, arguments
        else
            def[opt.default].apply null, arguments

    def.none =  -> formatter '     ', arguments
    def.log =   -> if opt.level > 0 then formatter (if opt.colors then    colors.cyan else noop)('  LOG'), arguments
    def.info =  -> if opt.level > 1 then formatter (if opt.colors then    colors.blue else noop)(' INFO'), arguments
    def.warn =  -> if opt.level > 2 then formatter (if opt.colors then  colors.yellow else noop)(' WARN'), arguments
    def.error = -> if opt.level > 3 then formatter (if opt.colors then     colors.red else noop)('  ERR'), arguments
    def.debug = -> if opt.level > 4 then formatter (if opt.colors then colors.magenta else noop)('DEBUG'), arguments

    def.n = def.none
    def.l = def.log
    def.i = def.info
    def.w = def.warn
    def.err = def.error
    def.e = def.error
    def.d = def.debug

    def
