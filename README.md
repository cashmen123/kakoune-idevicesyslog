# kakoune-idevicesyslog

[![IRC][IRC Badge]][IRC]

[kakoune](http://kakoune.org) plugin for piping libimobiledevice's idevicesyslog output to a fifo buffer with optional grep pattern

## Setup

Add `idevicesyslog.kak` to your autoload directory,`~/.config/kak/autoload`, or source it manually.

## Usage

`:idevicesyslog [<arguments>]: open a fifo iOS syslog buffer`

`<arguments>` can contain grep switches and search patterns to limit syslog output to desired patterns

## License

Unlicense

[IRC]: https://webchat.freenode.net?channels=kakoune
[IRC Badge]: https://img.shields.io/badge/IRC-%23kakoune-blue.svg
