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

options =
    time: no
    level: 5
    colors: yes
    default: 'info'

module.exports = (name) ->

    names.push name unless name in names

    if names.length > colorList.length
        console.log colors.red.bold 'Oops! Too many log names!!'

    logName = if options.colors then colorList[names.indexOf name] name else name

    formatter = (type, args) ->
        a = Array.prototype.slice.call args
        a.unshift logName
        a.unshift type
        a.unshift new Date().toJSON() if options.time
        console.log.apply null, a

    noop = (text) -> text

    def = -> def[options.default].apply null, arguments

    def.log =   -> if options.level > 0 then formatter (if options.colors then    colors.cyan else noop)('  LOG'), arguments
    def.info =  -> if options.level > 1 then formatter (if options.colors then    colors.blue else noop)(' INFO'), arguments
    def.warn =  -> if options.level > 2 then formatter (if options.colors then  colors.yellow else noop)(' WARN'), arguments
    def.err =   -> if options.level > 3 then formatter (if options.colors then     colors.red else noop)('  ERR'), arguments
    def.error = -> if options.level > 3 then formatter (if options.colors then     colors.red else noop)('  ERR'), arguments
    def.debug = -> if options.level > 4 then formatter (if options.colors then colors.magenta else noop)('DEBUG'), arguments

    def.options = (ops) ->
        options = Object.assign {}, options, ops
        def

    return def
