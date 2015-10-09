# [PoC] bun [![Build Status](https://travis-ci.org/k1LoW/bun.svg?branch=master)](https://travis-ci.org/k1LoW/bun)

bun = 文

Lazy Japanese text extractor.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bun', github: "k1LoW/bun"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install specific_install
    $ gem specific_install https://github.com/k1LoW/bun.git 

## Usage

Use like grep(?)

    $ bun index.html

    $ bun -n index.html

    $ find . -type f -name '*.erb' | bun -n

    $ curl https://fusic.github.io | bun -n

## Requirement

- [MeCab >= _0.996_](http://taku910.github.io/mecab/)

## Development Memo

### Add userdic

```
cd bun/lib/bun/userdic
/usr/local/Cellar/mecab/0.996/libexec/mecab/mecab-dict-index -d /usr/local/Cellar/mecab/0.996/lib/mecab/dic/ipadic -u symbol.dic -f utf-8 -t utf-8 symbol.csv
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/bun/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
