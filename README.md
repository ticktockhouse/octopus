# octopus

A collection of script(s) which interact with Octopus Energy's public API

## `octopus-daily.sh`

Gets the cost of electricity for the current half-hour period, plus the last half-hour and the next half hour.

Also gets the time when electricity will be cheapest before midnight, in the next 24 hours and before 4pm (there tends to be a 4pm-7pm peak daily)

Requires [httpie](https://httpie.io/) and [jq](https://stedolan.github.io/jq/)
