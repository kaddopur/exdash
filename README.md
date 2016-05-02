# Exdash

[![Build Status](https://travis-ci.org/TFarla/exdash.svg?branch=master)](https://travis-ci.org/TFarla/exdash)
[![Coverage Status](https://coveralls.io/repos/github/TFarla/exdash/badge.svg?branch=master)](https://coveralls.io/github/TFarla/exdash?branch=master)
[![hex.pm version](https://img.shields.io/hexpm/v/exdash.svg)](https://hex.pm/packages/exdash) [![hex.pm downloads](https://img.shields.io/hexpm/dt/exdash.svg)](https://hex.pm/packages/exdash)
## Installation
1. Add exdash to your list of dependencies in `mix.exs`:
```
  def deps do
    [{:exdash, "~> 0.3.1"}]
  end
```

2. Ensure exdash is started before your application:
```
  def application do
    [applications: [:exdash]]
  end
```

## Change log
Read the [CHANGELOG.md](CHANGELOG.md)

## Contributing
Read the [contribution guide](CONTRIBUTING.md)

## Roadmap
### Array
- [ ] chunk
- [ ] compact
- [ ] concat
- [ ] difference
- [ ] differenceBy
- [ ] differenceWith
- [ ] drop
- [ ] dropRight
- [ ] dropRightWhile
- [ ] dropWhile
- [ ] fill
- [ ] findIndex
- [ ] findLastIndex
- [ ] first → head
- [ ] flatten
- [ ] flattenDeep
- [ ] flattenDepth
- [ ] fromPairs
- [ ] head
- [ ] indexOf
- [ ] initial
- [ ] intersection
- [ ] intersectionBy
- [ ] intersectionWith
- [ ] join
- [ ] last
- [ ] lastIndexOf
- [ ] nth
- [ ] pull
- [ ] pullAll
- [ ] pullAllBy
- [ ] pullAllWith
- [ ] pullAt
- [ ] remove
- [ ] reverse
- [ ] slice
- [ ] sortedIndex
- [ ] sortedIndexBy
- [ ] sortedIndexOf
- [ ] sortedLastIndex
- [ ] sortedLastIndexBy
- [ ] sortedLastIndexOf
- [ ] sortedUniq
- [ ] sortedUniqBy
- [ ] tail
- [ ] take
- [ ] takeRight
- [ ] takeRightWhile
- [ ] takeWhile
- [ ] union
- [ ] unionBy
- [ ] unionWith
- [ ] uniq
- [ ] uniqBy
- [ ] uniqWith
- [ ] unzip
- [ ] unzipWith
- [ ] without
- [ ] xor
- [ ] xorBy
- [ ] xorWith
- [ ] zip
- [ ] zipObject
- [ ] zipObjectDeep
- [ ] zipWith

## [Collection]
- [ ] countBy
- [ ] each → forEach
- [ ] eachRight → forEachRight
- [x] every
- [x] pevery
- [x] filter
- [x] pfilter
- [x] find
- [x] pfind
- [x] find_last
- [x] pfind_last
- [ ] flatMap
- [ ] flatMapDeep
- [ ] flatMapDepth
- [ ] forEach
- [ ] forEachRight
- [ ] groupBy
- [ ] includes
- [ ] invokeMap
- [ ] keyBy
- [ ] map
- [ ] orderBy
- [ ] partition
- [ ] reduce
- [ ] reduceRight
- [ ] reject
- [ ] sample
- [ ] sampleSize
- [ ] shuffle
- [ ] size
- [ ] some
- [ ] sortBy

### [Function]
- [x] after_nth
- [ ] ary
- [x] before_nth
- [ ] bind
- [ ] bindKey
- [x] call_times
- [x] curry
- [ ] curryRight
- [ ] debounce
- [ ] defer
- [ ] delay
- [ ] flip
- [ ] memoize
- [ ] negate
- [x] once
- [ ] overArgs
- [x] partial
- [ ] partialRight
- [ ] rearg
- [ ] rest
- [ ] spread
- [ ] throttle
- [ ] unary
- [x] wrap

### Math
- [ ] add
- [ ] ceil
- [ ] divide
- [ ] floor
- [ ] max
- [ ] maxBy
- [ ] mean
- [ ] meanBy
- [ ] min
- [ ] minBy
- [ ] multiply
- [ ] round
- [ ] subtract
- [ ] sum
- [ ] sumBy

### Number
- [ ] clamp
- [ ] inRange
- [ ] random

### [String]
- [x] camel_case
- [ ] capitalize
- [ ] deburr
- [ ] endsWith
- [ ] escape
- [ ] escapeRegExp
- [x] kebab_case
- [ ] down_case
- [x] downcase_first
- [ ] pad
- [ ] padEnd
- [ ] padStart
- [ ] parseInt
- [ ] repeat
- [ ] replace
- [ ] snakeCase
- [ ] split
- [ ] startCase
- [ ] startsWith
- [ ] template
- [ ] toLower
- [ ] toUpper
- [ ] trim
- [ ] trimEnd
- [ ] trimStart
- [ ] truncate
- [ ] unescape
- [ ] upperCase
- [x] upcase_first
- [x] words

[Collection]: https://hexdocs.pm/exdash/0.3.0/Exdash.Collection.html
[Function]: https://hexdocs.pm/exdash/0.3.0/Exdash.Function.html
[String]: https://hexdocs.pm/exdash/0.3.0/Exdash.String.html
