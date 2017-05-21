# smalllog

Smalllog is a simple console logging system for nodejs using colors and logging levels.

## instalation

```bash
npm i -S smalllog
```

## configuration

There is a few global parameters you can set:

name   | default | description
----------|:--------:|-----------------------------------------
colors    | true    | use color in console output
time      | false   | show timestamp on output
level     | 5         | threshold point to show messages
default | 'none'  | which message to show when you call directly

## usage

![example](./example.png)

You can use levels:

- 0 - `none`, `n` 
- 1 - `log`, `l`
- 2 - `info`, `i`
- 3 - `warn`, `w`
- 4 - `error`, `err`, `e`
- 5 - `debug`, `d`

```javascript
// initialize with default parameters
log = require('smalllog')('Worker')

// initialize with non defaults
log = require('smalllog')('AppName', {default: 'info'})

log.none('I have no level')
sub = 'substituition'
log.log('I´m using %s with objects: %o', sub, {key: 'value'});
log.info('message content', 2, 'string', {obj: true});
log.warn('an warning...');
val = 'of arguments'
log.l('message content', 'can', 'have', 'any number', val);
log.log('but will substitute only on first argument');
log.debug('so, I´ll fail', 'at using %s', 'substituition');

// if you call log directly it will default to the `option.default`
log('this will default to `info` due to use of options above!');

// unless its argument are an Error instance, in this case it will use error level
err = new Error('Oh crap!');
log(err);

// if you create another logger with another name then it´ll use another color

// if you create another logger with the SAME name it uses the same color

// colors are based on order of creation

log2 = require('smalllog')('API');
log3 = require('smalllog')('Database', {time: true}); // remember options are global...
log4 = require('smalllog')('HTTP');

// ... so all 3 entries bellow will have timestamps

log2('will be using another color!');
log3.w('will be using another color!');
log4.d('will be using another color too!');

```
