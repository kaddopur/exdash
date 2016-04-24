# Exdash

[![Build Status](https://travis-ci.org/TFarla/exdash.svg?branch=master)](https://travis-ci.org/TFarla/exdash)
[![Coverage Status](https://coveralls.io/repos/github/TFarla/exdash/badge.svg?branch=master)](https://coveralls.io/github/TFarla/exdash?branch=master)

## Installation
1. Add exdash to your list of dependencies in `mix.exs`:
```
  def deps do
    [{:exdash, "~> 0.0.1"}]
  end
```

2. Ensure exdash is started before your application:
```
  def application do
    [applications: [:exdash]]
  end
```
